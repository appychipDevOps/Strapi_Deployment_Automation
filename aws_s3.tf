resource "aws_s3_bucket" "strapi_s3" {
  bucket = "strapi-bucket-3636"

  tags = {
    Name = "Strapi"
  }

}

resource "null_resource" "s3_details" {

  provisioner "local-exec" {
    command = <<EOF
      echo '{
        "s3_bucket_region": "${aws_s3_bucket.strapi_s3.region}",
        "s3_bucket_name": "${aws_s3_bucket.strapi_s3.bucket}"
      }' > ./output/s3-details.json
    EOF
  }

}

resource "aws_s3_bucket_public_access_block" "strapi_s3" {
  bucket = aws_s3_bucket.strapi_s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = true
}