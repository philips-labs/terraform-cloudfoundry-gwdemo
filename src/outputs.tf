output "url" {
  value = cloudfoundry_route.route.endpoint
}

output "space" {
  valeu = cloudfoundry_space.space.name
}
