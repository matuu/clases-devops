variable "ssh_user_name" {
  default = "ubuntu"
}

variable "image" {
  default = "ubuntu-xenial-16.04-amd64-server-20160627-disk1.img"
}

variable "flavor" {
  default = "m1.small"
}

# Estas variables las tomamos del ambiente seteando TF_VAR_USER y TF_VAR_PASS
variable "USER" {}

variable "PASS" {}

variable "count" {
  default = 1
}


