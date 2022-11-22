variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "admin-user" {
  type = string
}

variable "vm-size" {
  type = string
}

variable "admin-password" {
  type = string
}

variable "container_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "scfile" {
  type    = string
  default = "shell.tpl"
}