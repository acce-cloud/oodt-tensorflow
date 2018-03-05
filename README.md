# oodt-tensorflow


o to run the program directly from inside the wmgr-tensorflow container:


cd $PGE_ROOT/tensorflow/pges
python mnist_softmax.py --data_dir /tmp/MNIST_data --num_images 100 
cat output.txt

MNIST_data will be downloaded autonatically to the specified "data_dir" directory, if not existing already

o to run the program as a workflow

cd $OODT_HOME/cas-worklfow/bin
./wmgr-client --url http://localhost:9001 --operation --sendEvent --eventName tensorflow --metaData --key num_images 100 --key data_dir /tmp/MNIST_data

o to execute many workflows by submitting messages to RMQ:

MT-106019:oodt-tensorflow cinquini$ export NJOBS=10
MT-106019:oodt-tensorflow cinquini$ docker exec -i rabbitmq sh -c "cd /usr/local/oodt/rabbitmq; python ./tensorflow_driver.py $NJOBS"

check output:

docker exec -it filemgr sh -c "ls -l /usr/local/oodt/archive/tensorflow/output.txt"
