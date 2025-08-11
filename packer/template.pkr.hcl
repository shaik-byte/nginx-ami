variable "aws_region" {
  default = "ap-south-1"
}

source "amazon-ebs" "nginx-ami" {
  region           = var.aws_region
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"] # Canonical
    most_recent = true
  }
  instance_type   = "t2.micro"
  ssh_username    = "ubuntu"
  ami_name        = "nginx-ami-{{timestamp}}"
}

build {
  name    = "nginx-ami"
  sources = ["source.amazon-ebs.nginx-ami"]

  provisioner "ansible" {
    playbook_file = "./packer/ansible/playbook.yml"
  }
}
