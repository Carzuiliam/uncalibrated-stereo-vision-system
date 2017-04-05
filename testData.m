%==========================================================================
%                CARREGA IMAGENS PREVIAMENTE CAPTURADAS
%
%   Script responsável por carregar um par de imagens estéreo que foi pre-
% viamente capturado. Utilizado, em geral, quando não há câmeras ligadas ao
% ambiente.
%==========================================================================

function [lSnap, rSnap, error] = testData

%	Lê os arquivos de imagem de um diretório.
try 
    lSnap = imread('images/Plants/im0.png', 'png');
    rSnap = imread('images/Plants/im1.png', 'png');
catch
    error = 1;
    return;
end

%   Variável utilizada no controle de erros da função; retorna 0 se tudo 
% correr bem.
error = 0;

end