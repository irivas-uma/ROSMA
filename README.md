# dVRK Dataset GUI - ROSMA Project
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

## Recording node

## GUI
Created with MATLAB APP Designer Toolbox (R2019b).

### Enter a new user

The *New User* option opens a new panel to enter the profile of a new user.  The data that will be stored is: alias, name, gender, age and skill level (Thechnician or surgeon).  When the user info is saved, the data is stored into the file *UsersInfo.mat*.  This file contains a table variable called UsersInfo, which contains the the following fieldsfor each user of the experiment:
* Id: numerical identifier for each user. 
* Name, Surname, Gender and Age.
* The last fields correspond with the labels of each task of the experiment.  These fields contains thenumber of repetitions the user has performed for each task.  Thus, these fields are initialize to zero andare updated each time a user performs a task.

![screenshots](https://github.com/irivas-uma/ROSMA/blob/master/Resources/newuser.png)

### Perform the experiment

When you select a particular user, first, the experiment history is displayed, showing the number of repetitions the user have performed for each task. Then, to start the experiment, you have to choose a task, and then press *Start* or press the coag pedal of the dVRK system. The time spent in the task is shown until the end of the experiment. The number of erros made by the user during the performance is entered by hand. The behavior of the buttons of this experiment panel is as follows:

#### 1. Start



