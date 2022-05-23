#!/bin/bash 
# mvn installaton not working check in other instances

# proj_dir="~/MicroServiceRepo"
proj_dir=${PWD}

# install maven
echo "########################################"
echo "########################################"
echo "#################### install maven #########################"
sudo apt update -y
sudo apt install openjdk-11-jre -y
sudo apt install maven -y
echo "Maven installed"

mvn_job(){
    echo "Checking if Maven is installed or not"
    mvn -v
        echo "mvn installation found"
        echo "Continuing Maven Build"
        for pomLocation in `find ./* -name 'pom.xml' -type f -printf "%h\n" 2>/dev/null`
        do
            echo "Compiling with maven, inside $pomLocation"
            echo "============================================================================================="
            if [ -d "$pomLocation" ]
            then
                cd $pomLocation
                mvn clean install 
            fi 
            echo "============================================================================================="
            echo "============================================================================================="
            echo "Running Tests for your application"
            echo "for now empty"
            echo "============================================================================================="
            cd $proj_dir
        done                     

#   curl -X 'POST' \
#   'http://localhost:8082/tic/api/v1/pipeline/status/1/1/1' \
#   -H 'accept: */*' \
#   -H 'Content-Type: application/json' \
#   -d '{
#   "pipelineName": "pipeline", 
#   "build": "true",
#   "test": "true",
#   "publish": "null",
#   "infraStage": "null",
#   "configStage": "null",
#   "deploy": "null"
# }'

#accodring to us pipeline name is nekku voche ci env file lo projectname_pipeline and userid too
    # find ./* -name 'pom.xml' -type f -printf "%h\n" 2>/dev/null
    # the above command is used to find the pom.xml file inside the services 
    
}
mvn_job
