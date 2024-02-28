
------------------------------------------------
Robotic Surgical Maneuver Dataset
================================================

<b>ROSMA</b> is a surgical robotics dataset of three common training surgical tasks collected from the Da Vinci Research Kit (dVRK). ROSMA contains data from 207 trials of three maneuvers performed by 12 users. Data includes 160 kinematic variables recorded at 50 Hz along with video recordings collected at 15 frames per second with 1024 x 768 pixel resolution. A vdideo demonstration of the dataset recording process can be found [here](https://www.youtube.com/watch?v=gEtWMc5EkiA).  

<details>
  <summary>  
  <b>Expand to view ROSMA dataset directory structure: </b>
  </summary>
  
 ```
    ──ROSMA
        ├───videos
        │   ├───X01_task_trial.mp4  
        │   ├───
        │   └───X12_task_trial.mp4
        |
        ├───kinematics
        │   ├───X01_task_trial.txt 
        │   ├───
        │   └───X12_task_trial.txt  
        |
        ├───scores.txt   
        ├───synchronizationData.txt    
        ├───userQuestionnaire.txt

   ```
</details>

<br>

<div align="right">
<a href="https://zenodo.org/records/3932964">
<img src="https://img.shields.io/badge/Download ROSMA dataset-8A2BE2?style=for-the-badge">
</a>
</div>
<br>


<b>ROSMAT24</b> is a subset of ROSMA dataset that includes annotations for surgical tools detection on 24 videos.

<details>
  <summary>  
  <b>Expand to view ROSMA dataset directory structure: </b>
  </summary>
  
 ```
    ──ROSMAT24
        ├───labels
        │   ├───X01_task_trial.txt  
        │   ├───
        │   └───
        |
        ├───videos
        │   ├───X01_task_trial.mp4 
        │   ├───
        │   └───

   ```
</details>


<br>

<div align="right">
<a href="https://zenodo.org/records/10719714">
<img src="https://img.shields.io/badge/Download ROSMAT24 dataset-8A2BE2?style=for-the-badge">
</a>
</div>
<br>


<b>ROSMATG40</b> is a subset of ROSMA dataset that includes annotations for instruments basic actions on 40 tasks. 

<details>
  <summary>  
  <b>Expand to view ROSMAG40 dataset directory structure: </b>
  </summary>
  
 ```
    ──ROSMAT24
        ├───FGDlabels
        │   ├───X01_task_trial.txt  
        │   ├───
        │   └───
        |
        ├───MDlabels
        │   ├───X01_task_trial.txt  
        │   ├───
        │   └───
        |
        ├───kinematics
        │   ├───X01_task_trial.txt  
        │   ├───
        │   └───
        |
        ├───video
        │   ├───X01_task_trial.mp4 
        │   ├───
        │   └───

   ```
</details>

<br>

<div align="right">
<a href="https://zenodo.org/records/10719748">
<img src="https://img.shields.io/badge/Download ROSMAG40 dataset-8A2BE2?style=for-the-badge">
</a>
</div>
<br>


## <u>Research Papers</u>
 
Rivas-Blanco, I.; Del-Pulgar, C.J.; Mariani, A.; Tortora, G.; Reina, A.J. A surgical dataset from the da Vinci Research Kit for task automation and recognition. International Conference on Electrical, Computer, Communications and Mechatronics Engineering, ICECCME 2023. https://doi.org/10.1109/ICECCME57830.2023.10253032.
