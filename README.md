# Uncalibrated Stereo Vision System in MATLAB

This project shows a basic model of how to create a disparity map from a real scene, using a camera pair, without previous calibration. 

## Introduction

A **disparity map** is a graphic representation of the depth of elements inside a scene. The disparity maps are largely utilized in stereo vision area, which tries to computationally reproduces human vision aspects. Basically, the disparity map generation contains up to 3 (three) steps:

 - The **calibration**, which analyzes the characteristics of the cameras of the stereo vision system, finding relevant parameters for disparity map generation;
 - The **rectification**, which uses the obtained parameters of the earlier step as a reference for the capture process (and later adjust) of the images from a scene;
 - The **correspondence**, which uses the result images from the rectification process to generate the disparity map.

Though there are 3 (three) basic steps, the first one demands time, which may blocks the use of the stereo vision systems in real environments. Because of this, the are a lot of studies about modeling the stereo vision system without the calibration step [[1](https://www.researchgate.net/publication/220692096_Introductory_techniques_for_3-D_computer_vision)]. One way to do this is to calculate one of the key elements of the calibration step (known as **fundamental matrix**[[2](https://www.cambridge.org/core/books/multiple-view-geometry-in-computer-vision/0B6F289C78B2B23F596CAA76D3D43F7A)]) using only the geometry of the analyzed scene. That's what this project does. 

## Utilized Material

- [**MATLAB R2017b**](https://www.mathworks.com/products/matlab.html) or later, x64 version.
- A **3D camera**, or a **pair of cameras** to simulate the stereo vision system. Personally, I use the [Minoru3D](http://www.minoru3d.com/).

## How to Setup MATLAB

1. Open the MATLAB;

2. Type the command `supportPackageInstaller` on MATLAB's command line and press _Enter_;

3. Once the _Package Installer Manager_ is open, install these two libraries:

	- `USB Webcam`, which allows the MATLAB to recognize USB cameras;
	- `OS Generic Video Interface`, which allows the MATLAB to capture images using the USB cameras.
	
4. Setup the MATLAB path to the folder that contains this project;

5. Now the hardest part. You must find the `ID` of each camera that'll be used in the project. If you have only 2 (two) cameras in your computer, probably the `ID`'s will be 1 (one) for the left camera, and 2 (two) for the right camera. If you have 3 (three) or more cameras connected in your computer, I recommend type `webcamlist` on MATLAB's command line, press _Enter_, and see the result (the cameras will appear based on the `ID` order). 

6. Once discovered the `ID` of each camera, change the values of `LEFT_CAM`/`RGHT_CAM` in the file _main.m_ with the `ID` of each one;

7. Por fim, você pode executar o script `main.m` no MATLAB.

## Additional Info

You may need a MATLAB account (don't worry, it's free) to download and install the necessary packages for the step 3 (three).

## License

The available source codes here are under the MIT License, version 3.0 (see the attached `LICENSE` file for more details). Any questions can be submitted to my email: carloswdecarvalho@outlook.com.