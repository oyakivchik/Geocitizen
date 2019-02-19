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
    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean install'
            }
        }
    }


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

                stage('Deliver') {

                        steps {

                                        script {

                                                if (fileExists ('./target/citizen.war')) {
                                                        sh "docker cp jenkins-58b96b566f-p62xq:"+"${env.WORKSPACE}"+\
                                                        "/target/citizen.war "+\
                                                        "tomcat-pod-55968f9dbc-ng596:$CATALINA_HOME"
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

