variable "common_tags" {
  default = {
    project_name = "roboshop"
    environment = "uat"
    terraform =  true
  }
}

variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "qa"
}