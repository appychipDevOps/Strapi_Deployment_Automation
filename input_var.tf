variable "region" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

# set access_key and secret_key to the environment varibles (i.e. we don't want to expose our credentials)
# by using command
# export TF_VAR_access_key=""
# export TF_VAR_secret_key=""


variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "private_key_path" {
  type = string
}

variable "public_key_path" {
  type      = string
  sensitive = true
}

variable "inbound_ports" {
  type = list(any)
}

variable "image_name" {
  type = string
}

variable "db_security_group_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "instance_security_group_name" {
  type = string
}

variable "project_root_path" {
  type = string
}
variable "terraform_root_path" {
  type = string

}

variable "gitUsername" {
  type = string
}

variable "gitPassword" {
  type = string
}

variable "your_username" {
  type = string
}

variable "your_repo" {
  type = string
}

variable "webhook_secret" {
  type = string
}


