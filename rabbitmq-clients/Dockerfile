# Docker image for RabbitMQ clients
# includes custom RabbitMQ producer 
# and standard RabbitMQ consumer
  
ARG ACCE_VERSION=latest
FROM acce/oodt-rabbitmq-clients:${ACCE_VERSION}

COPY conf/python/tensorflow_driver.py /usr/local/oodt/rabbitmq/tensorflow_driver.py

# use inherited ENTRYPOINT but pass in tensorflow specific arguments
CMD ["tensorflow", "2"]
