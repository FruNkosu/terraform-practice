variable "subnet_cidr_block" {
   description  = "subnet cidr block"
   default = "10.0.10.0/24"
   type = string
}

variable "cidr_blocks" {
    default = ["10.0.0.0/16" , "10.0.10.0/24"]
    description  = "cidr blocks for subnet and vpc"  
   type = list(string)
    
}

variable "avail_zone" {
 default = "us-east-1a"
 description = "Availability zone for the network"
 type = string

}