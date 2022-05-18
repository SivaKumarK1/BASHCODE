#!/bin/bash

# This script run the terraform infrastructure for the microservices that are mentioned by the user from frontend
echo "!!!# Make Sure to export aws credentials to be used as environment variables!!!"

infra_directory="/home/siva/Desktop/DevOps-Automation/Terraform_infra"

terraform_job2(){
    echo "Checking if Terraform is installed or not"
    terraform -version
    if [ "$?" -eq 127 ]
    then
        echo "============================================================================================="
        echo "No installation for terraform found, " \
             "Installing Now"
        echo "============================================================================================="
        curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
        sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
        sudo apt-get update && sudo apt-get install terraform
        echo "============================================================================================="
        echo "Terraform Installed, " \
             "Continuing with running terraform scripts"
        echo "============================================================================================="
        cd $infra_directory
        terraform init
        if [ "$?" -eq 0 ]
        then
            terraform validate
            if [ "$?" -eq 0 ]
            then
                terraform plan -var-file="var.tfvars"
                if [ "$?" -eq 0 ]
                then
                    terraform apply -var-file="var.tfvars" --auto-approve
                    echo "Your Instance will be accessible in a few seconds."
                fi
            fi
        fi
    else
        echo "Installation was found !"
        cd $infra_directory
        terraform init
        if [ "$?" -eq 0 ]
        then
            terraform validate
            if [ "$?" -eq 0 ]
            then
                terraform plan -var-file="var.tfvars.json"
                if [ "$?" -eq 0 ]
                then
                    terraform apply -var-file="var.tfvars.json" --auto-approve
                    echo "Your Instance will be accessible in a few seconds."
                fi
            fi
        fi
    fi
}
terraform_job2