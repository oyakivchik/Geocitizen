FROM jeanblanchard/tomcat:tomcat9-java8
COPY target/*.war /opt/tomcat/webapps/


