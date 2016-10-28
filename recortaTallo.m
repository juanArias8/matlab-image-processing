function recortada = recortaTallo(imagenBin)
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
 
 for i=1: col
    for j =1: fil
        if (imagenBin(j,i) == 1)
            sumaBlancos = sumaBlancos + 1;
        else
            if(sumaBlancos<promedio+10)
                sumaBlancos = 0;
            else
                for k=j-sumaBlancos: sumaBlancos+j
                    recortada(k,i) = 0;
                end
                sumaBlancos = 0;
            end
        end
    end
 end
 figure(3);imshow(recortada);impixelinfo
 title('Tallo casi recortado');
 ee=strel('disk',14);

recortada=imdilate(recortada,ee);
figure(4);imshow(recortada);
title('Tallo dilatado para unir parque que se hayan recortado');
ee=strel('disk',14);
recortada=imerode(recortada,ee);
figure(5);imshow(recortada);
title('Tallo erocionado para borrar pixeles que no necesitamos');
recortada = bwareaopen(recortada,5000);

ee=strel('disk',10);
recortada=imerode(recortada,ee);
recortada = bwareaopen(recortada,1000);
    %Definimos un elemento estructurante mayor y luego realizamos dilate
ee=strel('disk',10);
recortada=imdilate(recortada,ee);
figure(6);imshow(recortada);
title('Tallo del esqueje');
end