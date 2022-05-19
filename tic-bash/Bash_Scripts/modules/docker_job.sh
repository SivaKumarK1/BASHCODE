#!/bin/bash 
# docker login -u "anil76201" -p "Reddy@0108"
dockerUsername="anil76201" # In production replace with ${dockerUsername} that is coming from env file
dockerPassword="Reddy@0108" # In production replace with ${dockerPassword} that is coming from env file


# proj_dir="~/MicroServiceRepo"
proj_dir=${PWD}
# orgNamet=TIC_IMAGES # In production replace with ${orgName} that is coming from env file
# orgName=$(echo $orgNamet | tr '[:upper:]' '[:lower:]') 
# DATE=`date +%Y.%m.%d.%H.%M`

# install docker-engine
sudo apt-get update -y
sudo apt-get install ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo apt-get update -y
echo "Docker installed"

docker_job(){
    sudo docker --version
    echo "============================================================================================="
    echo "Docker Installation Found"
    echo "============================================================================================="
    for dockerFileLoc in `find ./* -name 'Dockerfile' -type f -printf "%h\n" 2>/dev/null`
    do
        sudo docker login -u $dockerUsername -p $dockerPassword
        sudo docker --version
        if [ "$?" -eq 0 ]
        then
        echo "============================================================================================="
        echo "docker deploying image of service $dockerFileLoc !!!"
            # find ./* -name 'Dockerfile' -type f -printf "%h\n" 2>/dev/null | cut -f 3 -d /
            # find ./* -name 'Dockerfile' -type f -printf "%h\n" 2>/dev/null | grep -o '.\{1\}$'
            if [ -d "$dockerFileLoc" ]
            then
                dockerImageName=`echo $dockerFileLoc | cut -d "/" -f 3`
                if [[ -n `sudo docker images -q $dockerUsername/$dockerImageName` ]] #:$DATE
                then
                    echo "============================================================================================="
                    echo "Image Already Found, Removing it"
                    echo "============================================================================================="
                    sudo docker rmi -f $dockerUsername/$dockerImageName #:$DATE
                else
                    echo "============================================================================================="
                    echo "No existing Image was Found, So building a new image"
                    echo "============================================================================================="
                    echo "$dockerUsername/$dockerImageName"
                    sudo docker build -t $dockerUsername/$dockerImageName $dockerFileLoc #:$DATE
                    sudo docker push $dockerUsername/$dockerImageName  #:$DATE
                    fi
                fi
            fi
        done


curl -X 'PATCH' \
  'http://localhost:8082/tic/api/v1/pipeline/status/user/1/1' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "pipelineName": "pipeline",
  "build": "true",
  "test": "true",
  "publish": "true",
  "infraStage": "false",
  "configStage": "false",
  "deploy": "false"
}'

}
#change tenantname, username, infraid after demo for now keep 1 1 1 
docker_job
