output "number_of_instances" {
  description = "The number of instances."
  value       = length(vultr_server.this)
}

output "this_password" {
  description = "Password for server"
  value       = vultr_server.this.*.default_password
}

output "this_user_data" {
  description = "The user data of the instance."
  value       = vultr_server.this.*.user_data
}

output "this_public_ip" {
  description = "The public ip of the instance."
  value       = vultr_server.this.*.main_ip
}

# output "date_of_ssh_key" {
#   value = vultr_ssh_key.ssh_key.date_created
# }