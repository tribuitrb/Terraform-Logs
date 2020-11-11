variable "index" {
  type        = number
  default     = 1
  description = "index number for server counter"
}

// Instance vars
variable "number_of_servers" {
  description = "number of server to create"
  type        = number
  default     = 1
}

# variable "default_password" {
#   description = "default password"
#   type        = string
# }

variable "plan_id" {
  description = "plan id"
  type        = string
  default     = "201"
}

variable "region_id" {
  description = "region id"
  type        = string
  default     = "40"
}

variable "os_id" {
  description = "os id"
  type        = string
  default     = "413"
}

#tag

variable "user_data" {
  description = "user script executed at instance creation"
  type        = string
  default     = ""
}

variable "enable_ipv6" {
  description = "enable ipv6"
  type        = bool
  default     = true
}

variable "auto_backup" {
  description = "auto backup"
  type        = bool
  default     = true
}