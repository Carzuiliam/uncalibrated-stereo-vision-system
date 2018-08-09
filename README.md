This is a project on MATLAB that objective is to create a disparity map from a real scene, captured by a pair of cameras, without any previous calibration. The disparity map is a map which shows the deep of elements presents in a scene. 

---------------------------------------------------------------------------------------------------------------------------------

Utilized materials:

- MATLAB R2014b or later, x64 version: https://www.mathworks.com/products/matlab.html
- Minoru 3D Webcam (optional): http://www.minoru3d.com/

Configuring the MATLAB:

1) Open MATLAB (duh);

2) Type the command supportPackageInstaller on MATLAB console and press Enter;

3) Once the Package Installer Manager is open, find these two libraries to install:
	- USB Webcam;
	- OS Generic Video Interface;

4) Set the MATLAB path to the folder that contains the project (probably the folder with this file);

5) If you want to use webcams, find the ID (is a number, generally 1 and 2 to left and right cams) of each webcam, change the values of LEFT_CAM/RGHT_CAM with the ID of each one and change the value of USE_WCAM to 1, on the main.m file. If you don't want to use webcams, open the testData.m file and make sure the path of the image pair is correct (usually images/<Folder>/<Image>.png);

6) Enjoy!

You will probably need a MATLAB account to download and install these packages (it's free to create). All the images inside the "Test" folder was obtained from the Middlebury database (http://vision.middlebury.edu/stereo/eval3/). 

Any questions can be submitted to the following email: carloswdecarvalho@outlook.com.

---------------------------------------------------------------------------------------------------------------------------------
