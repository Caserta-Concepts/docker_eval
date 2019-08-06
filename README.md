# Caserta Evaluation

## For Mac User
1. Install Docker

2. Pull and open repository in Terminal
3. Run "docker build --tag=caserta_evaluation ." to build local docker images (may take up to 20 minutes to complete)
4. Run "docker run -p 8888:8888 caserta_evaluation " to launch docker container
5. Go to jupyter link "localhost:8888" and complete the evaluation. 
6. Download the notebook as a .ipynb file and send to Andre Chapman (andre@caserta.com)

Steps 2/3/4 in bash
```
$ git clone https://github.com/Caserta-Concepts/docker_eval.git
$ cd docker_eval
$ docker build --tag=caserta_evaluation .
$ docker run -p 8888:8888 caserta_evaluation 
```

## For Windows User

*Windows 7/8/10 home with 64bit:*
1. Install Docker Toolbox: https://docs.docker.com/toolbox/toolbox_install_windows/

2. Open Windows local Terminal, clone Github repo under `C:\Users ` (Toolbox mounts `C:\Users` into the VMs at `/c/Users`)

3. Docker Quickstart Terminal is installed on Desktop, click the icon to launch Docker Toolbox, and wait for the VM to be initiated 

4. Locate docker_eval dir, run "cd /c/Users/docker_eval"

5. Run "docker build --tag=caserta_evaluation ." to build local docker images (may take up to 20 minutes to complete)

6. Run "docker-machine ip" to get VM ip adddress, the output will look something like this: 192.168.99.104 

7. Run "docker run -p 8888:8888 caserta_evaluation " to launch docker container

8. Go to jupyter link "  <your ip address (see above)>:8888  " and complete the evaluation.

9. Download the notebook as a .ipynb file and send to Andre Chapman (andre@caserta.com)

Steps 2/4/5/6/7 in bash
```
$ git clone https://github.com/Caserta-Concepts/docker_eval.git
$ cd /c/Users/docker_eval
$ docker build --tag=caserta_evaluation .
$ docker-machine ip
$ docker run -p 8888:8888 caserta_evaluation 
```

*Windows 10 Pro, Enterprise or Education (Build 15063 or later) with 64bit:*
TBD

## Note: 

1. When opening the notebook, to get edit access, you may need to left-click the 'Not Trusted'(in the top-left corner) to turn into 'Trusted'
1. When finished with this test:

      2.1. 'ctrl-C' twice to shut down the Jupiter and stop the docker container

      2.2. Clean up docker images:
```buildoutcfg
$ docker image rm -f caserta_evaluation
```