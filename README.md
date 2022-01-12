# Dynamics and Control of a Six-wheeled Rover with Rocker-Bogie Suspension

### Project Overview
Mobile robots are increasingly being used for applications in rough, outdoor terrain. These applications frequently necessitate robots traversing unprepared, rugged terrain in order to inspect a location or transport material; this is also true in the context of planetary exploration, where six-wheeled mobile rovers with rocker-bogie suspension systems impress in adaptability and obstacle climbing. These types of rovers are now used for Mars exploration.

<p align="center">
  <img src="./report%20and%20presentation/markdown_images/perseverance3D.png"/>
</p>

The six-wheeled mobile rover with a rocker-bogie suspension system impresses in adaptability and obstacle climbing. These types of rovers are now used for Mars exploration.

The rocker-bogie system is the suspension arrangement developed in 1988 for use in NASA's Mars rover Sojourner, and which has since become NASA's favored design for rovers. It has been used in the 2003 Mars Exploration Rover mission robots Spirit and Opportunity, on the 2012 Mars Science Laboratory (MSL) mission's rover Curiosity, and the Mars 2020 rover Perseverance.

#### Assumptions
Several assumptions can be made to simplify the rover analysis. 
* due to space system constraints such as weight and power, rovers must travel at low speeds (approximately 3cm/s), resulting in very small dynamic effects;
* rover includes sensors such as stereo cameras and Lidar that can generate a detailed description of the environment around the robot; thus, ground characteristics are consideredas input to the simulation.
* because the vehicle speed is so slow, the wheels will not bounce. As a result, the model assumes that all six wheels are always in contact with the ground.

Please refer to the [__report__](./report%20and%20presentation/report.pdf) for a detailed analysis on the kinematics, dynamics, control and simulations.

<p align="center">
  <img src="./videos/rover_simulation.gif"/>
</p>

#### Repository structure
```
.
├── main.m
├── mars surface
│   ├── ESP_059329_2095_RGB.jpg
│   ├── ESP_068360_1985.jpg
│   ├── mars_surface.jpg
│   └── volcans-mars-hirise.jpg
├── preloaded data
│   ├── standardTerrainProfile.mat
│   ├── standardTerrainProfile_workspace.mat
│   └── terrainProfile.mat
├── README.md
├── report and presentation
│   ├── markdown_images
│   │   ├── control_scheme.png
│   │   ├── dyn.png
│   │   ├── kin.png
│   │   ├── perseverance3D.png
│   │   ├── simulink_scheme.png
│   │   └── terrain_image_processing.png
│   ├── presentation.pdf
│   └── report.pdf
├── roverDynamics.slx
├── utilities
│   ├── checkFeasability.m
│   ├── computeBogie.m
│   ├── computeRocker.m
│   ├── contactPointsFromTerrain.m
│   ├── contactPointsFromWheel.m
│   ├── initParams4Simulink.m
│   ├── meshCreation.m
│   ├── plot
│   │   ├── createVideo.m
│   │   ├── draw_axis.m
│   │   ├── draw_joint.m
│   │   ├── draw_link.m
│   │   ├── drawRover.m
│   │   ├── figureFullScreen.m
│   │   ├── plotCircle.m
│   │   ├── Plots.m
│   │   └── plotVectorArrow.m
│   ├── slipRatio.m
│   ├── tools
│   │   ├── checkIncidence.m
│   │   ├── deleteDuplicates.m
│   │   ├── deleteNaN.m
│   │   ├── firstsecondderivatives.m
│   │   ├── interparc.m
│   │   ├── intersections.m
│   │   ├── linearRegression.m
│   │   ├── minDistance.m
│   │   ├── movingAverageFilter.m
│   │   ├── tan2circle.m
│   │   └── toWorkspace.m
│   ├── variablesFromSimulink.m
│   ├── wheel1Position.m
│   ├── wheel2Position.m
│   ├── wheel3Position.m
│   └── wheelPositionScript.m
└── videos
    ├── rover_simulation.gif
    └── rover_simulation.mp4
```

