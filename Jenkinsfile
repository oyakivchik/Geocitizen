pipeline {
    environment {
                CATALINA_HOME='/opt/tomcat/webapps'
    }
    agent {
           node {
              label 'master'
          }
    }

        stages {
                stage('SCM'){

                        steps {
                        checkout scm

                        }

                }
                stage('Build'){
                        steps{
                             sh 'mvn -B -DskipTests clean install'
                        }
                }
                
                stage('Docker Build') {
                       agent any
                       steps {
                       checkout scm
                       sh 'mvn -B -DskipTests clean install'
                       sh "cp "+"${env.WORKSPACE}"+"/target/citizen.war "+"."
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
