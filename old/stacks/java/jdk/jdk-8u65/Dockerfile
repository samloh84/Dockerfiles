FROM samuelloh/base:latest
MAINTAINER Samuel Loh <samuel_loh.yk@gmail.com>

ENV JAVA_HOME /opt/java/jdk1.8.0_65
ENV JRE_HOME ${JAVA_HOME}/jre

# Download the JDK and the JCE policies
RUN wget --progress=bar:force --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/8u65-b17/jdk-8u65-linux-x64.tar.gz \
http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip \

# Untar the JDK, move the JDK to the correct directory and remove the archive
&& mkdir -p /opt/java \
&& tar -xzf jdk-8u65-linux-x64.tar.gz --directory /opt/java \
&& rm jdk-8u65-linux-x64.tar.gz \
&& echo "Oracle Java JDK 1.8.0u65 installed" \

# Unzip the JCE policies, move the policies to the correct directory and remove the archive
&& unzip -o -qq jce_policy-8.zip -d /tmp/jce \
&& mv "$(find /tmp/jce -name local_policy.jar)" /opt/java/jdk1.8.0_65/jre/lib/local_policy.jar \
&& mv "$(find /tmp/jce -name US_export_policy.jar)" /opt/java/jdk1.8.0_65/jre/lib/US_export_policy.jar \
&& rm -rf /tmp/jce \
&& rm jce_policy-8.zip \
&& echo "Oracle Java Cryptographic Extension Unlimited Strength Jurisdiction Policy Files installed"

# Update the PATH environment variable
ENV PATH ${PATH}:${JAVA_HOME}/bin:${JRE_HOME}/bin
