%==========================================================================
%                   EXTRAÇÃO DE CORRESPONDÊNCIAS INICIAIS
%
%   Script responsável pela extração de cantos correspondentes. Recebe duas
% imagens como parâmetros, e retorna dois vetores contendo as coordenadas
% dos pontos correspondentes para cada imagem.
%==========================================================================

function [lPts, rPts] = extractMatchedFeatures(lSnap, rSnap)

%   Detecta os cantos de cada imagem utilizando o algoritmo SURF. Tal algo-
% ritmo é o que obteve os melhores resultados na análise de correspondênci-
% as.
surfL = detectSURFFeatures(lSnap);
surfR = detectSURFFeatures(rSnap);

%   Calcula as correspondências entre os cantos de cada imagem, utilizando
% a soma das diferenças quadradas (SSD).
[ftrsL, vldPtsL] = extractFeatures(lSnap, surfL);
[ftrsR, vldPtsR] = extractFeatures(rSnap, surfR);

index = matchFeatures(ftrsL, ftrsR, 'Unique', true);

lPts = vldPtsL(index(:,1),:);
rPts = vldPtsR(index(:,2),:);

end