region                        = "us-east-1"
environment                   = "dev"
project                       = "tf-meta-args-demo"
instance_type                 = "t3.micro"
instance_count                = 1
root_block_device_size        = 8
root_block_device_volume_type = "gp3"
monitoring                    = false
associate_public_ip           = true

allowed_ingress_ports = {
  ssh  = 22
  http = 80
}