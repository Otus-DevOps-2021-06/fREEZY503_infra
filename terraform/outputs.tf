output "external_ips" {
  value = [for i in yandex_compute_instance.app : i.network_interface.0.nat_ip_address]
}

output "external_ip_address_balancer" {
  value = yandex_lb_network_load_balancer.lb.listener.*.external_address_spec
}