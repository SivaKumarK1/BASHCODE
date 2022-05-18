#!/bin/bash 
# mvn installaton not working check in other instances
proj_dir="${PWD}"

mvn_job(){
    echo "Checking if Maven is installed or not"
    mvn -v
    if [ "$?" -eq  127 ]
    then
        echo "installing mvn"        
        java -version
        if [ "$?" -eq 127 ]
        then
                sudo apt install default-jre -y
                sudo apt update -y
                sudo apt install maven -y
            if [ "$?" -eq 0 ]
            then 
                for pomLocation in `find ./* -name 'pom.xml' -type f -printf "%h\n" 2>/dev/null`
                    do
                        echo "Compiling with maven, inside $pomLocation"
                        echo "============================================================================================="
                        cd $pomLocation 
                        if [ -d $pomLocation ]
                        then
                            mvn clean install 
                        fi
                        echo "============================================================================================="
                        echo "============================================================================================="
                        echo "Running Tests for your application"
                        echo "for now empty"
                        echo "============================================================================================="
                        cd $proj_dir
                    done
            fi
        fi    
    else    
        echo "mvn installation found"
        echo "Continuing Maven Build"
        for pomLocation in `find ./* -name 'pom.xml' -type f -printf "%h\n" 2>/dev/null`
            do
                echo "Compiling with maven, inside $pomLocation"
                echo "============================================================================================="
                cd $pomLocation 
                if [ -d "$pomLocation" ]
                then
                    mvn clean install 
                fi 
                echo "============================================================================================="
                echo "============================================================================================="
                echo "Running Tests for your application"
                echo "for now empty"
                echo "============================================================================================="
                cd $proj_dir
            done                     
    fi

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

#accodring to us pipeline name is nekku voche cienv file lo projectname_pipeline
    # find ./* -name 'pom.xml' -type f -printf "%h\n" 2>/dev/null
    # the above command is used to find the pom.xml file inside the services 
    
}
mvn_job
