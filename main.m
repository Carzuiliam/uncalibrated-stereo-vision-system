%==========================================================================
%                             SCRIPT PRINCIPAL
% 
%   Este é o scrpit principal do projeto. É necessário um par de câmeras ou
% um par de imagens previamente capturadas para o funcionamento do mesmo.
%==========================================================================

function main

% ============================== CONSTANTES ===============================

%   Variável utilizada para o tipo de entrada: câmera (1) ou arquivo (0).
USE_WCAM = 0;

%   O ID de cada câmera, necessário caso a captura tenha de ser feita du-
% rante a execução do código.
LEFT_CAM = 3;
RGHT_CAM = 1;

%   Porcentagem máxima de pixels nulos em um mapa. Quanto menor tal valor,
% melhor o mapa -- mas tal procedimento pode incrementar o tempo de proces-
% samento de um mapa.
MAX_BLNK = 5.0;

%   Variável utilizada no controle do processo de geração do mapa de dispa-
% ridades.
GENERATE =  1;

% ======================= CARREGANDO IMAGENS ==============================

%   Verifica o tipo de entrada das imagens.
switch USE_WCAM
    case 1
        %   Webcam: captura imagens via webcam.
        [lSnap, rSnap, error] = extractImages(LEFT_CAM, RGHT_CAM);
    otherwise
        %   Arquivo: carrega imagens via diretório.
        [lSnap, rSnap, error] = testData;        
end

%   Verifica se houveram erros no carregamento das imagens.
if error == 1
    disp('Can`t find the webcams. Check it!');
    return;
end

% =========================== PRE-PROCESSAMENTO z===========================

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
        %disp(getFitness(dMap));
    end
    
end

end