resource "cloudfoundry_app" "nginx" {
  name       = "nginx"
  space      = cloudfoundry_space.space.id
  memory     = 256
  disk_quota = 256
  path       = "${path.module}/nginx-reverse-proxy.zip"
  buildpack  = "https://github.com/cloudfoundry/nginx-buildpack.git"

  routes {
    route = cloudfoundry_route.route.id
  }

  depends_on = [data.archive_file.fixture]
}

resource "cloudfoundry_route" "route" {
  domain   = data.cloudfoundry_domain.domain.id
  space    = cloudfoundry_space.space.id
  hostname = "api-gateway-${random_id.id.hex}"

  depends_on = [cloudfoundry_space_users.users]
}

resource "cloudfoundry_network_policy" "users_policy" {
  policy {
    source_app      = cloudfoundry_app.nginx.id
    destination_app = cloudfoundry_app.users_api.id
    port            = "8080"
  }
}

resource "cloudfoundry_network_policy" "devices_policy" {
  policy {
    source_app      = cloudfoundry_app.nginx.id
    destination_app = cloudfoundry_app.devices_api.id
    port            = "8080"
  }
}

resource "local_file" "nginx_conf" {
  filename = "${path.module}/nginx-reverse-proxy/nginx.conf"
  content  = <<EOF
worker_processes 1;
daemon off;
error_log stderr;
events { worker_connections 1024; }
pid /tmp/nginx.pid;
http {
  charset utf-8;
  log_format cloudfoundry 'NginxLog "$request" $status $body_bytes_sent';
  access_log /dev/stdout cloudfoundry;
  default_type application/octet-stream;
  include mime.types;
  sendfile on;
  tcp_nopush on;
  keepalive_timeout 30;
  port_in_redirect off; # Ensure that redirects don't include the internal container PORT - 8080
  resolver 169.254.0.2;
  
  server {
      set $users_api "http://users-api-${random_id.id.hex}.${data.cloudfoundry_domain.internal_domain.name}:8080";
      set $devices_api "http://devices-api-${random_id.id.hex}.${data.cloudfoundry_domain.internal_domain.name}:8080";

      listen {{port}}; # This will be replaced by CF magic. Just leave it here.
      index index.html index.htm Default.htm;

      location / {
         root public;
      }
      
      location /api/users {
        proxy_pass $users_api;
      }
      location /api/devices {
        proxy_pass $devices_api;
      }
  }
}
EOF
}

data "archive_file" "fixture" {
  type        = "zip"
  source_dir  = "${path.module}/nginx-reverse-proxy"
  output_path = "${path.module}/nginx-reverse-proxy.zip"
  depends_on  = [local_file.nginx_conf]
}
