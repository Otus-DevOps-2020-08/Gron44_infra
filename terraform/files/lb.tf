resource "yandex_lb_target_group" "lb-target" {
  name      = "main-target"
  region_id = var.region_id

  dynamic target {
    for_each = yandex_compute_instance.app
    content {
      subnet_id = var.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}

resource "yandex_lb_network_load_balancer" "lb" {
  name = "lb-main"

  listener {
    name = "my-listener"
    port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_lb_target_group.lb-target.id}"

    healthcheck {
      name = "http"
      http_options {
        port = 9292
        //default path = "/"
      }
    }
  }
}
