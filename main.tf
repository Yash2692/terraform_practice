module "vpc" {
    source                  = "./modules/vpc"
    region                  = var.region
    vpc_name                = var.vpc_name
    vpc_cidr                = var.vpc_cidr
    availability_zone1      = var.availability_zone1   
    availability_zone2      = var.availability_zone2
    pub_subnet1_cidr        = var.pub_subnet1_cidr
    pub_subnet2_cidr        = var.pub_subnet2_cidr
    pri_subnet1_cidr        = var.pri_subnet1_cidr
    pri_subnet2_cidr        = var.pri_subnet2_cidr
}