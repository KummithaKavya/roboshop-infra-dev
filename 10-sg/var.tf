

variable "common_tags" {
  default = {
    project = "roboshop"
    environment = "uat"
    terraform = "true"
  }
}

variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "uat"
}

variable "sg_description" {
  default = "this is sg"
}