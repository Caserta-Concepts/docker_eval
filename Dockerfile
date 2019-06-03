# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/pyspark-notebook
FROM $BASE_CONTAINER

# Set the working directory to /Caserta_evaluation
WORKDIR /Caserta_evaluation

# Copy the current directory contents into the container at /Caserta_evaluation
# This wil raise permission issue
# COPY . /Caserta_evaluation

CMD jupyter notebook --NotebookApp.token=''

