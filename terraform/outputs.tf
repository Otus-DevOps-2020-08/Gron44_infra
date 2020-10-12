output "externals_ip_address_app" {
  value = [for app in yandex_compute_instance.app :
  app.network_interface.0.nat_ip_address]
}

/*
output "external_ip_address_lb" {
  //ToDo: Возможно задать адрес более лаконично?
  value = [for addres in
    [for listener in yandex_lb_network_load_balancer.lb.listener :
    listener.external_address_spec].0 :
  addres.address].0
}
*/
