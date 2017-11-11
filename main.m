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

% =========================== PRE-PROCESSAMENTO ===========================

tic;

%   Realiza um pré-processamento (conversão para cinza).
[lSnap, rSnap] = preProcessing(lSnap, rSnap);

% ===================== GERAÇÃO DO MAPA DE DISPARIDADES ===================
while GENERATE == 1

    %   Controla o processo. Se o mapa de disparidades for gerado incorre-
    % tamente, seu valor volta pra 1, e a geração do mapa é refeita.
    GENERATE = 0;   

    %   Extrai os pontos correspondentes, usando SURF e a Soma das Diferen-
    % ças Quadradas. 
    [lPts, rPts] = extractMatchedFeatures(lSnap, rSnap);
    
    %   Estima a matriz fundamental com LMedS ou MSAC, dependendo do caso.
    [lPts, rPts, F, error] = fundamentalMatrix(lPts, rPts);

    %   Verifica se a matriz foi gerada com sucesso. Dois casos são verifi-
    % cados aqui: se o número de correspondências foi suficiente (maior que
    % sete) ou se a distorção produzida pela matriz é alta demais pra gerar
    % um mapa. No primeiro caso, é necessária recaptura de imagens; no se-
    % gundo, basta recalcular-se a matriz. 
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
    
    %   Realiza a retificação usando a matriz fundamental.
    [lRect, rRect, tL, tR] = rectifyImages(lPts, rPts, F, lSnap, rSnap);

    %   Cria o mapa de disparidades.
    [dMap, dRng] = disparityMap(lRect, rRect);

    %   Corrige a distorção no mapa, causada pela retificação.
    dMap = fixWrap(dMap, tL, tR);

    %   Remove partes do mapa que devem ser desconsideradas.
    dMap = removeGaps(dMap);

    %   Verifica se o mapa obtido obedece à porcentagem máxima de pixels
    % nulos (sem disparidade). Em caso positivo, outra matriz deve ser ob-
    % tida, e o processo precisa ser refeito. Em caso negativo, o mapa ini-
    % cial está pronto (e pode passar por processos de melhora).
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