# SSH Key
resource "vultr_ssh_key" "ssh_key" {
  name    = "ssh-key"
  ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAiO0wEVpgwRvuVdCt5WeOzDkYS6z2uzc0OSvC3dK25SKkwU2Mwb8aDHjaJkfmA9tb1L763x4IAx6e11JLCA0W2+iuxI8uaisgbo/FeZu7T9A6JHg54KvnvhvEnDhv3W18Zxz0ZCbERYB5f7SHpUONeKH86XEduQFbSyuMCUNvp2yCCaEPt8dZgcr7hxAVD+zECUB9C0lfU5098fw1A92RLlUWg8dmOccLAyv1RgNc+rE5p3g6aF4l6KjUQFbyNFRhzY1Ns7g/iruiLLSqcuk7Jddpss1sYjTJmJOKH1OaJj0HX2k9XwOjUfyI0fkkp1opSaD8H5VNFEGH4+f1JEj3MQ== trb-rsa-key"
}

# Start up script
# resource "vultr_startup_script" "my_script" {
#   name   = "man_run_docs"
#   script = "echo $PWD > test"
# }

# Create a web server
module "server" {
  source = "./modules/"

  number_of_servers = 3

}

# Output
output "server_ip" {
   value = module.server.this_public_ip
}
output "this_password" {
   value = module.server.this_password
}