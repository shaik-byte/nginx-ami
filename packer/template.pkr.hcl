variable "source_ami" {
  type    = string
  default = "" # Will come from GitHub variable
}

source "amazon-ebs" "nginx" {
  ami_name      = "nginx-ami-{{timestamp}}"
  instance_type = "t2.micro"
  region        = var.region
  source_ami    = var.source_ami
  ssh_username  = "ec2-user"
}

variable "region" {
  type    = string
  default = "ap-south-1"
}

build {
  sources = ["source.amazon-ebs.nginx"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras enable nginx1",
      "sudo yum install -y nginx",
      "sudo systemctl enable nginx"
    ]
  }
}
