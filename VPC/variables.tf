variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}
variable "pub_cidr" {
    type = string
    default = "10.0.1.0/24"
  }
variable "pri_cidr" {
    type = string
    default =  "10.0.2.0/24"
}
variable "db_subnet" {
  type = string
  default = "10.0.3.0/24"  
}
### Creating Tags varaibles
variable "Tags" {
  type = map
  default = {
    Name = "vpc-module"
  }

}

variable "igw_tags" {
  type = map
    default = {
        Name = "IGW"
    }
  
}

variable "Public_subnet_tag" {
  type = map
  default = {
    Name = "Public_subnet"
  }
}

variable "Private_subnet_tag" {
  type = map
  default = {
    Name = "Private_subnet"
  }
}
variable "db_subnet_tag" {
  type = map
  default = {
    Name = "db_subnet for database"
  }
  
}

variable "public_route_tag" {
  type = map
  default = {
    Name = "Attaching internet gateway to vpc"
  
  }
  
}

variable "private_rt_tag" {
  type = map
  default = {
    Name = "private route for application"
  }
}

variable "nat_gateway_tag" {
  type = map
  default = {
    Name = "nat gatway for internet"
  }
}