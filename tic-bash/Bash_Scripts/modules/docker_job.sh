#!/bin/bash 
# docker login -u "anil76201" -p "Reddy@0108"
dockerUsername=anil76201 # In production replace with ${dockerUsername} that is coming from env file
dockerPassword=Reddy@0108 # In production replace with ${dockerPassword} that is coming from env file


docker_job(){
    echo "============================================================================================="
    echo "Building Docker Images for your MicroServices"
    echo "============================================================================================="
    echo "Checking if docker is installed or not"
    docker --version
    if [ "$?" -eq 1 ]
    then
        echo "============================================================================================="
        echo "Installing Docker"
        echo "============================================================================================="
        sudo apt-get update
        sudo apt-get install ca-certificates curl gnupg lsb-release
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
        if [ "$?" -eq 0 ]
        then
            echo "============================================================================================="
            echo "Docker Installation Done"
            echo "============================================================================================="
            echo "Logging to your container registry"

            echo "Building Docker Images"
            for dockerFileLoc in `find ./* -name 'Dockerfile' -type f -printf "%h\n" 2>/dev/null`
            do
                docker --version
                if [ "$?" -eq 0 ]
                then
                echo "============================================================================================="
                echo "docker deploying image of service $dockerFileLoc !!!"
                    # find ./* -name 'Dockerfile' -type f -printf "%h\n" 2>/dev/null | cut -f 3 -d /
                    # find ./* -name 'Dockerfile' -type f -printf "%h\n" 2>/dev/null | grep -o '.\{1\}$'
                    if [ -d "$dockerFileLoc" ]
                    then
                        dockerImageName=`echo $dockerFileLoc | grep -o '.\{1\}$'`
                        if [[ -n `docker images -q $orgName/$dockerImageName:$DATE` ]]
                        then
                            echo "============================================================================================="
                            echo "Image Already Found, Removing it"
                            echo "============================================================================================="

                            sudo docker rmi -f $orgName/$dockerImageName:$DATE
                        else
                            echo "============================================================================================="
                            echo "No existing Image was Found, So building a new image"
                            echo "============================================================================================="
                            sudo docker build -t $orgName/$dockerImageName:$DATE $dockerFileLoc
                            sudo docker push $orgName/$dockerImageName:$DATE
                        fi
                    fi
                fi
            done
        else
            echo "============================================================================================="
            echo "Docker Installation Failed"
            echo "============================================================================================="
        fi
    else
        echo "============================================================================================="
        echo "Docker Installation Found"
        echo "============================================================================================="
        for dockerFileLoc in `find ./* -name 'Dockerfile' -type f -printf "%h\n" 2>/dev/null`
        do
            docker --version
            if [ "$?" -eq 0 ]
            then
            echo "============================================================================================="
            echo "docker deploying image of service $dockerFileLoc !!!"
                # find ./* -name 'Dockerfile' -type f -printf "%h\n" 2>/dev/null | cut -f 3 -d /
                # find ./* -name 'Dockerfile' -type f -printf "%h\n" 2>/dev/null | grep -o '.\{1\}$'
                if [ -d "$dockerFileLoc" ]
                then
                    dockerImageName=`echo $dockerFileLoc | grep -o '.\{1\}$'`
                    if [[ -n `docker images -q $orgName/$dockerImageName:$DATE` ]]
                    then
                        echo "============================================================================================="
                        echo "Image Already Found, Removing it"
                        echo "============================================================================================="
                        sudo docker rmi -f $orgName/$dockerImageName:$DATE
                    else
                        echo "============================================================================================="
                        echo "No existing Image was Found, So building a new image"
                        echo "============================================================================================="
                        sudo docker build -t $orgName/$dockerImageName:$DATE $dockerFileLoc
                        sudo docker push $orgName/$dockerImageName:$DATE
                    fi
                fi
            fi
        done
    fi
}
docker_job
