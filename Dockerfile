# Start out with the minimalist Alpine with Java
FROM openjdk:8-alpine
RUN apk --update add wget tar bash

# Download and unpack/install Spark 2.4.3
RUN wget -nv http://mirror.metrocast.net/apache/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz
RUN tar -xzf spark-2.4.3-bin-hadoop2.7.tgz && \
	mv spark-2.4.3-bin-hadoop2.7 /spark && \
	rm spark-2.4.3-bin-hadoop2.7.tgz

# Install some dependencies for PySpark and Jupyter
RUN apk add build-base g++ zeromq-dev libc6-compat
RUN apk add --update python3 python3-dev

# Take care of a couple patches to the installs
RUN ln -s /usr/bin/python3 /usr/bin/python && \
  ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2
RUN pip3 install jupyterlab

# Quasi-manual creation of a suitable Jupyter kernal for PySpark
RUN mkdir /usr/share/jupyter/kernels/Py3Spark && \
  echo '{ "display_name": "PySpark (Python3, Spark 2.4.3)", ' >> /usr/share/jupyter/kernels/Py3Spark/kernel.json && \
  echo ' "language": "python3", ' >> /usr/share/jupyter/kernels/Py3Spark/kernel.json && \
  echo ' "argv": [ "/usr/bin/python3", "-m", "ipykernel", "-f", "{connection_file}" ], ' >> /usr/share/jupyter/kernels/Py3Spark/kernel.json && \
  echo ' "env": { ' >> /usr/share/jupyter/kernels/Py3Spark/kernel.json && \
  echo '  "SPARK_HOME": "/spark", ' >> /usr/share/jupyter/kernels/Py3Spark/kernel.json && \
  echo '  "PYTHONPATH": "/spark/python:/spark/python/lib/py4j-0.10.7-src.zip", ' >> /usr/share/jupyter/kernels/Py3Spark/kernel.json && \
  echo '  "PYTHONSTARTUP": "/spark/python/pyspark/shell.py", ' >> /usr/share/jupyter/kernels/Py3Spark/kernel.json && \
  echo '  "PYSPARK_PYTHON": "/usr/bin/python3" ' >> /usr/share/jupyter/kernels/Py3Spark/kernel.json && \
  echo ' } ' >> /usr/share/jupyter/kernels/Py3Spark/kernel.json && \
  echo '}' >> /usr/share/jupyter/kernels/Py3Spark/kernel.json 

# Now, download the sample datasets and the evaluation notebook
# (I wish there was a better way to download the parquet part files from the S3 bucket)
USER root
RUN mkdir -p /Caserta_evaluation/data && \
  mkdir -p /Caserta_evaluation/data/SanFran_Crime && \
  wget -nv https://s3.amazonaws.com/caserta-bucket1/train.pqt/_SUCCESS -O /Caserta_evaluation/data/SanFran_Crime/_SUCCESS && \
  wget -nv https://s3.amazonaws.com/caserta-bucket1/train.pqt/part-r-00000-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet -O /Caserta_evaluation/data/SanFran_Crime/part-r-00000-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet && \
  wget -nv https://s3.amazonaws.com/caserta-bucket1/train.pqt/part-r-00001-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet -O /Caserta_evaluation/data/SanFran_Crime/part-r-00001-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet && \
  wget -nv https://s3.amazonaws.com/caserta-bucket1/train.pqt/part-r-00002-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet -O /Caserta_evaluation/data/SanFran_Crime/part-r-00002-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet && \
  wget -nv https://s3.amazonaws.com/caserta-bucket1/train.pqt/part-r-00003-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet -O /Caserta_evaluation/data/SanFran_Crime/part-r-00003-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet && \
  wget -nv http://s3-sa-east-1.amazonaws.com/caserta-notebooks/bw/Skills.ipynb -O /Caserta_evaluation/Skills.ipynb && \
  mkdir -p /Caserta_evaluation/data/Seahawks && \
  wget -nv https://s3.amazonaws.com/caserta-bucket1/Seahawks/game.csv -O /Caserta_evaluation/data/Seahawks/game.csv && \
  chmod 777 /Caserta_evaluation/Skills.ipynb

CMD jupyter notebook --NotebookApp.token='' --allow-root --no-browser --ip=*
