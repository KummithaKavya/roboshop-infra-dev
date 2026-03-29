variable "project_name" {
    default = "roboshop"
}

variable "environment" {
    default = "uat"
}

variable "common_tags" {
    default = {
        Project = "roboshop"
        Environment = "uat"
        Terraform = "true"
    }
}