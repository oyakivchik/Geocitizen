script {
    STATUS_PATH = '/var/jenkins/dumb-slave-1/workspace/status/'
    PROJECT_PATH='/usr/local/projects/Geocitizen'
    DEPLOY_LOG='/var/logs/geocitizen/logs/deploy.log'
}

pipeline {
    agent none

stages {
    stage('LOCAL') {
        agent {
            node {
                label 'master'
            }
        }
        steps {
	    checkout scm
            sh ('mkdir -p /var/logs/geocitizen/logs/')
	    
            sh ('mvn install -DskipTests')
	
        }

    }


    stage('Build') {
        agent {
            node {
                label 'master'
            }
        }
        options {
            retry(2)
            timestamps()
        }
        steps {
                script {
                    if (fileExists ('/target/citizen.war')) {
                        dir('/usr/local/tomcat9/webapps/'){
                             sh 'rm -rf citizen.war'
                        }

                        dir('/usr/local/tomcat9/webapps/citizen'){
                                deleteDir()
                        }
                        sh 'cp /target/citizen.war /usr/local/tomcat9/webapps/'
                    } else {
                        sh 'mvn clean install -DskipTests'
			dir('/usr/local/tomcat9/webapps/'){
				 sh 'rm -rf citizen.war'
			}
                        
                        dir('/usr/local/tomcat9/webapps/citizen'){
				deleteDir()
			}
                        sh 'cp /target/citizen.war /usr/local/tomcat9/webapps/'


                    }
                }

        }
        
        post {
                failure {
                        mail subject: "${currentBuild.fullDisplayName} FAILURE",
                        body: "${env.BUILD_URL}",
                        to: 'petiayanush@gmail.com, petiaianush@gmail.com'
                }
                success {
                        mail subject: "${currentBuild.fullDisplayName} SUCCESS",
                        body: "${env.BUILD_URL}",
                        to: 'petiayanush@gmail.com, petiaianush@gmail.com'
                        }

        }
        
    }

    stage('Cleanup') {
        agent {
            node {
                label 'MASTER'
            }
        }
	steps {
            sh 'mvn clean'
        }
        }
        
    }

}
