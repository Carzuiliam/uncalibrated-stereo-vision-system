Este é um projeto em MATLAB cujo objetivo é criar um mapa de disparidades a partir de uma cena real, capturada por um par de câmeras, sem qualquer tipo de calibração prévia. O mapa de disparidades é um mapa que exibe a profundidade dos elementos presentes em uma cena. 

---------------------------------------------------------------------------------------------------------------------------------

Materiais utilizados:

-- MATLAB R2014b, versão x64: https://www.mathworks.com/products/matlab.html
-- Minoru 3D Webcam (opcional): http://www.minoru3d.com/

Como confirgurar o MATLAB:

1) Abra o MATLAB (duh);
2) Digite o comando supportPackageInstaller no console do MATLAB e pressione Enter;
3) Uma vez que o Package Installer Manager esteja aberto, marque estas duas bibliotecas para serem instaladas:
        - USB Webcam;
        - OS Generic Video Interface;
4) Configure o caminho do MATLAB para a pasta que contém o projeto baixado (provavelmente a pasta deste arquivo);
5.a) Se você deseja utilizar webcams, encontre o ID (é um número, geralmente 1 e 2 para as câmeras esquerda e direita) de cada webcam, mude os valores de LEFT_CAM/RGHT_CAM com os ID's de cada uma e mude o valore de USE_WCAM para 1, no arquivo main.m;
5.b) Se você NÃO deseja utilizar webcams, abra o arquivo testData.m e certifique-se que o caminho que contém o par de imagens estéreo esteja correto (geralmente images/<Folder>/<Image>.png);
6) Divirta-se!

Você provavelmente precisará de uma conta no MATLAB para baixar e instalar os pacotes neessários (é de graça). E todas as imagens da pasta "Test" foram obtidas da base de dados de Middlebury (http://vision.middlebury.edu/stereo/eval3/). 

Dúvidas podem ser resolvidas por meio do meu e-mail: carloswdecarvalho@outlook.com.

---------------------------------------------------------------------------------------------------------------------------------
