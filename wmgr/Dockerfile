# Docker image for OODT Workflow Manager with TensorFlow enabled

ARG ACCE_VERSION=latest
FROM acce/oodt-wmgr:${ACCE_VERSION}

# install TensorFlow in OODT virtual environment
RUN . $OODT_VENV/bin/activate && \
    pip install tensorflow
    
# install OODT configuration for this specific workflow
COPY conf/workflows/tensorflow /usr/local/oodt/workflows/tensorflow
COPY conf/pges/tensorflow /usr/local/oodt/pges/tensorflow
