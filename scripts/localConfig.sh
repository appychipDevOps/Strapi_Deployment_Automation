#!/bin/bash

local_project_rootDir_path=$1
terraform_rootDir_path=$2
cd $local_project_rootDir_path
npm install pg
cp $terraform_rootDir_path/config/database.js $local_project_rootDir_path/config/database.js
npm install @strapi/provider-upload-aws-s3
cp $terraform_rootDir_path/config/plugins.js $local_project_rootDir_path/config/plugins.js
git add .
git commit -m 'Installed pg, aws-S3 upload provider and updated the config files'
git push
