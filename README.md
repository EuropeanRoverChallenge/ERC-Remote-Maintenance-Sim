# ERC-Remote-Maintenance-Sim

This repository contains simulations of the Universal Robots UR3 robot created for the ERC competition. You can use docker with all requirements installed  ([Using Docker](#using-docker) section) or try to install them natively ([Install on the host system](#install-on-the-host-system) section).

The simulation uses the [ROS-Industrial Universal Robot repository](https://github.com/ros-industrial/universal_robot). A table has been added to an existing simulation. The UR3_Simulation repository contains a modified urdf, srdf and roslaunch files that take the table into account when planning the movement.

## Using Docker

---
**NOTE**

The commands in this section should be executed as the `root` user, unless you have configured docker to be [managable as a non-root user](https://docs.docker.com/engine/install/linux-postinstall/).

---

Make sure the [Docker Engine](https://docs.docker.com/engine/install/#server) is installed and the `docker` service is running:
```
systemctl start docker
```
Build the docker image by executing:
```
./build_erc.sh 
```
Create container:
If you are running the system with no dedicated GPU (not recommended, Gazebo may not run or work slowly without the GPU), execute:
```
bash run_ur3_docker.bash
```
To use an integrated AMD/Intel Graphics card, run:
```
bash run_ur3_docker_AMD_Intel_GRaphics.bash
```
To use an Nvidia card, you need to previously install proprietary drivers and Nvidia Container Toolkit (https://github.com/NVIDIA/nvidia-docker). Next execute command:
``` 
bash run_ur3_docker_Nvidia.bash
```
Then, you can start container:
```
docker start ur3_simulation_erc
```
Then, you can run command in running container:
```
docker exec -it ur3_simulation_erc /bin/bash
```

Now you can run commands below in docker container.

UR3 simulation in Gazebo with MoveIt! and RViz GUI:
Simulation in Gazebo:
```
roslaunch ur3_sim simulation.launch 
```
## Install on the host system

### Requirements

The simulation is mainly developed and tested on [Ubuntu 20.04 Focal Fossa](https://releases.ubuntu.com/20.04/) with [ROS Noetic Ninjemys](http://wiki.ros.org/noetic/Installation/Ubuntu), so it is a recommended setup. 

For the simulation to work properly, you must install dependencies and download repository by running the following commands: 
``` 
source /opt/ros/noetic/setup.bash
sudo apt-get update && apt-get upgrade -y && apt-get install -y lsb-core g++
rosdep init && rosdep update
sudo apt install ros-noetic-moveit -y
sudo apt install ros-noetic-ros-controllers* -y
mkdir -p /catkin_ws/src
cd /catkin_ws/src && git clone https://github.com/PUT-UGV-Team/UR3_Simulation.git
git clone https://github.com/ros-industrial/universal_robot.git
cd /catkin_ws
catkin_make
source /catkin_ws/devel/setup.bash
```
### Run simulation
UR3 simulation in Gazebo with MoveIt! and RViz GUI:
Simulation in Gazebo:
```
$ roslaunch ur3_sim simulation.launch 
```
