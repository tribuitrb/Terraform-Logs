
output "number_of_instances" {
  description = "The number of instances."
  value       = length(alicloud_instance.this)
}

output "this_instance_name" {
  description = "The instance names."
  value       = alicloud_instance.this.*.instance_name
}

output "this_instance_host_name" {
  description = "The instance host names."
  value       = alicloud_instance.this.*.host_name
}

# Ecs instance outputs
output "this_image_id" {
  description = "The image ID used by the instance."
  value       = alicloud_instance.this.*.image_id
}

output "this_instance_type" {
  description = "The type of the instance."
  value       = alicloud_instance.this.*.instance_type
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


output "this_system_disk_category" {
  description = "The system disk category of the instance."
  value       = alicloud_instance.this.*.system_disk_category
}

output "this_internet_charge_type" {
  description = "The internet charge type of the instance."
  value       = alicloud_instance.this.*.internet_charge_type
}

output "this_internet_max_bandwidth_out" {
  description = "The internet max bandwidth out of the instance."
  value       = alicloud_instance.this.*.internet_max_bandwidth_out
}