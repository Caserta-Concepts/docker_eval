# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/scipy-notebook

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

USER root

# Spark dependencies
ENV APACHE_SPARK_VERSION 2.3.1
ENV HADOOP_VERSION 2.7

RUN apt-get -y update && \
    apt-get install --no-install-recommends -y openjdk-8-jre-headless ca-certificates-java && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
        wget -q http://apache.claz.org/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
        echo "DC3A97F3D99791D363E4F70A622B84D6E313BD852F6FDBC777D31EAB44CBC112CEEAA20F7BF835492FB654F48AE57E9969F93D3B0E6EC92076D1C5E1B40B4696 *spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" | sha512sum -c - && \
        tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /usr/local --owner root --group root --no-same-owner && \
        rm spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
RUN cd /usr/local && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark

# Mesos dependencies
# Install from the Xenial Mesosphere repository since there does not (yet)
# exist a Bionic repository and the dependencies seem to be compatible for now.
COPY mesos.key /tmp/


RUN apt-get -y update && \
    apt-get install --no-install-recommends -y gnupg && \
    apt-key add /tmp/mesos.key && \
    echo "deb http://repos.mesosphere.io/ubuntu xenial main" > /etc/apt/sources.list.d/mesosphere.list && \
    apt-get -y update && \
    apt-get --no-install-recommends -y install mesos=1.2\* && \
    apt-get purge --auto-remove -y gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Spark and Mesos config
ENV SPARK_HOME /usr/local/spark
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.7-src.zip
ENV MESOS_NATIVE_LIBRARY /usr/local/lib/libmesos.so
ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info

# Install pyarrow
RUN conda install --quiet -y 'pyarrow' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER root

RUN mkdir work/train.pqt
RUN wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/.part-r-00000-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc -O work/train.pqt/.part-r-00000-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc
RUN wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/.part-r-00001-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc -O work/train.pqt/.part-r-00001-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc
RUN wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/.part-r-00002-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc -O work/train.pqt/.part-r-00002-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc
RUN wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/.part-r-00003-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc -O work/train.pqt/.part-r-00003-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc
RUN wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/_SUCCESS -O work/train.pqt/_SUCCESS
RUN wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/part-r-00000-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet -O work/train.pqt/part-r-00000-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet
RUN wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/part-r-00001-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet -O work/train.pqt/part-r-00001-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet
RUN wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/part-r-00002-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet -O work/train.pqt/part-r-00002-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet
RUN wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/part-r-00003-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet -O work/train.pqt/part-r-00003-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet

RUN wget http://s3-sa-east-1.amazonaws.com/caserta-notebooks/bw/Skills.ipynb -O work/Skills.ipynb

RUN chmod 777 work/Skills.ipynb