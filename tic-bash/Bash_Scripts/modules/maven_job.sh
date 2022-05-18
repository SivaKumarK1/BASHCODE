#!/bin/bash 
# mvn installaton not working check in other instances
mvn_job(){
    echo "Checking if Maven is installed or not"
    echo `mvn -v`
    if [ "$?" -eq  0 ]
        then
            echo "mvn installation found"
            echo "Continuing Maven Build"
            for pomLocation in `find ./* -name 'pom.xml' -type f -printf "%h\n" 2>/dev/null`
            do
                echo "Compiling with maven, inside $pomLocation"
                echo "============================================================================================="
                cd $pomLocation 
                mvn clean install 
                echo "============================================================================================="
                echo "============================================================================================="
                echo "Running Tests for your application"
                echo "for now empty"
                echo "============================================================================================="
                cd $proj_dir

            done
    else
        echo "installing mvn"        
        java -version
        if [ "$?" -eq 127 ]
            then
                sudo apt install default-jdk -y
                sudo apt install maven -y
            if [ "$?" -eq 0 ]
            then 
                for pomLocation in `find ./* -name 'pom.xml' -type f -printf "%h\n" 2>/dev/null`
                do
                    echo "Compiling with maven, inside $pomLocation"
                    echo "============================================================================================="
                    cd $pomLocation
                    mvn clean install 
                    echo "============================================================================================="
                    echo "============================================================================================="
                    echo "Running Tests for your application"
                    echo "for now empty"
                    echo "============================================================================================="
                    cd $proj_dir
                done                
            fi     
        else
            echo "failed to install maven"
        fi
    fi

    # find ./* -name 'pom.xml' -type f -printf "%h\n" 2>/dev/null
    # the above command is used to find the pom.xml file inside the services 
    
}
