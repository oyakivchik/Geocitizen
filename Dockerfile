FROM jeanblanchard/tomcat:tomcat9-java8
COPY "${env.WORKSPACE}"+"/target/citizen.war "+"$CATALINA_HOME"+"/webapps"


