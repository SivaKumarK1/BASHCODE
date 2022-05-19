#!/bin/bash 
# docker login -u "anil76201" -p "Reddy@0108"
dockerUsername=anil76201 # In production replace with ${dockerUsername} that is coming from env file
dockerPassword=Reddy@0108 # In production replace with ${dockerPassword} that is coming from env file


# proj_dir="~/MicroServiceRepo"
proj_dir=${PWD}
orgNamet=TIC_IMAGES # In production replace with ${orgName} that is coming from env file
orgName=$(echo $orgNamet | tr '[:upper:]' '[:lower:]') 
DATE=`date +%Y.%m.%d.%H.%M`

docker_job(){
    sudo docker --version
    echo "============================================================================================="
    echo "Docker Installation Found"
    echo "============================================================================================="
    for dockerFileLoc in `find ./* -name 'Dockerfile' -type f -printf "%h\n" 2>/dev/null`
    do
        sudo docker login -u "anil76201" -p "Reddy@0108"
        sudo docker --version
        if [ "$?" -eq 0 ]
        then
        echo "============================================================================================="
        echo "docker deploying image of service $dockerFileLoc !!!"
            # find ./* -name 'Dockerfile' -type f -printf "%h\n" 2>/dev/null | cut -f 3 -d /
            # find ./* -name 'Dockerfile' -type f -printf "%h\n" 2>/dev/null | grep -o '.\{1\}$'
            if [ -d "$dockerFileLoc" ]
            then
                dockerImageName=`echo $dockerFileLoc | grep -o '.\{1\}$'`
                if [[ -n `sudo docker images -q $orgName/$dockerImageName:$DATE` ]]
                then
                    echo "============================================================================================="
                    echo "Image Already Found, Removing it"
                    echo "============================================================================================="
                    sudo docker rmi -f $orgName/$dockerImageName:$DATE
                else
                    echo "============================================================================================="
                    echo "No existing Image was Found, So building a new image"
                    echo "============================================================================================="
                    echo "$orgName/$dockerImageName:$DATE"
                    sudo docker build -t $orgName/$dockerImageName:$DATE $dockerFileLoc
                    sudo docker push $orgName/$dockerImageName:$DATE
                    fi
                fi
            fi
        done


#     curl -X 'POST' \
#   'http://localhost:8082/tic/api/v1/pipeline/status/1/1/1' \
#   -H 'accept: */*' \
#   -H 'Content-Type: application/json' \
#   -d '{
#   "pipelineName": "pipeline", 
#   "build": "true",
#   "test": "true",
#   "publish": "true",
#   "infraStage": "null",
#   "configStage": "null",
#   "deploy": "null"
# }'
}
#change tenantname, username, infraid after demo for now keep 1 1 1 
docker_job
