%==========================================================================
%                      CÁLCULO DO MAPA DE DISPARIDADES
%
%   Script responsável pela geração de um mapa de disparidades utilizando o
% método SemiGlobal, a partir de um par de imagens retificadas. Retorna o 
% mapa de disparidades produzido, bem como a faixa de valores utilizada na 
% escala de tons de cinza. Referência:
%
% HIRSCHMULLER, H., 2005. Accurate and Efficient Stereo Processing by Semi-
% Global Matching and Mutual Information. Proc. of Int. Conference on Com-
% puter Vision and Pattern Recognition, 2, 807-814.
%==========================================================================

function [dispMap, dispRng] = disparityMap(lSnap, rSnap)

%   Configura os possíveis valor de tons de cinza possíveis. O intervalo 
% precisa estar na base oito.
dispRng = [-6 10];

%   Aplica a função de disparidade utilizando a faixa de tons desejados.
dispMap = disparity(lSnap, rSnap, 'DisparityRange', dispRng);

end