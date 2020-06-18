FROM fedora:latest

RUN \
set -euxo pipefail && \
rpm --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF" && \
curl -sSLj https://download.mono-project.com/repo/centos8-stable.repo | tee /etc/yum.repos.d/centos8-stable.repo && \
dnf update -y && \
dnf install -y mono-complete && \
dnf clean all

CMD mono


