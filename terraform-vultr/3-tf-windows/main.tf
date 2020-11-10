# Create a Windows server
resource "vultr_server" "my_server" {
  plan_id     = "203"
  region_id   = "40"
  os_id       = "240"
  label       = "win-server-label"
  tag         = "win-server-tag"
  hostname    = "win-server"
  user_data   = "{'foo': true}"
  enable_ipv6 = true
  auto_backup = true
  # ddos_protection = true
  notify_activate = false
}

# Output
output "ip" {
  value = vultr_server.my_server.*.main_ip
}

output "password" {
  value = vultr_server.my_server.*.default_password
}