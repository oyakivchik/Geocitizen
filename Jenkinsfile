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
          node (label='master node'){
	     
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
          steps {
                withDockerRegistry([ credentialsId: "6544de7e-17a4-4576-9b9b-e86bc1e4f903", url: "" ]) {
                sh 'docker push peteryanush/ita-maven-java-oracle:latest'
        }
        }
    }
}
