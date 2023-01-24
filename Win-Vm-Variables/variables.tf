variable "rgname" {
    type = string
    description = "used for resource group naming"
}

variable "rglocation" {
    type = string
    description = "used for selecting the location"
    default = "East US"
}

variable "prefix" {
  type = string
  description = "used to define standard prefix for all resources"
}

variable "vnet_cidr_prefix" {
    type = string
    description = "this variables defines address space for vnet"  
}

variable "subnet_cidr_prefix" {
    type = string
    description = "this variable defines address space for subnet"
}
