function [aux2] = eliminaCeldasB( imagenBin,capa )
%--------------------------------------------------------------------------
%-- 1. Inicio de la función recortaTallo ----------------------------------
%--------------------------------------------------------------------------  
[fil,col] = size(imagenBin);%obtenemos la longitud de la imagen
%--------------------------------------------------------------------------
%-- 2. dilatamos la imagen para unir los puntos cercanos ------------------
%--------------------------------------------------------------------------  
ee=strel('disk',10);%creamos la figura morfologica que es un disco
aux=imdilate(imagenBin,ee);%dilatamos la imagen teniendo en cuenta la figura anterior
aux2=capa;%guardamos en una variable auxiliar la imagen original
sumaPosi =0;%iniciamos la variable que nos contara la cantidad de pixeles blancos que tiene la imagen
%--------------------------------------------------------------------------
%-- 3. realizamos el borrado de las celdas --------------------------------
%--------------------------------------------------------------------------  
for i=1: fil
    for j =1: col
        if (aux(i,j) == 255)%verificamos si el pixel actual esta en 255
            sumaPosi = sumaPosi + 1;%sumamos 1 a la variable contadora de pixeles blancos
        end
    end
    if(sumaPosi>col-10)%una ves terminamos el ciclo verificamos que la cantidad de blancos sea mayor al numero de colum
        for p=1: col
            aux2(i,p) = 0;%en caso afirmativo vamos borrando esos pixeles blancos en la imagen original
        end
    end
    sumaPosi = 0;%reiniciamos la variable
end
end

