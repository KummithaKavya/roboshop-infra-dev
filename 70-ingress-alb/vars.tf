variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "uat"
}

variable "common_tags" {
  default = {
    Name = "roboshop"
    environment = "uat"
    terraform = "true"

  }
}

variable "zone_id" {
  default =  "Z04757596NZDGVB9VM0A"

}

variable "domain_name" {
    default = "koti.lat"
}
  
