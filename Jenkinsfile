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
       stage('Docker Build') {
                       agent any
                       steps {
                       checkout scm
                       sh 'mvn -B -DskipTests clean install'
                       sh 'docker build -t peteryanush/ita-maven-java-oracle:latest .'
                       }
       }
       stage('Docker Push') {
      			agent any
      			steps {
        		withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'dockerPassword', usernameVariable: 'dockerUser')]) {
                        sh "docker login -u ${env.dockerUser} -p ${env.dockerPassword}"
                        sh 'docker push peteryanush/ita-maven-java-oracle:latest'
        }
      }
    }
    }
}
