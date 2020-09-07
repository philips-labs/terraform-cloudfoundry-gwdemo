data "cloudfoundry_org" "org" {
  name = var.cf_org_name
}

data "cloudfoundry_user" "user" {
  name   = var.cf_username
  org_id = data.cloudfoundry_org.org.id
}

data "cloudfoundry_domain" "domain" {
  name = var.cf_app_domain
}

data "cloudfoundry_domain" "internal_domain" {
  name = "apps.internal"
}

data "cloudfoundry_service" "s3" {
  name = "hsdp-s3"
}

data "cloudfoundry_service" "metrics" {
  name = "hsdp-metrics"
}

data "cloudfoundry_service" "rds" {
  name = "hsdp-rds"
}
