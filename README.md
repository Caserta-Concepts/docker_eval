# Caserta Evaluation

1. Install Docker
2. Pull and open repository in Pycharm
3. Run "docker build --tag=caserta_evaluation ." to build local docker images
4. Run "docker run -p 8888:8888 caserta_evaluation " to launch docker container
5. Go to jupyter link "localhost:8888" and complete the evaluation. 
6. Download the notebook as a .ipynb file and send to Caserta

Steps 2/3/4 in bash
```
$ git clone https://github.com/Caserta-Concepts/docker_eval.git
$ cd docker_eval
$ docker build --tag=caserta_evaluation .
$ docker run -p 8888:8888 caserta_evaluation 
```
Note: when open the notebook, to get editing access, might need to left click the 'Not Trusted'(in the top-left corner) to turn into 'Trusted'

Note: when finished this test, clean up docker images:
```buildoutcfg
$ docker image rm -f caserta_evaluation
```