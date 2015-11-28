FROM samuelloh/base:latest
MAINTAINER Samuel Loh <samuel_loh.yk@gmail.com>

ENV PYTHON2_HOME /opt/python2/Python-2.7.10

RUN wget https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz \
https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz.asc \

# Untar Python and remove the archive
&& mkdir -p /opt/python2 \
&& tar -xzf Python-2.7.10.tgz --directory /opt/python2 \
&& rm Python-2.7.10.tgz \
&& pushd ${PYTHON2_HOME} \
&& ./configure \
&& make \
&& make install \
&& popd \
&& echo "Python 2.7.10 installed"

ENV PATH ${PATH}:${PYTHON2_HOME}/bin


