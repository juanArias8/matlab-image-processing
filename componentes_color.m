function [b,c]=componentes_color(a)
%--------------------------------------------------------------------------
%-- 1. Inicio de la función componentes_color -----------------------------
%-------------------------------------------------------------------------- 
[fil,col,cap]=size(a);%se obtienes la longitud de la imagen
if cap ==1
    b=a;c=a;
    return
end
%--------------------------------------------------------------------------
%-- 2. Componentes rgb ----------------------------------------------------
%-------------------------------------------------------------------------- 
enRGB=a;%llevamos la imagen original a a1
enRGB=normaliza(enRGB);%nomrlizamos la imagen de tal forma que los pixeles queden de 1 a 255
enRGB=w2linea(enRGB);%linealizamos la imagen
%--------------------------------------------------------------------------
%-- 3. Componentes hsv ----------------------------------------------------
%--------------------------------------------------------------------------
enHSV=rgb2hsv(a);%pasamos nuestra imagen a la componente hsv
enHSV=normaliza(enHSV);%nomalizamos la imagen de tal forma que los pixeles queden de 1 a 255
enHSV=w2linea(enHSV);%linealizamos la imagen
%--------------------------------------------------------------------------
%-- 4. Componente lab -----------------------------------------------------
%--------------------------------------------------------------------------
cform=makecform('srgb2lab');%ahora debemos utilizar un makecform para pasar nuestra imagen a lab
enLAB=applycform(a,cform);%aplicamos la forma creada anteiormente a nuestra imagen 
lab=enLAB;%guardamos la componente en lab
enLAB=normaliza(enLAB);%nomalizamos la imagen de tal forma que los pixeles queden de 1 a 255
enLAB=w2linea(enLAB);%linealizamos la imagen
%--------------------------------------------------------------------------
%-- 4. Componente cmyk ----------------------------------------------------
%--------------------------------------------------------------------------
cform=makecform('srgb2cmyk');%ahora debemos utilizar un makecform para pasar nuestra imagen a cmk
enCMYK=applycform(a,cform);%aplicamos la forma creada anteiormente a nuestra imagen quede en cmyk
enCMYK=normaliza(enCMYK);%nomalizamos la imagen de tal forma que los pixeles queden de 1 a 255
capaSelecionada=enCMYK(:,:,3);%Obtenemos la capa que seleccionamos para procesarla
enCMYK=enCMYK(:,:,1:3);%solo tomamos las 3 primera capas
enCMYK=w2linea(enCMYK);%linealizamos la imagen
%--------------------------------------------------------------------------
%-- 5. Componente lch para esta necesito lab-------------------------------
%--------------------------------------------------------------------------
cform=makecform('lab2lch');%para poder obtener la componentes en lch tenemos que tener las componentes en lab
enLCH=applycform(lab,cform);%pasamos nuestra imagen de la componente lab a la componente lch
enLCH=normaliza(enLCH);%nomalizamos la imagen de tal forma que los pixeles queden de 1 a 255
enLCH=w2linea(enLCH);%linealizamos la imagen
%--------------------------------------------------------------------------
%-- 6. juntamos todas las capas en una misma imagen------------------------
%--------------------------------------------------------------------------
capaSelecionada=normaliza(capaSelecionada);%normalizamos la capa que cogimos para el procesamiento
c=capaSelecionada;%le asignamos al valor que se va devolver la imagen seleccionada
b=[enRGB;enHSV;enLAB;enCMYK;enLCH];%le asignamos al valor que se va devolver las componentes
end