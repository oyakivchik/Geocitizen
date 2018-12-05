#!/usr/bin/bash

PROJECT_PATH="/usr/local/projects/Geocitizen"
DEPLOY_LOG="/var/logs/geocitizen/logs/deploy.log"

mkdir -p /var/logs/geocitizen/logs/

if [ -d $PROJECT_PATH ]; then
	rm -rf $PROJECT_PATH
	nohup git clone https://github.com/bdpqll/Geocitizen.git $PROJECT_PATH >> $DEPLOY_LOG
else
    	mkdir -p $PROJECT_PATH 
	nohup git clone https://github.com/bdpqll/Geocitizen.git $PROJECT_PATH >> $DEPLOY_LOG
fi

nohup mvn -f $PROJECT_PATH/pom.xml clean install >> $DEPLOY_LOG
if [ -e $PROJECT_PATH/target/citizen.war ];
then
	rm -rf /usr/local/tomcat9/webapps/citizen.war
	rm -rf /usr/local/tomcat9/webapps/citizen
	cp $PROJECT_PATH/target/citizen.war /usr/local/tomcat9/webapps/
else
	nohup  mvn -f $PROJECT_PATH/pom.xml clean install -DskipTests >> $DEPLOY_LOG
    	rm -rf /usr/local/tomcat9/webapps/citizen.war
    	rm -rf /usr/local/tomcat9/webapps/citizen
    	cp $PROJECT_PATH/target/citizen.war /usr/local/tomcat9/webapps/
fi

if [ -e $PROJECT_PATH/target/citizen.war ]; then echo "Your greate DevOps team"
else
	echo "You loozer DevOps"
fi
