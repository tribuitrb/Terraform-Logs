#
# data "alicloud_images" "default" {
#   most_recent = true
#   name_regex  = var.image_type
#   owners      = "system"
# }

#
resource "alicloud_instance" "this" {
  count                = var.number_of_instances

  instance_name = var.custom_name
  host_name     = var.custom_host_name

  # image_id                   = data.alicloud_images.default.images.0.id
  image_id = var.image_id
  instance_type              = var.instance_type
  instance_charge_type       = var.instance_charge_type

  vswitch_id                 = var.vswitch_id
  security_groups            = var.security_groups

  system_disk_category = var.system_disk_category
  
  internet_charge_type       = var.internet_charge_type
  internet_max_bandwidth_out = var.internet_max_bandwidth_out

   key_name = var.key_name
}