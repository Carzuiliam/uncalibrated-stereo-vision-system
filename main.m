%==========================================================================
%                             MAIN SCRIPT
% 
%   This is the mains script of the project. It is necessary a webcam pair 
% or a stereo image pair previously captured to make this script works.
%==========================================================================

function main

% =========================== STATIC VARIABLES ============================

%   Used to set the input type: a pair of cameras (1) or a file path (0).
USE_WCAM = 0;

%   Used to configure the utilized database: Middlebury or Tsukuba.
%DATABASE = 'Tsukuba';
DATABASE = 'Middlebury';

%   The ID of each camera, needed if the images will be captured by the 
% script.
LEFT_CAM = 3;
RGHT_CAM = 1;

%   Maximum percentage of blank pixels inside the map. The lower this value,
% the better the map -- but lower values can increase the number of retries
% to generate a acceptable disparity map, slowing the process.
MAX_BLNK = 5.0;

%   Used to control the process of the disparity map generation.
GENERATE = 1;

% =========================== LOADING IMAGES ==============================

%   Check the input type.
switch USE_WCAM
    case 1
        %   Webcam: capture the images using the webcams.
        [lSnap, rSnap, error] = extractImages(LEFT_CAM, RGHT_CAM);
    otherwise
        %   File: load images from a directory (Tsukuba or Middlebury).
        [lSnap, rSnap, error] = testData(DATABASE);        
end

%   Verify if there are any errors while loading the images.
if error == 1
    disp('Can`t find the webcams. Check it!');
    return;
end

% ============================ PRE-PROCESSING =============================

%   Do a pre-processing step (basically a grayscale conversion).
[lSnap, rSnap] = preProcessing(lSnap, rSnap);

% ======================== DISPARITY MAP GENERATION =======================
while GENERATE == 1

    %   Controls the process. If the generated disparity map is incorrect, 
    % restarts the process.
    GENERATE = 0;   

    %   Extract the matched features using the SURF algorithm and the Sum 
    % of Squared Differences. 
    [lPts, rPts] = extractMatchedFeatures(lSnap, rSnap);
    
    %   Estimates the fundamental matrix using LMedS ou MSAC, depending on 
    % the case.
    [lPts, rPts, F, error] = fundamentalMatrix(lPts, rPts);

    %   Verifies if the fundamental matrix was successfully generated. Two
    % cases are verified here: if the number of matches was enough (more
    % than seven) or if the fundamental matrix may produce distortions. 
    % In the first case, it's necessary to recapture the images; on second 
    % case, it's just necessary to recalculate the fundamental matrix. 
    if error == 1
        disp('Low matched features.  Recapture!');
        return;
    end

    if isEpipoleInImage(F , size(lSnap)) == true || ...
       isEpipoleInImage(F', size(rSnap)) == true
        disp('Found epipolar lines. Retrying...');
        GENERATE = 1;
        continue;    
    end
    
    %   Realizes the rectification step using the fundamental matrix.
    [lRect, rRect, tL, tR] = rectifyImages(lPts, rPts, F, lSnap, rSnap);

    %   Creates the disparity map.
    [dMap, dRng] = disparityMap(lRect, rRect);

    %   Fix the map distortion, caused by the rectification step.
    dMap = fixWrap(dMap, tL, tR);

    %   Removes some parts of the disparity map that can be inconsiderate.
    dMap = removeGaps(dMap);

    %   Verifies if the obtained disparity map obey the max number of bad 
    % pixels (with null disparity). In positive case, another matrix needs 
    % to be obtained and the process must be redone. Otherwise, the initial 
    % disparity map is ready (and can be optimized).
    if getFitness(dMap) > MAX_BLNK
        disp('Too much distortions. Retrying...');
        GENERATE = 1;
        continue; 
    else
        showImage(lSnap);
        showDisparity(dMap, dRng, 'Final Disparity Map');
        disp(getFitness(dMap));
    end
    
end

end