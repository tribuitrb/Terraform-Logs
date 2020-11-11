variable "index" {
  type        = number
  default     = 1
  description = "index number for ecs instance counter"
}

// Instance vars
variable "number_of_instances" {
  description = "number of instance to create"
  type        = number
  default     = 1
}

// Financial vars

variable "custom_name" {
  type        = string
  description = "Instance name not compliant with foundation standards"
}

variable "custom_host_name" {
  type        = string
  description = "Host name not compliant with foundation standards"
}

# variable "image_type" {
#   description = "Regex name of the image, example ubuntu_18.*64"
#   default     = "^ubuntu_18.*64"
#   type        = string
# }

variable "image_id" {
  description = "Regex name of the image, example ubuntu_18.*64"
  default     = "ubuntu_18_04_64_20G_alibase_20190624.vhd"
  type        = string
}

variable "instance_type" {
  type        = string
  description = "instance type"
}

variable "instance_charge_type" {
  default     = "PrePaid"
  type        = string
  description = "The charge type of instance. Choices are 'PostPaid' and 'PrePaid' or 'PayByBandwidth'"
}

// Net Vars
variable "vswitch_id" {
  description = "The virtual switch ID to launch in VPC"
  type        = string
}

variable "security_groups" {
  description = "A list of security group ids to associate with"
  type        = list(string)
}

//disks
variable "system_disk_category" {
  type        = string
  default     = "cloud_efficiency"
  description = "system disk category, cloud_efficiency and cloud_ssd"
}

variable "internet_charge_type" {
  description = "The internet charge type of instance. Choices are 'PayByTraffic' and 'PayByBandwidth"
  default     = "PayByTraffic"
  type        = string
}

variable "internet_max_bandwidth_out" {
  description = "The internet charge type of instance. Choices are 'PayByTraffic' and 'PayByBandwidth"
  default     = 10
  type        = number
}

variable "key_name" {
  default     = ""
  type        = string
  description = "ssh-key name"
}
