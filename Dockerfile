# Docker image for OODT Workflow Manager with TensorFlow enabled

ARG ACCE_VERSION=latest
FROM acce/oodt-wmgr:${ACCE_VERSION}
MAINTAINER Luca Cinquini <luca.cinquini@jpl.nasa.gov>

# install TensorFlow in OODT virtual environment
RUN . $OODT_VENV/bin/activate && \
    pip install tensorflow
    
# install OODT configuration for this specific workflow
COPY workflows/tensorflow /usr/local/oodt/workflows/tensorflow
COPY pges/tensorflow /usr/local/oodt/pges/tensorflow

# install supervisor configuration to start the RabbitMQ consumer
COPY conf/supervisor/supervisord-rmqclient.conf /etc/supervisor/conf.d/supervisord-rmqclient.conf