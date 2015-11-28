FROM samuelloh/base:latest
MAINTAINER Samuel Loh <samuel_loh.yk@gmail.com>

ENV JAVA_HOME /opt/java/jdk1.7.0_80
ENV JRE_HOME ${JAVA_HOME}/jre

# Download the JDK and the JCE policies
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz \
http://download.oracle.com/otn-pub/java/jce/7/UnlimitedJCEPolicyJDK7.zip \

# Untar the JDK, move the JDK to the correct directory and remove the archive
&& mkdir -p /opt/java \
&& tar -xzf jdk-7u80-linux-x64.tar.gz --directory /opt/java \
&& rm jdk-7u80-linux-x64.tar.gz \
&& echo "Oracle Java JDK 1.7.0u80 installed" \

# Unzip the JCE policies, move the policies to the correct directory and remove the archive
&& unzip -o -qq UnlimitedJCEPolicyJDK7.zip -d /tmp/jce \
&& mv "$(find /tmp/jce -name local_policy.jar)" /opt/java/jdk1.7.0_80/jre/lib/local_policy.jar \
&& mv "$(find /tmp/jce -name US_export_policy.jar)" /opt/java/jdk1.7.0_80/jre/lib/US_export_policy.jar \
&& rm -rf /tmp/jce \
&& rm UnlimitedJCEPolicyJDK7.zip \
&& echo "Oracle Java Cryptographic Extension Unlimited Strength Jurisdiction Policy Files installed"

# Update the PATH environment variable
ENV PATH ${PATH}:${JAVA_HOME}/bin:${JRE_HOME}/bin
