#
variable "index" {
  type        = number
  default     = 1
  description = "index number for ecs instance counter"
}

variable "number_of_instances" {
  description = "number of instance to create"
  type        = number
  default     = 1
}

variable "custom_name" {
  type        = string
  description = "Instance name not compliant with foundation standards"
}

variable "custom_host_name" {
  type        = string
  description = "Host name not compliant with foundation standards"
}

variable "image_id" {
  description = "Regex name of the image, example ubuntu_18.*64"
  default     = "ubuntu_18_04_64_20G_alibase_20190624.vhd"
  type        = string
}

# variable "image_type" {
#   description = "Regex name of the image, example ubuntu_18.*64"
#   default     = "^ubuntu_18.*64"
#   type        = string
# }

variable "instance_type" {
  type        = string
  description = "instance type"
}

// Financial vars
# variable "instance_charge_type" {
#   default     = "PostPaid"
#   type        = string
#   description = "The charge type of instance. Choices are 'PostPaid' and 'PrePaid'"
# }

variable "vswitch_id" {
  description = "The virtual switch ID to launch in VPC"
  type        = string
}

variable "security_groups" {
  description = "A list of security group ids to associate with"
  type        = list(string)
}

variable "internet_charge_type" {
  description = "The internet charge type of instance. Choices are 'PayByTraffic' and 'PayByBandwidth"
  default     = "PayByBandwidth"
  type        = string
}

variable "internet_max_bandwidth_out" {
  default = 10
  type    = number
}

//disks
variable "system_disk_category" {
  type        = string
  default     = "cloud_efficiency"
  description = "system disk category, cloud_efficiency and cloud_ssd"
}

# variable "system_disk_size" {
#   type        = number
#   default     = 40
#   description = "system disk size"
# }

# variable "data_disks" {
#   description = "Configuration of the disks to attach to the ECS instance: type and size"
#   type        = list(map(string))
#   default = [
#     {
#       data_disk_category = "cloud_efficiency"
#       data_disk_size     = "50"
#       data_disk_index    = "0"
#     }
#   ]
# }
# variable "encryption" {
#   default = true
#   description = "If it is true, the disk will be encrypted"
# }

// ssh-keys
variable "key_name" {
  default     = ""
  type        = string
  description = "ssh-key name"
}
