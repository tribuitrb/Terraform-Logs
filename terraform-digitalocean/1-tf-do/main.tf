
data "digitalocean_account" "example" {}

# Create a new SSH key
resource "digitalocean_ssh_key" "default" {
  name       = "Terraform Example"
  public_key = file("id_rsa.pub")
}

# Create a new Droplet using the SSH key
resource "digitalocean_droplet" "web" {
  image    = "ubuntu-20-04-x64"
  name     = "web-1"
  region   = "sgp1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}

# Output
output "droplet_limit" {
  value       = data.digitalocean_account.example.droplet_limit
}

output "server_ip" {
  value       = digitalocean_droplet.web.ipv4_address
}

