pipeline {

    agent {
        docker { image 'peteryanush/ita-maven-java-oracle:1.0' }
    }
    stages {
                stage('SCM'){

                        steps {
                        checkout scm

                        }
                }
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean install'
            }
        }
    }



}
