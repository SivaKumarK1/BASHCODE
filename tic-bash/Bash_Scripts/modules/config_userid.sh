#!/bin/bash

# This script run the terraform infrastructure for the microservices that are mentioned by the user from frontend
# Make Sure to export aws credentials to be used as environment variables

config_directory="${PWD}/../../Terraform_config"

terraform_job1(){
    echo "Checking if Terraform is installed or not"
    terraform -version
    if [ "$?" -eq 127 ]
    then
        echo "============================================================================================="
        echo "No installation for terraform found, "\
             "Installing Now"
        echo "============================================================================================="
        curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
        sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
        sudo apt-get update && sudo apt-get install terraform
        echo "============================================================================================="
        echo "Terraform Installed"\
             "Continuing with running terraform scripts"
        echo "============================================================================================="
        cd $config_directory
        terraform init
        if [ "$?" -eq 0 ]
        then
            terraform validate
            if [ "$?" -eq 0 ]
            then
                terraform plan
                if [ "$?" -eq 0 ]
                then
                    terraform apply --auto-approve
                    echo "Your Instance will be accessible in a few seconds."
                fi
            fi
        fi
    else
        echo "Installation was found !"
        cd $config_directory
        terraform init
        if [ "$?" -eq 0 ]
        then
            terraform validate
            if [ "$?" -eq 0 ]
            then
                terraform plan
                if [ "$?" -eq 0 ]
                then
                    terraform apply --auto-approve
                    echo "Your Instance will be accessible in a few seconds."
                fi
            fi
        fi
    fi
}
terraform_job1