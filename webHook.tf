resource "github_repository_webhook" "strapi" {
  repository = var.your_repo
  active     = true
  events     = ["push"]
  configuration {
    url          = "http://${aws_instance.strapi.public_ip}:8080"
    content_type = "json"
    secret       = var.webhook_secret
  }

  connection {
    type        = "ssh"
    host        = aws_instance.strapi.public_ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    timeout     = "4m"
  }
  provisioner "remote-exec" {
    inline = [
      "/home/ubuntu/.scripts/webHook.sh ${var.webhook_secret}",
    ]
  }

  depends_on = [
    null_resource.save_output_and_deploy
  ]
}