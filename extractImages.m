%==========================================================================
%                           EXTRAÇÃO DE IMAGENS
%
%   This script is responsible for extract images from a scene using a pair
% of webcams. It's necessary to set the ID of each camera (defined by the 
% MatLab IDE). Returns the captured image pair (on grayscale) and a variable
% that is used to handle possible errors during this process.
%==========================================================================

function [lSnap, rSnap, error] = extractImages(LEFT_CAM, RGHT_CAM)

%   Initialize the pair of cameras.
try 
    lCam = videoinput('winvideo', LEFT_CAM);
    rCam = videoinput('winvideo', RGHT_CAM);
catch
    error = 1;
    return;
end

%   Captures the images using the cameras.
lSnap = getsnapshot(lCam);
rSnap = getsnapshot(rCam);

%   The error returns 0 (zero) if everything was fine or 1 (one) otherwise.
error = 0;

end