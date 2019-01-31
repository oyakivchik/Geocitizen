FROM jeanblanchard/tomcat:tomcat9-java8
COPY ./citizen.war $CATALINA_HOME/webapps


