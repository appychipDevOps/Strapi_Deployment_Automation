data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["${var.image_name}"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "strapi" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.strapi_sg.name]
  key_name        = aws_key_pair.deployer.key_name


  tags = {
    Name = "Strapi_app"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    timeout     = "4m"
  }

  provisioner "file" {
    source      = "./scripts"
    destination = "/home/ubuntu/.scripts"
  }

  provisioner "file" {
    source      = "./config"
    destination = "/home/ubuntu/.config"
  }


  # provisioner "remote-exec" {
  #   inline = [
  #     # "sudo chmod +x /home/ubuntu/.config/*",
  #     "sudo chmod +x /home/ubuntu/.scripts/*",
  #     "/home/ubuntu/.scripts/nodeSetup.sh",
  #   ]
  # }

  provisioner "local-exec" {
    command = "scripts/localConfig.sh ${var.project_root_path} ${var.terraform_root_path}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/ubuntu/.scripts/*",
      "/home/ubuntu/.scripts/pullCode.sh ${var.gitUsername} ${var.gitPassword} ${var.your_username} ${var.your_repo}",
    ]
  }

  provisioner "file" {
    source      = "${var.project_root_path}/.env"
    destination = "/home/ubuntu/strapiApp/.env"
  }

}

resource "null_resource" "instance_details" {

  provisioner "local-exec" {
    command = <<EOF
      echo '{
        "instance_id": "${aws_instance.strapi.id}",
        "public_ip": "${aws_instance.strapi.public_ip}"
      }' > ./output/instance-details.json
    EOF
  }
}
