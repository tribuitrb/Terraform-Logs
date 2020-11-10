# SSH Key
resource "vultr_ssh_key" "ssh_key" {
  name    = "ssh-key"
  ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAiO0wEVpgwRvuVdCt5WeOzDkYS6z2uzc0OSvC3dK25SKkwU2Mwb8aDHjaJkfmA9tb1L763x4IAx6e11JLCA0W2+iuxI8uaisgbo/FeZu7T9A6JHg54KvnvhvEnDhv3W18Zxz0ZCbERYB5f7SHpUONeKH86XEduQFbSyuMCUNvp2yCCaEPt8dZgcr7hxAVD+zECUB9C0lfU5098fw1A92RLlUWg8dmOccLAyv1RgNc+rE5p3g6aF4l6KjUQFbyNFRhzY1Ns7g/iruiLLSqcuk7Jddpss1sYjTJmJOKH1OaJj0HX2k9XwOjUfyI0fkkp1opSaD8H5VNFEGH4+f1JEj3MQ== trb-rsa-key"
}

# Start up script
resource "vultr_startup_script" "my_script" {
  name   = "man_run_docs"
  script = "echo $PWD > test"
}

# Create user
# resource "vultr_user" "my_user" {
#   name        = "my user"
#   email       = "tribui.trb@gmail.com"
#   password    = "myP@ssw0rd"
#   api_enabled = true
#   acl = [
#     "manage_users",
#     "subscriptions",
#     "provisioning",
#     "billing",
#     "support",
#     "abuse",
#     "dns",
#     "upgrade",
#   ]
# }

# Create a web server
resource "vultr_server" "my_server" {
  plan_id   = "201"
  region_id = "40"
  os_id     = "413"
  label     = "my-server-label"
  tag       = "my-server-tag"
  hostname  = "my-server-hostname"
  user_data = "{'foo': true}"
  # enable_ipv4 = true
  enable_ipv6 = true
  auto_backup = true
  # ddos_protection = true
  notify_activate = false
}

# Snapshot the first time
# resource "vultr_snapshot" "my_snapshot" {
#   vps_id      = "${vultr_server.my_server.id}"
#   description = "my servers snapshot"
# }

# resource "vultr_server_ipv4" "my_server_ipv4" {
#     instance_id = "${vultr_server.my_server.id}"
#     reboot = "false"
# }

# Output
output "date_of_ssh_key" {
  value = vultr_ssh_key.ssh_key.date_created
}
