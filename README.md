# dVRK Dataset GUI Manual - ROSMA Project
Open software developed under the European TERRINet program.

*Author:* Irene Rivas-Blanco

*Contact info:* irivas@uma.es

*Affiliation:* University of Malaga, [Medical Robotics Lab](https://www.uma.es/medical-robotics/cms/base/ver/base/basecontent/75284/proyectos/)

## Overview
This package contains a MATLAB GUI that collects data of the dVRK and a ros node that bridges between the dVRK node and the GUI. 

## Prerequisites
* ROS - Tested with KDainetic and Melodic.
* MATLAB - Tested with R2019b.
* da Vinci Research Kit (dVRK) - Tested with the dVRK in The BioRobotics Institute, Scuola Superiore Sant'Anna, Pontedera, Italy.

![screenshots](https://github.com/irivas-uma/ROSMA/blob/master/Resources/dvrk.png)


## To build

## To launch
To launch the ROS node (assuming the package is in folder *catkin_ws* in the home directory:
```bash
cd catkin_ws/
source devel/setup.bash
rosrun rosma_dataset rosma_dataset
```
