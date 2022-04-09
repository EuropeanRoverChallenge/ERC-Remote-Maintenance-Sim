# ERC-Remote-Maintenance-Sim

This repository contains simulations of the Universal Robots UR3 robot created for the ERC competition. You can use docker with all requirements installed  ([Using Docker](#using-docker) section) or try to install them natively ([Install on the host system](#install-on-the-host-system) section).

The simulation uses the [ROS-Industrial Universal Robot repository](https://github.com/ros-industrial/universal_robot) and [roboticsgroup_gazebo_plugins](https://github.com/roboticsgroup/roboticsgroup_gazebo_plugins). The following items have been added to the simulation: robot cell, table surface with marked areas, four button modules with ID 1 - 4 (in a pressed down state, not movable), inspection window along with its cover, the IMU module and gripper with camera. The files necessary for motion planning have also been modified to take into account the added elements. All changed and added files are located in the UR3_sim repository. You can run the simulation with an example cell or only with a robot, gripper and camera.

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
bash run_ur3_docker_AMD_Intel_Graphics.bash
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
sudo apt-get install git
rosdep init && rosdep update
sudo apt install ros-noetic-moveit -y
sudo apt install ros-noetic-ros-controllers* -y
mkdir -p /catkin_ws/src
cd /catkin_ws/src
git clone https://github.com/ros-industrial/universal_robot.git
sudo rm -r universal_robot/ur_msgs
git clone https://github.com/roboticsgroup/roboticsgroup_gazebo_plugins
git clone https://github.com/Michal-Bidzinski/UR3_sim.git
cd /catkin_ws
catkin_make
source devel/setup.bash
```
### Run simulation
To run UR3 simulation in Gazebo with MoveIt!, and RVzi GUI, including an example cell:
```
$ roslaunch ur3_sim simulation.launch 
```
To run UR3 simulation in Gazebo with MoveIt!, and RVzi GUI, containing only a robot with a grapple and a camera (as per real setup):
```
$ roslaunch ur3_sim real_station.launch 
```

### Control the robot
To control the arm can by used MoveIt!. Planning robot movement can be performed using for example the Move Group Interface. Tutorials written in [Python](https://github.com/ros-planning/moveit_tutorials/blob/master/doc/move_group_python_interface/scripts/move_group_python_interface_tutorial.py) and [C++](https://github.com/ros-planning/moveit_tutorials/blob/master/doc/move_group_interface/src/move_group_interface_tutorial.cpp) can be a hint (note the robot group name and number of joints).


### Control the gripper
The gripper is controlled by publishing appropriate commands on topic /gripper command. Message type: std msgs/String. To control the gripper, send the one of following commands:
- open
- semi_open (for catching the IMU box)
- semi_close (for catching the lid of the box)
- close

### Camera
The simulation includes a camera placed on a gripper that detects aruco tags and other items. 
The following topics are published:
- /camera\_image/camera\_info
- /camera\_image/image\_raw
- /camera\_image/image\_raw/compressed
- /camera\_image/image\_raw/compressed/parameter\_descriptions
- /camera\_image/image\_raw/compressed/parameter\_updates
- /camera\_image/image\_raw/compressedDepth
- /camera\_image/image\_raw/compressedDepth/parameter\_descriptions
- /camera\_image/image\_raw/compressedDepth/parameter\_updates
- /camera\_image/image\_raw/theora
- /camera\_image/image\_raw/theora/parameter\_descriptions
- /camera\_image/image\_raw/theora/parameter\_updates

Although the topics with the word Depth in the name are published by defalut ros node,
these cameras do not capture any depth data.
