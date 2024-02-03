#!/bin/bash

export AWS_ACCESS_KEY_ID=$1
export AWS_ACCESS_SECRET=$2

sudo apt update -y
sudo apt-get remove needrestart -y

sudo apt install -y python3 python3-pip
pip3 install python-dotenv

echo "$(python3 --version)"
echo "$(pip3 --version)"
echo "python-dotenv $(pip3 show python-dotenv | grep Version)"

echo "running env script >>>>>>>>>>>>>>>>>>>>>"
python3 /home/ubuntu/.scripts/configENV.py $AWS_ACCESS_KEY_ID $AWS_ACCESS_SECRET