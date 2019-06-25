# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/pyspark-notebook
FROM $BASE_CONTAINER

# Set the working directory to /Caserta_evaluation
WORKDIR /Caserta_evaluation

# Copy the current directory contents into the container at /Caserta_evaluation

USER root
RUN mkdir /Caserta_evaluation/data && \
mkdir /Caserta_evaluation/data/SanFran_Crime && \
wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/.part-r-00000-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc -O /Caserta_evaluation/data/SanFran_Crime/.part-r-00000-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc && \
wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/.part-r-00001-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc -O /Caserta_evaluation/data/SanFran_Crime/.part-r-00001-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc && \
wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/.part-r-00002-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc -O /Caserta_evaluation/data/SanFran_Crime/.part-r-00002-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc && \
wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/.part-r-00003-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc -O /Caserta_evaluation/data/SanFran_Crime/.part-r-00003-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet.crc && \
wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/_SUCCESS -O /Caserta_evaluation/data/SanFran_Crime/_SUCCESS && \
wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/part-r-00000-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet -O /Caserta_evaluation/data/SanFran_Crime/part-r-00000-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet && \
wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/part-r-00001-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet -O /Caserta_evaluation/data/SanFran_Crime/part-r-00001-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet && \
wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/part-r-00002-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet -O /Caserta_evaluation/data/SanFran_Crime/part-r-00002-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet && \
wget https://s3.amazonaws.com/caserta-bucket1/train.pqt/part-r-00003-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet -O /Caserta_evaluation/data/SanFran_Crime/part-r-00003-0ef98704-d41e-4eea-8c0a-86ac172c87fb.snappy.parquet && \
wget http://s3-sa-east-1.amazonaws.com/caserta-notebooks/bw/Skills.ipynb -O /Caserta_evaluation/Skills.ipynb && \
mkdir /Caserta_evaluation/data/Seahawks && \
wget https://s3.amazonaws.com/caserta-bucket1/Seahawks/game.csv -O /Caserta_evaluation/data/Seahawks/game.csv && \
chmod 777 /Caserta_evaluation/Skills.ipynb

CMD jupyter notebook --NotebookApp.token='' --allow-root

