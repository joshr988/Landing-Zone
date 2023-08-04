resource "aws_vpc" "project_vpc" {
  cidr_block = var.vpc_cidr_block
  
  tags = {
    Name            = "project-vpc"
    Account         = "VPC"
    CreatedBy       = "Terraform"
    EnvironmentType = "prod"
  }
}

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet_cidr_blocks)
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  
  tags = {
    Name            = "public-subnet-${count.index+1}"
    Account         = "VPC"
    CreatedBy       = "Terraform"
    EnvironmentType = "prod"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.public_subnet_cidr_blocks)
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  
  tags = {
    Name            = "private-subnet-${count.index+1}"
    Account         = "VPC"
    CreatedBy       = "Terraform"
    EnvironmentType = "prod"
  }
}

resource "aws_internet_gateway" "project_igw" {
  vpc_id = aws_vpc.project_vpc.id
  
  tags = {
    Name            = "project-igw"
    Account         = "VPC"
    CreatedBy       = "Terraform"
    EnvironmentType = "prod"
  }
}

resource "aws_eip" "nat_eip" {
  domain  = "vpc"
  
  tags = {
    Name            = "nat-eip"
    Account         = "VPC"
    CreatedBy       = "Terraform"
    EnvironmentType = "prod"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  subnet_id        = aws_subnet.public_subnet[0].id
  allocation_id    = aws_eip.nat_eip.id
  connectivity_type = "public"
  
  tags = {
    Name            = "nat-gateway"
    Account         = "VPC"
    CreatedBy       = "Terraform"
    EnvironmentType = "prod"
  }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.project_vpc.id  
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.project_igw.id
    }

    tags = {
        "Account"         = "VPC"
        "CreatedBy"       = "Terraform"
        "EnvironmentType" = "prod"
        "Name"            = "public-route-table"
    }
}

resource "aws_route_table" "private_route_table" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    "Account"         = "VPC"
    "CreatedBy"       = "Terraform"
    "EnvironmentType" = "prod"
    "Name"            = "private-route-table-${count.index + 1}"
  }
}

resource "aws_route" "public_route" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.project_igw.id
  route_table_id         = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_association" {
  count = length(var.public_subnet_cidr_blocks)

  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}

resource "aws_route" "nat_gateway_route" {
  count                  = length(var.private_subnet_cidr_blocks)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
  route_table_id         = aws_route_table.private_route_table[count.index].id
}

resource "aws_route_table_association" "private_subnet_association" {
  count = length(var.private_subnet_cidr_blocks)

  route_table_id = aws_route_table.private_route_table[count.index].id
  subnet_id      = aws_subnet.private_subnet[count.index].id
}