variable "name" {
  type = string
}

variable "yaml_file" {
  type = string
}

variable "endpoint_id" {
  type = string
}

variable "env_vars" {
  type    = map(string)
  default = {}
}
