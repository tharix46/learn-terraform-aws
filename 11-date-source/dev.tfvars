region      = "us-east-1"
environment = "dev"
project     = "TF Data Sources Demo"

ec2_instance_types = {
  dev     = "t3.micro"
  staging = "t3.micro"
  prod    = "t3.large"
}

ec2_instance_count                = 2
ec2_root_block_device_size        = 8
ec2_root_block_device_volume_type = "gp3"
ec2_monitoring                    = false
ec2_associate_public_ip           = true
ec2_user_data_script_path         = "userdata.sh"
allowed_availability_zones        = ["us-east-1a", "us-east-1b"]

sg_allowed_ingress_ports = {
  ssh  = 22
  http = 80
}