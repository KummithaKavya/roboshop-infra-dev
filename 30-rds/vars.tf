variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Name = "expense"
    environment = "dev"
    terraform = "true"

  }
}

variable "zone_id" {
  default =  "Z04757596NZDGVB9VM0A"

}

variable "domain_name" {
    default = "koti.lat"
}
  
