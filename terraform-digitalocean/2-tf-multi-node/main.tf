#
variable "droplet_count" {
  type    = number
  default = 3
}

variable "region" {
  type    = string
  default = "sgp1"
}

variable "droplet_size" {
  type    = string
  default = "s-1vcpu-1gb"
}

# Data
data "digitalocean_account" "example" {}

# Create a new SSH key
resource "digitalocean_ssh_key" "default" {
  name       = "Terraform Example"
  public_key = file("id_rsa.pub")
}

# Create a new Droplet using the SSH key
resource "digitalocean_droplet" "web" {
  count    = var.droplet_count
  image    = "ubuntu-20-04-x64"
  name     = "web-${count.index + 1}"
  region   = var.region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]

  lifecycle {
    create_before_destroy = true
  }
}

# Output
output "droplet_limit" {
  value = data.digitalocean_account.example.droplet_limit
}

output "server_ip" {
  value = digitalocean_droplet.web.*.ipv4_address
}

