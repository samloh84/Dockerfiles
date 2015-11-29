FROM centos:centos7
MAINTAINER Samuel Loh <samuel_loh.yk@gmail.com>

# Install common dependencies
RUN yum groupinstall -y "Development Tools" \
&& yum install -y git ca-certificates wget curl tar unzip epel-release \
&& yum clean all


