#VPC    
resource "aws_vpc" "prod-vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_support = "true" #gives you an internal domain name
    enable_dns_hostnames = "true" #gives you an internal host name
    instance_tenancy = "default"    
    
    tags = {
        Name = "geo-vpc"
    }
}

# Subnets : public
resource "aws_subnet" "public" {
  count = length(var.public_subnets_cidr)
  vpc_id = aws_vpc.prod-vpc.id
  cidr_block = element(var.public_subnets_cidr,count.index)
  availability_zone = element(var.azs,count.index)
  map_public_ip_on_launch = "true"
  tags = {
    Name = format("%s%s","Public Subnet - ${count.index+1}",element(var.tags,count.index)) 
  }
}


# Subnets : Private
resource "aws_subnet" "private" {
  count = length(var.private_subnets_cidr)
  vpc_id = aws_vpc.prod-vpc.id
  cidr_block = element(var.private_subnets_cidr,count.index)
  availability_zone = element(var.azs,count.index)
  tags = {
    Name = format("%s%s","Private Subnet - ${count.index+1}",element(var.tags,count.index))
  }
} 


# Internet Gateway
resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.prod-vpc.id
  tags = {
    Name = "Geo-IGW"
  }
}

#EIP
resource "aws_eip" "nat" {
  count = length(var.nat-azs)
  vpc   = true
  tags = {
    Name  = format("%s%s","Geo-IP - ${count.index+1}",element(var.tags,count.index))
  }
}
  
#NAT Gateway
resource "aws_nat_gateway" "prod_ngw" {
  count = length(var.nat-azs)
  allocation_id = element(aws_eip.nat.*.id,count.index)  
  subnet_id = element(aws_subnet.public.*.id,count.index)

  tags = {
    Name = format("%s%s","Geo-NGW - ${count.index+1}",element(var.tags,count.index))
  }
}


# Route table: attach Internet Gateway 
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.prod-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_igw.id
  }
  tags = {
    Name = "Public Route Table"
  }
}

# Route table: attach NAT Gateway on Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.prod-vpc.id
  count = length(var.azs)
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.prod_ngw.*.id,count.index)
    
  }  
  tags = {
    Name = format("%s%s","Private Route Table - ${count.index+1}",element(var.tags,count.index))      
  }
}


# Route table association with public subnets
resource "aws_route_table_association" "public" {
  count = length(var.public_subnets_cidr)
  subnet_id = element(aws_subnet.public.*.id,count.index)
  route_table_id = aws_route_table.public_rt.id
}

# Route table association with private subnets
resource "aws_route_table_association" "private" {
  count = length(var.private_subnets_cidr)
  subnet_id = element(aws_subnet.private.*.id,count.index)
  route_table_id = element(aws_route_table.private_rt.*.id,count.index)

}

