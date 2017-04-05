%==========================================================================
%                           EXTRAÇÃO DE IMAGENS
%
%   Script responsável por extrair as imagens de uma cena utilizando um par
% de webcams. É necessário informar o identificador de cada câmera (defini-
% do pelo ambiente do MatLab). Tem como retorno o par de imagens capturado
% (em tons de cinza), bem como uma variável utilizada para tratar possíveis
% erros de captura.
%==========================================================================

function [lSnap, rSnap, error] = extractImages(LEFT_CAM, RGHT_CAM)

%   Inicializa o par de câmeras.
try 
    lCam = videoinput('winvideo', LEFT_CAM);
    rCam = videoinput('winvideo', RGHT_CAM);
catch
    error = 1;
    return;
end

%   Captura as imagens utilizando as câmeras inicializadas.
lSnap = getsnapshot(lCam);
rSnap = getsnapshot(rCam);

%   Variável utilizada no controle de erros da função; retorna 0 se tudo 
% correr bem.
error = 0;

end