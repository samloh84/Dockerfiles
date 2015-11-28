FROM samuelloh/base:latest
MAINTAINER Samuel Loh <samuel_loh.yk@gmail.com>

ENV PYTHON3_HOME /opt/python3/Python-3.5.0

RUN wget https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tgz \
https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tgz.asc \

# Untar Python and remove the archive
&& mkdir -p /opt/python3 \
&& tar -xzf Python-3.5.0.tgz --directory /opt/python3 \
&& rm Python-3.5.0.tgz \
&& pushd ${PYTHON3_HOME} \
&& ./configure \
&& make \
&& make install \
&& popd \
&& echo "Python 3.5.0 installed"

ENV PATH ${PATH}:${PYTHON3_HOME}/bin
