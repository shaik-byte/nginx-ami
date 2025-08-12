variable "source_ami" {
  type    = string
  default = "" # Will come from GitHub variable
}

variable "region" {
  type    = string
  default = "ap-south-1"
}

source "amazon-ebs" "nginx" {
  ami_name      = "nginx-ami-{{timestamp}}"
  instance_type = "t2.micro"
  region        = var.region
  source_ami    = var.source_ami
  ssh_username  = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.nginx"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx wget",

      # Install Trivy
      "wget https://github.com/aquasecurity/trivy/releases/latest/download/trivy_0.54.0_Linux-64bit.deb",
      "sudo dpkg -i trivy_0.54.0_Linux-64bit.deb",

      "sudo systemctl enable nginx"
    ]
  }
}
