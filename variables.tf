variable "subnet_cidr_block" {
   description  = "subnet cidr block"
   type = string
}

variable "vpc_cidr_block" {
   description  = "cidr blocks for vpc"  
   type = string
    
}

variable "avail_zone" {
 description = "Availability zone for the network"
 type = string

}

variable "env_prefix" {
    description = "Environment prefix for the network"
    type = string 
}

variable "my_ip" {
    description = "IP address for the network"
    type = string
}

variable "instance_type" {
    description = "Instance type for server"
    type = string
}



 variable "key_pair" {
    description = "key pair for server"
    type = string
}

variable "default_public_key_location" {
    description = "default key pair for server"
    type = string
}
