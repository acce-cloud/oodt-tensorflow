# oodt-tensorflow

Sample application for executing a demo Tensorflow workflow within the ACCE/OODT/Docker architecture.

# Setup

Define some environment variables pointing to the location of the OODT workflow configuration,
the TensorFlow input data, and the output data. All directories MUST exist, and must be
accessible from all hosts where the containers will be running.

For example:

export OODT_CONFIG=$HOME/eclipse-workspace/oodt-tensorflow
export TENSORFLOW_DATA=$HOME/data/TENSORFLOW/MNIST_data
export OODT_ARCHIVE=$HONE/data/TENSORFLOW/archive
export OODT_JOBS=$HOME/data/TENSORFLOW/jobs
mkdir -p $OODT_ARCHIVE
mkdir -p $OODT_JOBS

Also, define the versions of th containers to use:

export ACCE_VERSION=2.0

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

# Multiple Hosts

o create a Swarm of N VMs

./swarm.setup.sh

o optional: pre-pull images to each node:

docker pull acce/oodt-node:${ACCE_VERSION}
docker pull acce/oodt-filemgr:${ACCE_VERSION}
docker pull acce/oodt-rabbitmq:${ACCE_VERSION}
docker pull acce/oodt-wmgr-tensorflow:${ACCE_VERSION}


o deploy the stack

docker stack deploy -c docker-stack.yml oodt-stack

o optional: scale the OODT WM service:

docker service scale oodt-stack_oodt-wmgr=3

o submit the workflows:

cids=`docker ps | grep oodt-rabbitmq | awk '{print $1}' | awk '{print $1}'`
cid=`echo $cids | awk '{print $1;}'`
echo $cid

export NJOBS=10
docker exec -i $cid sh -c "cd /usr/local/oodt/rabbitmq; python ./tensorflow_driver.py $NJOBS"



o cleanup:

swarm/cleanup.sh
