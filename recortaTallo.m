function recortada = recortaTallo(imagenBin)
%--------------------------------------------------------------------------
%-- 1. Inicio de la función recortaTallo ----------------------------------
%--------------------------------------------------------------------------  
[fil,col] = size(imagenBin);
recortada = imagenBin;
figure(2);
subplot 121; imshow(recortada);
title('Imagen sin recortar');
sumaBlancos = 0;
vec = zeros(1,col);
%Creamos el histograma para la imágen
for i=1: col
    for j =1: fil
        if (imagenBin(j,i) == 1)
            vec(i) = vec(i)+1;
        end
    end
end
subplot 122; plot(vec);

%Guardamos en sv el tamaño del vector
sv = size(vec);

%%%%%%%%%%%%%%%%%% HALLAMOS LOS PUNTOS INICIALES DEL TALLO %%%%%%%%%%%%%%%%
%Guardamos en x la columna donde inicia el esqueje (inicio del tallo)
x=1;
for i=1:sv(2)
    if(vec(i) == 0)
        x=x+1;
    else
        break;
    end
end

    %Hallamos el valor promedio del grosor (en px) del tallo
 promedio = 0;
 for i=x:(x+200)
     promedio = promedio + vec(i);
 end
 promedio = promedio/200;
%--------------------------------------------------------------------------
%-- . Borrado de las columnas ---------------------------------------------
%--------------------------------------------------------------------------  
 for i=1: col
    for j =1: fil
        if (imagenBin(j,i) == 1)%verificamos si ese pixel esta en 1
            sumaBlancos = sumaBlancos + 1;%en caso afirmativo aumentamos la variable
        else
            if(sumaBlancos<promedio+10)%verificamos que la cantidad de pixel blancos de la columna
                sumaBlancos = 0;%en caso de que sea menor no la borramo y reiniciamos la variable% 
            else
                for k=j-sumaBlancos: sumaBlancos+j%realizamos un for dependiendo de la cantidad de blancos contados
                    recortada(k,i) = 0;%se procede a borrar la columna que no cumple la condición
                end
                sumaBlancos = 0;% y reiniciamos el contador de pixeles blancos de la columna
            end
        end
    end
 end
%--------------------------------------------------------------------------
%-- . Unir partes cortadas del tallo --------------------------------------
%--------------------------------------------------------------------------  
figure(3);imshow(recortada);impixelinfo%mostramos como queda la imagen recortada
title('Tallo casi recortado');%le ponemos el respectivo titulo
%--------------------------------------------------------------------------
%-- . Dilatación de la imagen para unbir puntos ---------------------------
%--------------------------------------------------------------------------
ee=strel('disk',14);%creamos nuestra figura morofologica
recortada=imdilate(recortada,ee);%dilatamos cada pixel blanco que cumpla la condición
figure(4);imshow(recortada);%mostramos el resultado
title('Tallo dilatado para unir parque que se hayan recortado');
%--------------------------------------------------------------------------
%-- . Eroción para volver a dar el contorno de la imagen ------------------
%--------------------------------------------------------------------------
ee=strel('disk',14);%creamos nuestra figura morofologica
recortada=imerode(recortada,ee);%erocionamos cada pixel blanco que cumpla la condición
figure(5);imshow(recortada);%mostramos el resultado
title('Tallo erocionado para borrar pixeles que no necesitamos');
recortada = bwareaopen(recortada,5000);%Borramos cualquier pixel basura que nos pueda perjudicar la alineada
%--------------------------------------------------------------------------
%-- . Inicio del tallo desproporcionado  ----------------------------------
%--------------------------------------------------------------------------
ee=strel('disk',10);%creamos nuestra figura morofologica
recortada=imerode(recortada,ee);%erocionamos cada pixel blanco que cumpla la condición
recortada = bwareaopen(recortada,1000);%borramos alguna basura extra que haya quedado
%--------------------------------------------------------------------------
%-- . Eroción para volver a dar el contorno de la imagen ------------------
%--------------------------------------------------------------------------
ee=strel('disk',10);%creamos nuestra figura morofologica
recortada=imdilate(recortada,ee);%dilatamos cada pixel blanco que cumpla la condición
figure(6);imshow(recortada);%mostramos todos los cambios realizados en el esqueje
title('Tallo del esqueje');
end