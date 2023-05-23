# #This will create VPC
# resource "aws_vpc" "cidr_block" {
#   cidr_block = var.cidr_block #Other can override the values by using 
#   instance_tenancy = "default"

# }

resource "aws_vpc" "timming_vpc" {
  cidr_block = local.cidr_block #If you don't wanna user override values
  instance_tenancy = "default"
  tags = var.Tags

}

### IGW
resource "aws_internet_gateway" "IGW_timming" {
  vpc_id = aws_vpc.timming_vpc.id #IGW DEPENDS ON VPC,
  tags = var.igw_tags

}
# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.timming_vpc.id #It fetches the vpc ID manin.id
  cidr_block = var.pub_cidr
  tags = var.Public_subnet_tag

}

resource "aws_subnet" "Private_subnet" {
  vpc_id     = aws_vpc.timming_vpc.id #It fetches the vpc ID manin.id
  cidr_block = var.pri_cidr
  tags = var.Private_subnet_tag

}

resource "aws_subnet" "db_subnet" {
  vpc_id = aws_vpc.timming_vpc.id
  cidr_block = var.db_subnet
  tags = var.db_subnet_tag
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.timming_vpc.id

  route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.IGW_timming.id

  }
  tags = var.public_route_tag
  
}
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.timming_vpc.id
  route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.nat_gateway.id
}

  tags = var.private_rt_tag
  
}

#Elastic IP
resource "aws_eip" "Elastic_ip" {
  
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.Elastic_ip.id
  subnet_id = aws_subnet.public_subnet.id

  tags = var.nat_gateway_tag
  
  # To ensure the proper ordering, we need to add explicit dependency
  # Nat gateway works depends on internetgateway
  depends_on = [ aws_internet_gateway.IGW_timming ]
  
}

resource "aws_route_table_association" "public_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public-rt.id
  
}

resource "aws_route_table_association" "private_asspciation" {
  subnet_id = aws_subnet.Private_subnet.id
  route_table_id = aws_route_table.private_rt.id
  
}













