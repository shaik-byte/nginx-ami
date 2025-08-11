variable "source_ami" {
  type    = string
  default = "ami-0e53db6fd757e38c7" # fallback
}

source "amazon-ebs" "nginx" {
  region      = var.region
  source_ami  = var.source_ami
  instance_type = "t2.micro"
  ssh_username  = "ec2-user"

  ami_name      = "nginx-ami-{{timestamp}}"
}

variable "region" {
  type    = string
  default = "ap-south-1"
}

build {
  sources = ["source.amazon-ebs.nginx"]

  provisioner "ansible" {
    playbook_file = "../ansible/install_nginx.yml"
  }
}
