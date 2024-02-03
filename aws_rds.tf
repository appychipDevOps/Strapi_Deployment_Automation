resource "aws_db_instance" "strapi" {
  db_name                = "strapiDB"
  identifier             = "strapi-db"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "11.22"
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  publicly_accessible    = true
  skip_final_snapshot    = true

}

resource "null_resource" "rds_details" {

  provisioner "local-exec" {
    command = <<EOF
      echo '{
        "database_hostname": "${aws_db_instance.strapi.address}",
        "database_name": "${aws_db_instance.strapi.db_name}",
        "database_username": "${aws_db_instance.strapi.username}"
      }' > ./output/rds-details.json
    EOF
  }

}