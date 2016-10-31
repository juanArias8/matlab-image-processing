function [ talloBin , esquejeBin ] = binarizar( esqueje )
%--------------------------------------------------------------------------
%-- 1. Inicio de la función recortaTallo ----------------------------------
%--------------------------------------------------------------------------  
a = esqueje;%llevamos la imagen a la variable a
%--------------------------------------------------------------------------
%-- 2. Capas de la imagen -------------------------------------------------
%--------------------------------------------------------------------------
[b,c]=componentes_color(a);%c contiene la capa con la que procesaremos el esqueje
figure(1);imshow(b);impixelinfo%mostramos las diferentes capas retornadas
title('Las diferentes capas en escala de grises');
figure(2);imshow(c);impixelinfo%mostramos la capa que seleccionamos para procesar el esqueje
title('Capa con la que trabajaremos');
%%Luego de obtener la imagen de interes, declaramos un umbral y lo
cAnterior = c;%guardamos la imagen anterior para que esta no se nos pierda
%--------------------------------------------------------------------------
%-- 3. Binarización de la imagen ------------------------------------------
%--------------------------------------------------------------------------
c(c>140)=255;c(c<255)=0;%definimos el umbral en el cual se encuentra el esqueje
%--------------------------------------------------------------------------
%-- 4. eliminación de figuras no correspondiente al esqueje ---------------
%--------------------------------------------------------------------------
c = eliminaCeldasB(c,cAnterior);%llamos al metodo que no eliminara dichas figuras
%--------------------------------------------------------------------------
%-- 5. volvemos a realizar la binarización de la imagen -------------------
%--------------------------------------------------------------------------
c(c>140)=255;c(c<255)=0;%binarizamos dependiendo del umbral 140
figure(3);imshow(c);%mostramos el esqueje binarizado
title('Imagen binarizada');
%--------------------------------------------------------------------------
%-- 6. realizamos la erosion del esqueje ---------------------------------
%--------------------------------------------------------------------------
ee=strel('disk',6);%Definimos un elemento estructurante
d=imerode(c,ee);%realizamos la erosion de la imagen
figure(4);imshow(d);%mostramos como queda la imagen
title('Imagen erosionada');
%--------------------------------------------------------------------------
%-- 6. realizamos la dilatación del esqueje -------------------------------
%--------------------------------------------------------------------------
ee=strel('disk',8);%Definimos un elemento estructurante mayor 
d=imdilate(d,ee);%realizamos la dilatación de la imagen
figure(5);imshow(d);%Luego de hacer erode y dilate veremos que nuestra imagen a cogido una
%forma más solida
title('Imagen dilatada');
d = bwareaopen(d,40000);%eliminamos objetos que no pertenezcan al esqueje
esquejeBin = d; %retornamos imagen binarizada
%--------------------------------------------------------------------------
%-- 7. Imagen original recortada ------------------------------------------
%--------------------------------------------------------------------------
d=[d,d,d];%unimos todas la capas de la imagen
[fil,col,cap]=size(a);%obtenemos el tamaño de la imagen
d=reshape(d,[fil,col,cap]);
a(d==0)=0;%todo lo que esta en negro en la imagen binarizada pongalo negro en la imagen original
talloBin = a;%devolvemos la imagen con un cuadro
end