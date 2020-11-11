#
output "number_of_instances" {
  description = "The number of instances."
  value       = length(alicloud_instance.this)
}

# Ecs instance outputs
output "this_instance_name" {
  description = "The instance names."
  value       = alicloud_instance.this.*.instance_name
}

output "this_instance_host_name" {
  description = "The instance host names."
  value       = alicloud_instance.this.*.host_name
}

output "this_image_id" {
  description = "The image ID used by the instance."
  value       = alicloud_instance.this.*.image_id
}

output "this_instance_type" {
  description = "The type of the instance."
  value       = alicloud_instance.this.*.instance_type
}

output "this_instance_charge_type" {
  description = "The charge type of the instance."
  value       = alicloud_instance.this.*.instance_charge_type
}

# VSwitch  ID
output "this_vswitch_id" {
  description = "The vswitch id in which the instance."
  value       = alicloud_instance.this.*.vswitch_id
}

# Security Group outputs
output "this_security_groups" {
  description = "The security group ids in which the instance."
  value       = alicloud_instance.this.*.security_groups
}

output "this_internet_charge_type" {
  description = "The internet charge type of the instance."
  value       = alicloud_instance.this.*.internet_charge_type
}

output "this_internet_max_bandwidth_out" {
  description = "The internet max bandwidth out of the instance."
  value       = alicloud_instance.this.*.internet_max_bandwidth_out
}

# Disk output
output "this_system_disk_category" {
  description = "The system disk category of the instance."
  value       = alicloud_instance.this.*.system_disk_category
}

output "this_system_disk_size" {
  description = "The system disk size of the instance."
  value       = alicloud_instance.this.*.system_disk_size
}

# output "this_data_disks" {
#   description = "The data disks of the instance."
#   value       = alicloud_instance.this.*.data_disks
# }

# Key pair outputs
output "this_key_name" {
  description = "The key name of the instance."
  value       = alicloud_instance.this.*.key_name
}

output "this_private_ip" {
  description = "The private ip of the instance."
  value       = alicloud_instance.this.*.private_ip
}

output "this_public_ip" {
  description = "The public ip of the instance."
  value       = alicloud_instance.this.*.public_ip
}
