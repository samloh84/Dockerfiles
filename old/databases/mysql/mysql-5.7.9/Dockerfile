FROM samuelloh/base:latest
MAINTAINER Samuel Loh <samuel_loh.yk@gmail.com>

ENV MYSQL_HOME /opt/mysql/mysql-5.7.9-linux-glibc2.5-x86_64

RUN yum install -y libaio openssl \
&& yum clean all \
&& gpg --keyserver keys.gnupg.net --recv-keys 5072E1F5 \

&& wget --progress=bar:force http://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.9-linux-glibc2.5-x86_64.tar.gz \
&& wget --progress=bar:force http://dev.mysql.com/downloads/gpg/?file=mysql-5.7.9-linux-glibc2.5-x86_64.tar.gz \
-O mysql-5.7.9-linux-glibc2.5-x86_64.tar.gz.asc \
&& sed -i -n '/-----BEGIN PGP SIGNATURE-----/,/-----END PGP SIGNATURE-----/p' mysql-5.7.9-linux-glibc2.5-x86_64.tar.gz.asc \

# Verify MySQL archive
&& gpg --verify mysql-5.7.9-linux-glibc2.5-x86_64.tar.gz.asc \
&& rm mysql-5.7.9-linux-glibc2.5-x86_64.tar.gz.asc \

# Untar MySQL and remove the archive
&& mkdir -p /opt/mysql \
&& tar -xzf mysql-5.7.9-linux-glibc2.5-x86_64.tar.gz --directory /opt/mysql \
&& rm mysql-5.7.9-linux-glibc2.5-x86_64.tar.gz \
&& ln -s ${MYSQL_HOME} /usr/local/mysql \
&& groupadd mysql \
&& useradd -r -g mysql -s /bin/false mysql \
&& pushd ${MYSQL_HOME} \
&& mkdir mysql-files \
&& chmod 770 mysql-files \
&& chown -R mysql:mysql . \
&& bin/mysqld --initialize --user=mysql \
&& bin/mysql_ssl_rsa_setup --datadir ${MYSQL_HOME}/data \
&& chown -R root . \
&& chown -R mysql data mysql-files \
&& popd \
&& echo "MySQL 5.7.9 installed"

ENV PATH ${PATH}:${MYSQL_HOME}/bin

WORKDIR ${MYSQL_HOME}

CMD bin/mysqld_safe --user=mysql
