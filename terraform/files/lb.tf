resource "yandex_lb_network_load_balancer" "lb" {
  name = "reddit-app-balancer"

  listener {
    name        = "reddit-app"
    port        = 8080
    target_port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "b7ri2h3nfjfebvhvdjra"

    healthcheck {
      name = "http"
      http_options {
        port = 9292
        path = "/"
      }
    }
  }
}