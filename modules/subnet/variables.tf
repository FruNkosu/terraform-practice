variable "subnet_cidr_block" {
   description  = "subnet cidr block"
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
variable "vpc_id" {
    description = "vpc id for network "
    type = string
}


variable "default_route_table_id" {
    description = "default route table"
    type = string
}

/*variable "route_table_id"{}*/




