javac /opt/tomcat/webapps/Lux_Attire/WEB-INF/classes/$1 -cp .:$CATALINA_HOME/lib/servlet-api.jar:$CATALINA_HOME/lib/mysql-connector-java-8.0.11.jar &&  /opt/tomcat/bin/shutdown.sh && /opt/tomcat/bin/startup.sh