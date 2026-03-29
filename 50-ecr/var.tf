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
  default = "uat"
}


variable "domain_name" {
    default = "koti.lat"
}

variable "zone_id" {
  default =  "Z04757596NZDGVB9VM0A"

}