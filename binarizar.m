function [ esquejeBin ] = binarizar( esqueje )
    a = esqueje;
     %---Con la siguiente funcion obtendremos en b, todas las diferentes capas de
     %los formatos para detectar co que capas trabajar.
     %---En c retornará la capa de interes a manipular
     [b,c]=componentes_color(a);
         %figure(1);imshow(b);impixelinfo
         %figure(2);imshow(c);impixelinfo
     %%Luego de obtener la imagen de interes, declaramos un umbral y lo
     %%realizamos
     c(c>140)=255;c(c<255)=0;
         %figure(3);imshow(c);
     %Definimos un elementio estructurante y con esto hacemos erode
     ee=strel('disk',6);
     d=imerode(c,ee);
         %figure(4);imshow(d);
     %Definimos un elemento estructurante mayor y luego realizamos dilate
     ee=strel('disk',12);
     d=imdilate(d,ee);
         %figure(5);imshow(d);
     %Luego de hacer erode y dilate veremos que nuestra imagen a cogido una
     %forma más solida
 
     %%---Con los 4 pasos siguientes podemos sacar el perimetro del lunar para
     %%saber cual es el limite
     d = bwareaopen(d,40000);
 
     %El paso anterior se puede omitir utilizando la funcion fill, esta nos
     %rellena todo el interior del lunar
     %d=imfill(d);
         %figure(6);imshow(d);impixelinfo
     d = bwareaopen(d,40000);
     esquejeBin = d; %retornamos imagen binarizada
     %Despues de esto, haremos un marco de la imagen inicial, como ya sabemos en
     %que parte se ubica el lunar, simplemente lo de afuera lo dejaremos en
     %negro y con esto tendremos un lunar.
 %para mostrar el esqueje recortado o con cuadro
%      d=[d,d,d];
%      [fil,col,cap]=size(a);
%      d=reshape(d,[fil,col,cap]);
%      a(d==0)=0;
%      esquejeBin = a;
     
end