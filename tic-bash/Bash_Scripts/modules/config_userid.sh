#!/bin/bash

# This script run the terraform infrastructure for the microservices that are mentioned by the user from frontend
# Make Sure to export aws credentials to be used as environment variables



# config_directory="~/BASHCODE/Terraform_config"
config_directory=${PWD}

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
