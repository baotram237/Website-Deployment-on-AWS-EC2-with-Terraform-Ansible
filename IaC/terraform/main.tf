# ======================
# Network Module
# ======================
module "network" {
  source = "./modules/network"

  vpc_cidr_block = "10.0.0.0/16"
  subnet_cidr_block = "10.0.1.0/24"
}

# ======================
# EC2 Module
# ======================
module "ec2" {
  source = "./modules/ec2"
  key_name = "linux_lab_key"
  public_key_path = "~/.ssh/linux_lab_key.pub"
  instance_type = "t3.micro"
  subnet_id = module.network.subnet_id
  security_group_ids = [module.network.security_group_ids]
}

