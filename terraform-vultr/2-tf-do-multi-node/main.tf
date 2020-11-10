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

# Create a web server
resource "vultr_server" "my_server" {
  count = 3
  plan_id   = "201"
  region_id = "40"
  os_id     = "413"
  label     = "my-server-label"
  tag       = "my-server-tag"
  hostname  = "server-${count.index +1}"
  user_data = "{'foo': true}"
  enable_ipv6 = true
  auto_backup = true
  # ddos_protection = true
  notify_activate = false
}

# Output
output "date_of_ssh_key" {
  value = vultr_ssh_key.ssh_key.date_created
}

output "ip" {
  value       = vultr_server.my_server.*.main_ip
}

output "password" {
  value       = vultr_server.my_server.*.default_password
}