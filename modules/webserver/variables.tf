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

variable "image_type" {
    description = "image type for server"
    type = string 

}
    
variable "subnet_id" {
    description = "subnet id for server"
    type = string 
}

variable "env_prefix" {
    description = "Environment prefix for the network"
    type = string 
}
variable "avail_zone" {
 description = "Availability zone for the network"
 type = string

} 
variable "vpc_id" {
    description = "vpc id for network "
    type = string
}