variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "uat"
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "common_tags" {
  type = map
  default = {
    project =  "divya"
    terraform = true
    environment = "qa"
  }
}



variable "vpc_tags" {
    default = {
        Purpose = "roboshop"
    }
}

variable "public_subnet_cidrs" {
  default = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["10.1.11.0/24", "10.1.12.0/24"]
}

variable "database_subnet_cidrs" {
  default = ["10.1.21.0/24", "10.1.22.0/24"]
}

