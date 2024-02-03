resource "null_resource" "save_output_and_deploy" {

  depends_on = [
    aws_db_instance.strapi,
    aws_instance.strapi,
    aws_s3_bucket.strapi_s3,
  ]

  connection {
    type        = "ssh"
    host        = aws_instance.strapi.public_ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    timeout     = "4m"
  }

  provisioner "file" {
    source      = "./output"
    destination = "/home/ubuntu/.output"
  }

  provisioner "remote-exec" {
    inline = [
      "/home/ubuntu/.scripts/setENV.sh ${var.access_key} ${var.secret_key}",
      "/home/ubuntu/.scripts/nodeSetup.sh",
      "/home/ubuntu/.scripts/deployStrapi.sh",
      "/home/ubuntu/.scripts/nginxSetup.sh"
    ]
  }

}


resource "null_resource" "delete_output" {

  provisioner "local-exec" {
    when    = destroy
    command = "echo {} > ./output/instance-details.json && echo {} > ./output/rds-details.json && echo {} > ./output/s3-details.json"
  }

}