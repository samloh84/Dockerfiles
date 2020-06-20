ARG NGINX_VERSION="1.19.0"
ARG NGINX_TEMP_DIR="/tmp/nginx"
ARG NGINX_SRC_DIR="${NGINX_TEMP_DIR}/src"
ARG NGINX_INSTALL_DIR="/opt/nginx"
ARG NGINX_ARCHIVE_FILE="nginx-${NGINX_VERSION}.tar.gz"
ARG NGINX_ARCHIVE_URL="https://nginx.org/download/${NGINX_ARCHIVE_FILE}"
ARG NGINX_ARCHIVE_PATH="${NGINX_TEMP_DIR}/${NGINX_ARCHIVE_FILE}"
ARG NGINX_ARCHIVE_SIGNATURE_FILE="${NGINX_ARCHIVE_FILE}.asc"
ARG NGINX_ARCHIVE_SIGNATURE_URL="https://nginx.org/download/${NGINX_ARCHIVE_SIGNATURE_FILE}"
ARG NGINX_ARCHIVE_SIGNATURE_PATH="${NGINX_TEMP_DIR}/${NGINX_ARCHIVE_SIGNATURE_FILE}"
ARG NGINX_GPG_PUBLIC_KEY_URLS="https://nginx.org/keys/mdounin.key https://nginx.org/keys/maxim.key https://nginx.org/keys/sb.key"
ARG NGINX_DEPENDENCIES_FILE="nginx-dependencies.txt"
ARG NGINX_DEPENDENCIES_PATH="${NGINX_INSTALL_DIR}/${NGINX_DEPENDENCIES_FILE}"

FROM fedora:latest AS builder

ARG NGINX_VERSION
ARG NGINX_TEMP_DIR
ARG NGINX_SRC_DIR
ARG NGINX_INSTALL_DIR
ARG NGINX_ARCHIVE_FILE
ARG NGINX_ARCHIVE_URL
ARG NGINX_ARCHIVE_PATH
ARG NGINX_ARCHIVE_SIGNATURE_FILE
ARG NGINX_ARCHIVE_SIGNATURE_URL
ARG NGINX_ARCHIVE_SIGNATURE_PATH
ARG NGINX_GPG_PUBLIC_KEY_URLS
ARG NGINX_DEPENDENCIES_FILE
ARG NGINX_DEPENDENCIES_PATH

RUN \
set -euxo pipefail && \
dnf update -y && \
dnf install -y \
findutils xz make gcc gcc-g++ zlib-devel bzip2 bzip2-devel openssl-devel gnupg2 \
pcre-devel openssl-devel && \
dnf clean all && \
mkdir -p "${NGINX_TEMP_DIR}" "${NGINX_SRC_DIR}" "${NGINX_INSTALL_DIR}" && \
curl -sSLj -o "${NGINX_ARCHIVE_PATH}" "${NGINX_ARCHIVE_URL}" && \
curl -sSLj -o "${NGINX_ARCHIVE_SIGNATURE_PATH}" "${NGINX_ARCHIVE_SIGNATURE_URL}" && \
for NGINX_GPG_PUBLIC_KEY_URL in ${NGINX_GPG_PUBLIC_KEY_URLS}; do \
curl -sSLj "${NGINX_GPG_PUBLIC_KEY_URL}" | gpg --import -; \
done && \
cd "${NGINX_TEMP_DIR}" && \
gpg --verify "${NGINX_ARCHIVE_SIGNATURE_FILE}" && \
tar -C "${NGINX_SRC_DIR}" --strip-components=1 -xf "${NGINX_ARCHIVE_PATH}" && \
cd "${NGINX_SRC_DIR}" && \
./configure --prefix="${NGINX_INSTALL_DIR}" && \
make -j$(nproc) && \
make install && \
rm -rf "${NGINX_TEMP_DIR}" && \
find "${NGINX_INSTALL_DIR}" -type f -executable -exec ldd {} \; | \
grep '=>' | \
awk '{print $3}' | \
sort --unique | \
xargs -L1 rpm -qf | \
sort --unique | \
tee "${NGINX_DEPENDENCIES_PATH}"

FROM fedora:latest

ARG NGINX_INSTALL_DIR
ARG NGINX_DEPENDENCIES_FILE
ARG NGINX_DEPENDENCIES_PATH

COPY --from=builder ${NGINX_INSTALL_DIR} ${NGINX_INSTALL_DIR}

ENV PATH="${PATH}:${NGINX_INSTALL_DIR}/sbin"

RUN dnf install -y $(cat "${NGINX_DEPENDENCIES_PATH}") && \
rm -rf "${NGINX_DEPENDENCIES_PATH}" && \
dnf clean all

EXPOSE 80

CMD nginx -g 'daemon off; error_log /dev/stdout info;'
