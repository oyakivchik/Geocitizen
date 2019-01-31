pipeline {
    agent none
    stages {
        stage('slave') {
            agent {
                docker { image 'peteryanush/ita-maven-java-oracle:1.0'}
            }
            steps {
	        checkout scm
                sh 'mvn -B -DskipTests clean install'
            }
        }
        stage('master'){
          steps {
          node {
	      label 'maste node'
              checkout scm
              sh 'mvn -B -DskipTests clean install'
		script {
              		def testImage = docker.build("peteryanush/ita-maven-java-oracle:1.1", "./") 

	              testImage.inside {
        	       sh 'ls /opt/tomcat/webapps'
              		}         
		}   
        }
        }
        }
    }
}
