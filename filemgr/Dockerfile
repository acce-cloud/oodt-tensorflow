# Docker image for OODT File Manager with TensorFlow product configuration

ARG ACCE_VERSION=latest
FROM acce/oodt-filemgr:${ACCE_VERSION}

# install OODT configuration for this specific products
COPY conf/workflows/tensorflow /usr/local/oodt/workflows/tensorflow
