output "vm_ip" {
  description = "Зовнішня IP-адреса віртуальної машини"
  value       = google_compute_instance.web_server.network_interface[0].access_config[0].nat_ip
}

output "vm_name" {
  description = "Ім'я віртуальної машини"
  value       = google_compute_instance.web_server.name
}

output "vm_image" {
  description = "Ім'я образу використаного для створення ВМ"
  value       = google_compute_instance.web_server.boot_disk[0].initialize_params[0].image
}

output "website_url" {
  description = "Повна адреса (URL) налаштованого сервісу"
  value       = "http://${google_compute_instance.web_server.network_interface[0].access_config[0].nat_ip}:${var.web_port}"
}