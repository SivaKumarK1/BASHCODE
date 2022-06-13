#!/bin/bash

# This script run the terraform infrastructure for the microservices that are mentioned by the user from frontend
# Make Sure to export aws credentials to be used as environment variables



config_directory="/home/ubuntu/BASHCODE/tic-bash/Terraform_config"
# config_directory=${PWD}
# install terraform
echo "########################################"
echo "########################################"
echo "#################### install terrafrm-cli #########################"
sudo apt-get update -y && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update -y && sudo apt-get install terraform -y
echo "terraform installed"

echo "########################################"
echo "########################################"
echo "#################### install docker #########################"
sudo apt-get update -y
sudo apt-get install ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo apt-get update -y
echo "Docker installed"

#install ansible
echo "########################################"
echo "########################################"
echo "#################### install ansible #########################"
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y
echo "Ansible Installed"

terraform_job1(){
    echo "============================================================================================="
    cd $config_directory
    terraform init
    if [ "$?" -eq 0 ]
    then
        terraform validate
        if [ "$?" -eq 0 ]
        then
            terraform plan --var-file="var.tfvars.json"
            if [ "$?" -eq 0 ]
            then
                terraform apply --auto-approve --var-file="var.tfvars.json"
                echo "Your Instance will be accessible in a few seconds."
            fi
        fi
    fi
}
terraform_job1
