%==========================================================================
%                           PRÉ-PROCESSAMENTO
%
%   Scriptresponsável pelo pré-processamento (por hora, apenas a conversão
% para tonz de cinza) das imagens do sistema de visão estéreo. As imagens 
% de retorno são as mesmas imagens de entrada, mas pré-processadas. Possi-
% velmente coisas podem ser adicionadas aqui...
%==========================================================================

function [lSnap, rSnap] = preProcessing(lSnap, rSnap)

%	Conversão para tons de cinza.
lSnap = rgb2gray(lSnap);
rSnap = rgb2gray(rSnap);

end