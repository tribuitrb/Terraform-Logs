
# data "alicloud_images" "default" {
#   most_recent = true
#   name_regex  = var.image_type
#   owners      = "system"
# }

#
resource "alicloud_instance" "this" {
  count         = var.number_of_instances
  instance_name = var.custom_name
  host_name     = var.custom_host_name

  # image_id                   = data.alicloud_images.default.images.0.id
  image_id             = var.image_id
  instance_type        = var.instance_type
  instance_charge_type = var.instance_charge_type

  vswitch_id      = var.vswitch_id
  security_groups = var.security_groups

  internet_charge_type       = var.internet_charge_type
  internet_max_bandwidth_out = var.internet_max_bandwidth_out

  system_disk_category = var.system_disk_category
  system_disk_size     = var.system_disk_size
  # dynamic "data_disks" {
  #   for_each = var.data_disks
  #   content {
  #     category  = lookup(data_disks.value, "data_disk_category", null)
  #     size      = lookup(data_disks.value, "data_disk_size", null)
  #     encrypted = var.encryption
  #   }
  # }

  key_name = var.key_name
}