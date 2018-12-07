pipeline {
        agent {
            node {
                label 'master'
            }
        }

	stages {
		stage('Scm') {
			
			steps {
			checkout scm
				
			}
	
		}
		stage('Build_With_Test'){
			options {
					retry(2)
					timestamps()
			}
			steps{
				sh 'mvn clean install'
			}
		}

		stage('Build_Wothout_Test') {

			steps {
				
					script {
				
						if (fileExists ('./target/citizen.war')) {
							sh 'cp '+"${env.WORKSPACE}"+"/target/citizen.war "+'/etc/tomcat9/webapps/'
						} else {
							sh 'mvn clean install -DskipTests'
							sh 'cp '+"${env.WORKSPACE}"+"/target/citizen.war "+'/etc/tomcat9/webapps/'
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

			steps {
					deleteDir()
				}				
			}

}
}
