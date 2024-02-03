from dotenv import set_key, load_dotenv
import json
import os   
import sys 

rootPath = '/home/ubuntu/.output'


try:
    # Load instance.json
    with open(f'{rootPath}/instance-details.json', 'r') as f:
        instance_data = json.load(f)
        print(instance_data)
except FileNotFoundError:
    print("Error: instance-details.json not found")
    instance_data = {}

try:
    # Load rds.json
    with open(f'{rootPath}/rds-details.json', 'r') as f:
        rds_data = json.load(f)
        print(rds_data)
except FileNotFoundError:
    print("Error: rds-details.json not found")
    rds_data = {}

try:
    # Load s3.json
    with open(f'{rootPath}/s3-details.json', 'r') as f:
        s3_data = json.load(f)
        print(s3_data)
except FileNotFoundError:
    print("Error: s3-details.json not found")
    s3_data = {}


# Load all the values
node_env = 'production'


#DataBase
database_host = rds_data['database_hostname']
database_name = rds_data['database_name']
database_username = rds_data['database_username']
database_password = 'password'

#AWS Access
args = sys.argv
aws_access_key_id = args[1]
aws_access_secret = args[2]

#S3_Bucket
aws_region = s3_data['s3_bucket_region']
aws_bucket_name = s3_data['s3_bucket_name']

envPath = '/home/ubuntu/strapiApp/.env'
load_dotenv(envPath)

# Update the values in the .env file
set_key(envPath, 'NODE_ENV', node_env)

set_key(envPath, 'DATABASE_HOST', database_host)
set_key(envPath, 'DATABASE_PORT', '5432')
set_key(envPath, 'DATABASE_NAME', database_name)
set_key(envPath, 'DATABASE_USERNAME', database_username)
set_key(envPath, 'DATABASE_PASSWORD', database_password)

set_key(envPath, 'AWS_ACCESS_KEY_ID', aws_access_key_id)
set_key(envPath, 'AWS_ACCESS_SECRET', aws_access_secret)

set_key(envPath, 'AWS_REGION', aws_region)
set_key(envPath, 'AWS_BUCKET_NAME', aws_bucket_name)







