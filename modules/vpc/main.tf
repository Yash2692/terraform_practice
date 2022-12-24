####### VPC_DECLARATION #######
resource "aws_vpc" "red_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        name = "${var.vpc_name}-vpc"
    }
}

####### PUBLIC_SUBNET_1_DECLARATION #######
resource "aws_subnet" "public_subnet_1" {
    vpc_id                  = aws_vpc.red_vpc.id
    cidr_block              = var.pub_subnet1_cidr
    map_public_ip_on_launch = true
    availability_zone       = var.availability_zone1
}
####### PUBLIC_SUBNET_2_DECLARATION #######
resource "aws_subnet" "public_subnet_2" {
    vpc_id                  = aws_vpc.red_vpc.id
    cidr_block              = var.pub_subnet2_cidr
    map_public_ip_on_launch = true
    availability_zone       = var.availability_zone2
}
####### PRIVATE_SUBNET_1_DECLARATION #######
resource "aws_subnet" "private_subnet_1" {
    vpc_id                  = aws_vpc.red_vpc.id
    cidr_block              = var.pri_subnet1_cidr
    map_public_ip_on_launch = false
    availability_zone       = var.availability_zone1
}
####### PRIVATE_SUBNET_2_DECLARATION #######
resource "aws_subnet" "private_subnet_2" {
    vpc_id                  = aws_vpc.red_vpc.id
    cidr_block              = var.pri_subnet2_cidr
    map_public_ip_on_launch = false
    availability_zone       = var.availability_zone2
}

####### INTERNET_GATEWAY_CREATION_AND_ASSOCIATION ####
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.red_vpc.id
}

###### CREATION_OF_ROUTE_TABLE #######
resource "aws_route_table" "public_route" {
    vpc_id          = aws_vpc.red_vpc.id
    
    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = aws_internet_gateway.my_igw.id
    }
}

###### SUBNET_ASSOCIATION_PUB_AZ1_RT #######
resource "aws_route_table_association" "pub_subnet_az1" {
    subnet_id       = aws_subnet.public_subnet_1.id
    route_table_id  = aws_route_table.public_route.id
}

###### SUBNET_ASSOCIATION_PUB_AZ2_RT #######
resource "aws_route_table_association" "pub_subnet_az2" {
    subnet_id       = aws_subnet.public_subnet_2.id
    route_table_id  = aws_route_table.public_route.id
}

##### ATTACHING_ROUTETABLE_AS_MAIN #########
resource "aws_main_route_table_association" "rt_associate"{
    vpc_id = aws_vpc.red_vpc.id
    route_table_id  = aws_route_table.public_route.id
}
