FROM samuelloh/base:latest
MAINTAINER Samuel Loh <samuel_loh.yk@gmail.com>

ENV PYTHON3_HOME /opt/python3/Python-3.5.0

RUN yum install -y zlib-devel bzip2-devel openssl-devel \
ncurses-devel sqlite-devel readline-devel \
tk-devel gdbm-devel db4-devel \
libpcap-devel xz-devel \
&& yum clean all \
&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 6A45C816 36580288 7D9DC8D2 18ADD4FF \
A4135B38 A74B06BF EA5BBD71 ED9D77D5 E6DF025C AA65421D 6F5E1540 F73C700D 487034E5 \

&& wget --progress=bar:force https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tgz \
https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tgz.asc \

# Verify Python archive
&& gpg --verify Python-3.5.0.tgz.asc \
&& rm Python-3.5.0.tgz.asc \

# Untar Python and remove the archive
&& mkdir -p /usr/src/python3 \
&& tar -xzf Python-3.5.0.tgz --directory /usr/src/python3 \
&& rm Python-3.5.0.tgz \
&& pushd /usr/src/python3/Python-3.5.0 \
&& ./configure \
&& make \
&& make altinstall prefix=${PYTHON3_HOME} exec-prefix=${PYTHON3_HOME} \
&& popd \
&& echo "Python 3.5.0 installed"

ENV PATH ${PATH}:${PYTHON3_HOME}/bin
