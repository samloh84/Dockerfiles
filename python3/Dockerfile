ARG PYTHON3_VERSION="3.8.3"
ARG PYTHON3_TEMP_DIR="/tmp/python"
ARG PYTHON3_SRC_DIR="${PYTHON3_TEMP_DIR}/src"
ARG PYTHON3_INSTALL_DIR="/opt/python"
ARG PYTHON3_ARCHIVE_FILE="Python-${PYTHON3_VERSION}.tar.xz"
ARG PYTHON3_ARCHIVE_URL="https://www.python.org/ftp/python/${PYTHON3_VERSION}/${PYTHON3_ARCHIVE_FILE}"
ARG PYTHON3_ARCHIVE_PATH="${PYTHON3_TEMP_DIR}/${PYTHON3_ARCHIVE_FILE}"
ARG PYTHON3_ARCHIVE_SIGNATURE_FILE="${PYTHON3_ARCHIVE_FILE}.asc"
ARG PYTHON3_ARCHIVE_SIGNATURE_URL="https://www.python.org/ftp/python/${PYTHON3_VERSION}/${PYTHON3_ARCHIVE_SIGNATURE_FILE}"
ARG PYTHON3_ARCHIVE_SIGNATURE_PATH="${PYTHON3_TEMP_DIR}/${PYTHON3_ARCHIVE_SIGNATURE_FILE}"
ARG PYTHON3_PUBLIC_KEY_URL="https://keybase.io/ambv/pgp_keys.asc?fingerprint=e3ff2839c048b25c084debe9b26995e310250568"
ARG PYTHON3_PUBLIC_KEY_FILE="ambv.asc"
ARG PYTHON3_PUBLIC_KEY_PATH="${PYTHON3_TEMP_DIR}/${PYTHON3_PUBLIC_KEY_FILE}"
ARG PYTHON3_GPG_KEYRING_FILE="python.gpg"
ARG PYTHON3_GPG_KEYRING_PATH="${PYTHON3_TEMP_DIR}/${PYTHON3_GPG_KEYRING_FILE}"
ARG PYTHON3_DEPENDENCIES_FILE="python-dependencies.txt"
ARG PYTHON3_DEPENDENCIES_PATH="${PYTHON3_INSTALL_DIR}/${PYTHON3_DEPENDENCIES_FILE}"

FROM fedora:latest AS builder

ARG PYTHON3_VERSION
ARG PYTHON3_TEMP_DIR
ARG PYTHON3_SRC_DIR
ARG PYTHON3_INSTALL_DIR
ARG PYTHON3_ARCHIVE_FILE
ARG PYTHON3_ARCHIVE_URL
ARG PYTHON3_ARCHIVE_PATH
ARG PYTHON3_ARCHIVE_SIGNATURE_FILE
ARG PYTHON3_ARCHIVE_SIGNATURE_URL
ARG PYTHON3_ARCHIVE_SIGNATURE_PATH
ARG PYTHON3_PUBLIC_KEY_URL
ARG PYTHON3_PUBLIC_KEY_FILE
ARG PYTHON3_PUBLIC_KEY_PATH
ARG PYTHON3_GPG_KEYRING_FILE
ARG PYTHON3_GPG_KEYRING_PATH
ARG PYTHON3_DEPENDENCIES_FILE
ARG PYTHON3_DEPENDENCIES_PATH

RUN \
set -euxo pipefail && \
dnf update -y && \
dnf install -y \
findutils xz make gcc zlib-devel bzip2 bzip2-devel readline-devel \
sqlite sqlite-devel openssl-devel tk-devel libffi-devel && \
dnf clean all && \
mkdir -p "${PYTHON3_TEMP_DIR}" "${PYTHON3_SRC_DIR}" "${PYTHON3_INSTALL_DIR}" && \
curl -sSLj -o "${PYTHON3_ARCHIVE_PATH}" "${PYTHON3_ARCHIVE_URL}" && \
curl -sSLj -o "${PYTHON3_ARCHIVE_SIGNATURE_PATH}" "${PYTHON3_ARCHIVE_SIGNATURE_URL}" && \
curl -sSLj -o "${PYTHON3_PUBLIC_KEY_PATH}" "${PYTHON3_PUBLIC_KEY_URL}" && \
gpg --no-default-keyring --keyring "${PYTHON3_GPG_KEYRING_PATH}" --import "${PYTHON3_PUBLIC_KEY_PATH}" && \
cd "${PYTHON3_TEMP_DIR}" && \
gpg --no-default-keyring --keyring "${PYTHON3_GPG_KEYRING_PATH}" --verify "${PYTHON3_ARCHIVE_SIGNATURE_FILE}" && \
tar -C "${PYTHON3_SRC_DIR}" --strip-components=1 -xf "${PYTHON3_ARCHIVE_PATH}" && \
cd "${PYTHON3_SRC_DIR}" && \
./configure --prefix="${PYTHON3_INSTALL_DIR}" && \
make -j$(nproc) && \
make install && \
rm -rf "${PYTHON3_TEMP_DIR}" && \
find "${PYTHON3_INSTALL_DIR}" -type f -executable -exec ldd {} \; | \
grep '=>' | \
awk '{print $3}' | \
sort --unique | \
xargs -L1 rpm -qf | \
sort --unique | \
tee "${PYTHON3_DEPENDENCIES_PATH}"

FROM fedora:latest

ARG PYTHON3_INSTALL_DIR
ARG PYTHON3_DEPENDENCIES_FILE
ARG PYTHON3_DEPENDENCIES_PATH

COPY --from=builder ${PYTHON3_INSTALL_DIR} ${PYTHON3_INSTALL_DIR}

ENV PATH="${PATH}:${PYTHON3_INSTALL_DIR}/bin"

RUN dnf install -y $(cat "${PYTHON3_DEPENDENCIES_PATH}") && \
rm -rf "${PYTHON3_DEPENDENCIES_PATH}" && \
dnf clean all

CMD python3


