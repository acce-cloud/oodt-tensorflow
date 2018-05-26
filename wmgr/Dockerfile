# Docker image for OODT Workflow Manager with TensorFlow enabled

ARG ACCE_VERSION=latest
FROM acce/oodt-wmgr:${ACCE_VERSION} as oodt-wmgr

FROM python:2.7

RUN apt-get update && \
    apt-get install -y default-jre
ENV JAVA_HOME=/usr/lib/jvm/default-java

# install TensorFlow in system Python
RUN pip install tensorflow

# install Workflow Manager executable and OODT directories
COPY --from=oodt-wmgr /usr/local/oodt /usr/local/oodt

# install OODT configuration for this specific workflow
COPY conf/workflows/tensorflow /usr/local/oodt/workflows/tensorflow
COPY conf/pges/tensorflow /usr/local/oodt/pges/tensorflow

# environment
ENV OODT_HOME /usr/local/oodt
ENV OODT_CONFIG ${OODT_HOME}/workflows
ENV PGE_ROOT ${OODT_HOME}/pges

EXPOSE 9001

# start Workflow Manager
WORKDIR ${OODT_HOME}/cas-workflow/bin
CMD ./wmgr start && tail -f ${OODT_HOME}/cas-workflow/logs/cas_workflow.log

