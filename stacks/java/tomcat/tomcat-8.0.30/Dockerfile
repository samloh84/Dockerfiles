FROM samuelloh/java:latest
MAINTAINER Samuel Loh <samuel_loh.yk@gmail.com>

ENV CATALINA_HOME /opt/tomcat/apache-tomcat-8.0.30

# Download the Tomcat archive
RUN wget --progress=bar:force http://www.us.apache.org/dist/tomcat/tomcat-8/v8.0.30/bin/apache-tomcat-8.0.30.tar.gz \

# Untar Tomcat, move Tomcat to the correct directory and remove the archive
&& mkdir -p /opt/tomcat \
&& tar -xzf apache-tomcat-8.0.30.tar.gz --directory /opt/tomcat \
&& rm apache-tomcat-8.0.30.tar.gz \
&& echo "Apache Tomcat 8.0.30 installed"

# Update the PATH environment variable
ENV PATH ${PATH}:${CATALINA_HOME}/bin

EXPOSE 8080

WORKDIR ${CATALINA_HOME}

CMD ${CATALINA_HOME}/bin/catalina.sh run


