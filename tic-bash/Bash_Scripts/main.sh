#!/bin/bash 
echo "Welcome to The Tool"
echo "This tool will automate all the pipeline stages"
echo "Starting with the compile phase which will be done using"

#This will be used when we use the env file for secret variables
# export $(grep -v '#.*' .env | xargs) 

# Variables
gitLink="currently nothing" # Set it to the url mentioned from the db
proj_dir=${PWD}
orgNamet=Test # In production replace with ${orgName} that is coming from env file
orgName=$(echo $orgNamet | tr '[:upper:]' '[:lower:]') 
DATE=`date +%Y.%m.%d.%H.%M` #Date is being used a tag for the images

#  Ecr login creds

source ./modules/config_userid.sh
source ./modules/docker_job.sh
source ./modules/ecr_job.sh
source ./modules/config_userid
source ./modules/infra.sh

simple_func(){
    cd proj_dir/Terraform_launchpad
    export TF_VAR_gitLink=${gitLink}
    export TF_VAR_instance-tag-name=${orgName}
}

main(){
    # mvn_job
    # run_tests
    # ecr_job
    # docker_job
    # terraform_job1
    # terraform_job2
    # ansible_job
    # monitoring_job
}
main