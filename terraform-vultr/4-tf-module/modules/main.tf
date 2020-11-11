# Create a web server
resource "vultr_server" "this" {
  count = var.number_of_servers

  label            = "server-${count.index + 1}"
  hostname         = "server-${count.index + 1}"
#   default_password = var.default_password

  plan_id   = var.plan_id
  region_id = var.region_id
  os_id     = var.os_id

  tag = "tag-server-${count.index + 1}"

  user_data = length(var.user_data) == 0 ? "" : var.user_data

  enable_ipv6 = var.enable_ipv6

  auto_backup = var.auto_backup
}