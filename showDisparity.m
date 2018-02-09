%==========================================================================
%                            SHOW DISPARITY
%
%   This script just shows the disparity map on the screen.
%==========================================================================

function showDisparity(dMap, dRng, label)

%	Cria uma nova figura.
figure;

%	Exibe o mapa de disparidades.
imshow(dMap, dRng);
colormap(jet);
colorbar;
title(label);

end