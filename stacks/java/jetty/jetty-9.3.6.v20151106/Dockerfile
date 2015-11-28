FROM samuelloh/java:latest
MAINTAINER Samuel Loh <samuel_loh.yk@gmail.com>

ENV JETTY_HOME /opt/jetty/jetty-distribution-9.3.6.v20151106
ENV JETTY_BASE ${JETTY_HOME}

# Download the Jetty archive
RUN wget \
"http://download.eclipse.org/jetty/9.3.6.v20151106/dist/jetty-distribution-9.3.6.v20151106.tar.gz" \

# Untar Jetty, move Jetty to the correct directory and remove the archive
&& mkdir -p /opt/jetty \
&& tar -xzf jetty-distribution-9.3.6.v20151106.tar.gz --directory /opt/jetty \
&& rm jetty-distribution-9.3.6.v20151106.tar.gz \
&& echo "Eclipse Jetty 9.3.6.v20151106 installed"

# Update the PATH environment variable
ENV PATH ${PATH}:${JETTY_HOME}/bin

EXPOSE 8080

WORKDIR ${JETTY_HOME}

#CMD ${JETTY_HOME}/bin/jetty.sh run

CMD java -jar ${JETTY_HOME}/start.jar
