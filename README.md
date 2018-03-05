# oodt-tensorflow

Sample application for executing a demo Tensorflow workflow within the ACCE/OODT/Docker architecture.

# Single Host

* Start the OODT containers on a single host:
  * docker-compose up -d
  * docker-compose logs -f

* To run the Tensorflow script directly from inside the Workflow Manager container:
  * docker exec -it wmgr /bin/bash
  * cd $PGE_ROOT/tensorflow/pges
  * python mnist_softmax.py --data_dir /tmp/MNIST_data --num_images 100 --output_file output.txt
  * cat output.txt
  * Note: MNIST_data will be downloaded automatically to the specified "data_dir" directory, if not existing already

* To run the Tensorflow script one time only as a workflow, from inside the Workflow Manager container:
  * docker exec -it wmgr /bin/bash
  * cd $OODT_HOME/cas-worklfow/bin
  * ./wmgr-client --url http://localhost:9001 --operation --sendEvent --eventName tensorflow --metaData --key num_images 100 --key data_dir /tmp/MNIST_data --output_file output.txt

* To execute N instances of the workflow, running the driver script from inside the RabbitMQ container:
  * export NJOBS=10
  * docker exec -i rabbitmq sh -c "cd /usr/local/oodt/rabbitmq; python ./tensorflow_driver.py $NJOBS"
  * docker exec -it filemgr sh -c "ls -l /usr/local/oodt/archive/tensorflow/"
