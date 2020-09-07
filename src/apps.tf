resource "cloudfoundry_app" "users_api" {
  name      = "users-api"
  path      = "${path.module}/users-api.zip"
  buildpack = "go_buildpack"
  space     = cloudfoundry_space.space.id

  routes {
    route = cloudfoundry_route.users_api.id
  }
 
  depends_on = [data.archive_file.users_api]
}

resource "cloudfoundry_route" "users_api" {
  domain   = data.cloudfoundry_domain.internal_domain.id
  space    = cloudfoundry_space.space.id
  hostname = "users-api-${random_id.id.hex}"

  depends_on = [cloudfoundry_space_users.users]
}

data "archive_file" "users_api" {
  type        = "zip"
  source_dir  = "${path.module}/apps/users-api"
  output_path = "${path.module}/users-api.zip"
}


resource "cloudfoundry_app" "devices_api" {
  name      = "devices-api"
  path      = "${path.module}/devices-api.zip"
  buildpack = "go_buildpack"
  space     = cloudfoundry_space.space.id

  routes {
    route = cloudfoundry_route.devices_api.id
  }

  depends_on = [data.archive_file.devices_api]
}

resource "cloudfoundry_route" "devices_api" {
  domain   = data.cloudfoundry_domain.internal_domain.id
  space    = cloudfoundry_space.space.id
  hostname = "devices-api-${random_id.id.hex}"

  depends_on = [cloudfoundry_space_users.users]
}

data "archive_file" "devices_api" {
  type        = "zip"
  source_dir  = "${path.module}/apps/devices-api"
  output_path = "${path.module}/devices-api.zip"
}


