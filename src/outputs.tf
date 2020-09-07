output "url" {
  value = cloudfoundry_route.route.endpoint
}

output "space" {
  value = cloudfoundry_space.space.name
}
