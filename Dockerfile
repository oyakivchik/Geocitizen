FROM jeanblanchard/tomcat:tomcat9-java8
COPY target/*.war ${CATALINA_HOME}/webapps/


