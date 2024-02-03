# Automation of Strapi App Deployment on AWS

This project automates the deployment process of a Strapi app on AWS EC2 using Terraform, Python, and Bash scripting. This Automation Project follows the steps 

### Prerequisites

- **Packages**:  Python3, Git, Terraform

- **Strapi App**:

    - You need to have a Strapi app hosted on GitHub.

        If you don't have the app, you can create a Strapi project using the Strapi Quickstart and push it to the GitHub. Run the following command to create a Strapi app:
        ```bash
        npx create-strapi-app@latest my-project --quickstart
        ```

- **AWS Account**:

    An AWS account with the necessary permissions to create EC2 instances, RDS databases, and S3 buckets.


## Automation Steps

### 1. Clone the Repository

Clone the Strapi app repository on your development machine.
```bash
git clone https://github.com/VinayakSingoriya/Strapi-Automation.git

cd Strapi-Automation
```

### 2. Create a Private-Public Key Pair

Generate an SSH Key pair on development machine.

```bash
ssh-keygen
```

### 3. Update Terraform Variables

Create a terraform.tfvars file and provide the necessary key-value pairs based on your AWS environment and Strapi app configuration.

```
# Region and Access Credentials
region     = ""
access_key = ""
secret_key = ""

# Instance Information
instance_type = "t2.small"
image_name    = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"

# Key-Pair
key_name         = ""
private_key_path = ""
public_key_path  = ""

# EC2 Security Group
instance_security_group_name = ""
inbound_ports                = [80, 443, 22, 1337]

# AWS RDS Security Group 
db_security_group_name = ""

# AWS RDS Configuration
db_username = ""
db_password = ""

#path
project_root_path   = ""  # set the root path of the Strapi project (which is on development machine)
terraform_root_path = ""  # set the root path of the Terraform code (which is on development machine)

# Git Credentials
# git clone https://$GIT_USERNAME:$GIT_PASSWORD@github.com/your_username/your_repo.git
gitUsername   = ""            # GIT_USERNAME
gitPassword   = ""            # GIT_PASSWORD
your_username = ""
your_repo     = ""

```

### 4. Terraform Initialization

Run the following commands to initialize Terraform and plan the infrastructure.

 ```bash
 terraform init
 terraform plan
 ```

### 5. Start the Automation Process

You can start the automation process by running the following command:
```bash
terraform apply --auto-approve
```
Use the **--auto-approve** flag to automatically apply changes without user intervention.

At the end of the automation process, the terraform will provide the Access points of the following:

- AWS RDS Endpoints
- AWS S3 Endpoints
- AWS EC2 Public IP

You can access the Strapi App using the public IP of the AWS EC2 machine.

```bash
http://<ec2_instance_public_ip>
```
