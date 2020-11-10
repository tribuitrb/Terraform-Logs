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

  user_data = <<EOF
    #cloud_config
    packages:
      - nginx
    runcmd:
      - [ sh, -xc, echo " '<h1>web-${count.index + 1}</h1>' >> /var/www/hmtl/index.html"]
  EOF

  lifecycle {
    create_before_destroy = true
  }
}

# SLB
resource "digitalocean_loadbalancer" "public" {
  name   = "loadbalancer-1"
  region = var.region

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_ids = digitalocean_droplet.web.*.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "digitalocean_domain" "default" {
  name = "example.com"
}

# Add an A record to the domain for www.example.com.
resource "digitalocean_record" "www" {
  domain = digitalocean_domain.default.name
  type   = "A"
  name   = "www" #var.region
  value  = digitalocean_loadbalancer.public.ip
  ttl    = 30
}

# Add a MX record for the example.com domain itself.
# resource "digitalocean_record" "mx" {
#   domain   = digitalocean_domain.default.name
#   type     = "MX"
#   name     = "@"
#   priority = 10
#   value    = "mail.example.com."
# }

# Output
output "droplet_limit" {
  value = data.digitalocean_account.example.droplet_limit
}

output "server_ip" {
  value = digitalocean_droplet.web.*.ipv4_address
}

output "lb_output" {
  value = digitalocean_loadbalancer.public.ip
}

# Output the FQDN for the www A record.
output "www_fqdn" {
  value = digitalocean_record.www.fqdn # => www.example.com
}

# Output the FQDN for the MX record.
# output "mx_fqdn" {
#   value = digitalocean_record.mx.fqdn # => example.com
# }