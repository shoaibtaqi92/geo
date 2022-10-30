module "vpc" {
  source = "./vpc"
}


module "ec2_instance" {
  source          = "./ec2"
  vpc_id          = module.vpc.vpc_id
  subnet_id          = module.vpc.private_subnets[0]
  security_groups = [module.vpc.default_security_group_id]
  instance_type   = "t3.nano"
  ami             = "ami-094bbd9e922dc515d"
}

resource "random_id" "my-random-id" {
byte_length = 8
}

module "s3" {
  source = "./s3"
  bucket = "geo-bucket-${random_id.my-random-id.dec}"

}

module "route_53"{
  source = "./route53"
  vpc_id = module.vpc.vpc_id
  zone_name = "geo-terraform-test.com"
  records = module.ec2_instance.private_ip
  record_name = "instance-test.geo-terraform-test.com"
}