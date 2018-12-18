pipeline {
	environment {
			CATALINA_HOME='/opt/apache-tomcat-9.0.14/webapps/'
			}
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
                stage('Build'){
                        steps{
                                sh 'mvn -B -DskipTests clean package'
                        }
                }
				stage('Test') {
						steps {
							sh 'mvn test'
						}
						post {
							always {
								junit 'target/surefire-reports/*.xml'
							}
						}
				}

                stage('Deliver') {

                        steps {

                                        script {

                                                if (fileExists ('./target/citizen.war')) {
							sh "cp "+"${env.WORKSPACE}"+\
							"/target/citizen.war "+\
							"$CATALINA_HOME"
                                                } else {
							
                                                        sh "mvn clean install -DskipTests"
                                                        sh "cp "+"${env.WORKSPACE}"+\
							"/target/citizen.war "+\
							"$CATALINA_HOME"
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
										always { 
											cleanWs()
										}
                        }

                }

   }
}
