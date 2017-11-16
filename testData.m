%==========================================================================
%                CARREGA IMAGENS PREVIAMENTE CAPTURADAS
%
%   Script responsável por carregar um par de imagens estéreo que foi pre-
% viamente capturado. Utilizado, em geral, quando não há câmeras ligadas ao
% ambiente.
%==========================================================================

function [lSnap, rSnap, error] = testData(database)

%	Lê os arquivos de imagem de um diretório.
if strcmp(database, 'Tsukuba') == true
    pathL = 'images/Tsukuba/left/frame_1.png';
    pathR = 'images/Tsukuba/right/frame_1.png';
else
    if strcmp(database, 'Middlebury') == true
        pathL = 'images/Middlebury/Bicycle2/im0.png';
        pathR = 'images/Middlebury/Bicycle2/im1.png';
    else
        error = 1;
        return;
    end
end

%	Lê os arquivos de imagem de um diretório.
try 
    lSnap = imread(pathL, 'png');
    rSnap = imread(pathR, 'png');
catch
    error = 1;
    return;
end

%   Variável utilizada no controle de erros da função; retorna 0 se tudo 
% correr bem.
error = 0;

end