output "instance_details" {
  value = {
    instance_id = aws_instance.strapi.id
    public_ip   = aws_instance.strapi.public_ip
    private_ip  = aws_instance.strapi.private_ip
  }


}

output "AWS_RDS_Details" {
  value = {
    db_name     = aws_db_instance.strapi.db_name
    db_hostname = aws_db_instance.strapi.address
    db_port     = aws_db_instance.strapi.port
    db_username = aws_db_instance.strapi.username
    db_endpoint = aws_db_instance.strapi.endpoint
    db_port     = aws_db_instance.strapi.port

  }

}


output "AWS_S3_BUCKET_DETAILS" {
  value = {
    s3_bucket_name   = aws_s3_bucket.strapi_s3.bucket
    s3_bucket_arn    = aws_s3_bucket.strapi_s3.arn
    s3_bucket_region = aws_s3_bucket.strapi_s3.region
  }
}