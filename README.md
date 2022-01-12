# Dynamics and Control of a Six-wheeled Rover with Rocker-Bogie Suspension

### Project Overview
<p align="center">
  <img src="report%and%presentation/markdown_images/perseverance3D.png"/>
</p>

Further details can be found in the detailed [report](./report%and%presentation/report.pdf)

### Repository structure
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


