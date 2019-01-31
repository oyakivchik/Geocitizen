pipeline {
    agent none
    stages {
        stage('Back-end') {
            agent {
                docker { image 'peteryanush/ita-maven-java-oracle:1.0'}
            }
            steps {
			    checkout scm
                sh 'mvn -B -DskipTests clean install'
            }
        }

    }
}
