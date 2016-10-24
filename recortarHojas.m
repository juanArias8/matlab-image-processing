function [ imaRecortada ] = recortarHojas( imagen )
bw = imagen;

%Hallamos el número de filas y colúmnas de la imagen
[fil,col] = size(bw);

%Creamos un vector cuyo tamaño es el número de colúmnas de la imagen
vec = zeros(1,col);

%Creamos el histograma para la imágen
for i=1: col
    for j =1: fil
        if (bw(j,i) == 1)
            vec(i) = vec(i)+1;
        end
    end
end

%Guardamos en sv el tamaño del vector
sv = size(vec);

%%%%%%%%%%%%%%%%%% HALLAMOS LOS PUNTOS INICIALES DEL TALLO %%%%%%%%%%%%%%%%
%Hallamos las coordenadas en x para el inicio del tallo
x=1;
for i=1:sv(2)
    if(vec(i) == 0)
        x=x+1;
    else
        break;
    end
end

%Hallamos el punto central del inicio del tallo
centro = vec(1,x)/2;

%Hallamos las coordenadas en y para el inicio del tallo
y=1;
for i=1:fil
    if (bw(i,x) == 1)
        y = i;
        break;
    end
end
y = y + centro;


%%%%%%%%%%%%%%RECORTAMOS LA IMAGEN EN X+100 Y X-100%%%%%%%%%%%%%%%%%%%%%%%%
y1 = uint32(y);
for i=1:(y1-100)
    for j=1:col
        if((bw(i,j))==1) 
            bw(i,j) = 0;
        end
    end
end
for i=(y1+100):fil
    for j=1:col
        if((bw(i,j))==1) 
            bw(i,j) = 0;
        end
    end
end
imaRecortada = bw;
end

