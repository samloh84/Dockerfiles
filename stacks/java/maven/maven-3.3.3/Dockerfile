FROM samuelloh/java:latest
MAINTAINER Samuel Loh <samuel_loh.yk@gmail.com>

ENV M2_HOME /opt/maven/apache-maven-3.3.3

# Download the Maven archive
RUN wget --progress=bar:force http://www.us.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz \

# Untar Maven, move Maven to the correct directory and remove the archive
&& mkdir -p /opt/maven \
&& tar -xzf apache-maven-3.3.3-bin.tar.gz --directory /opt/maven \
&& rm apache-maven-3.3.3-bin.tar.gz \
&& echo "Apache Maven 3.3.3 installed"

# Update the PATH environment variable
ENV PATH ${PATH}:${M2_HOME}/bin
