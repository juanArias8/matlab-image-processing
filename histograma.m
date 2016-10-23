bw = imread('ima9.bmp');
%bw= imrotate(bw,180);
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
figure(1);
subplot 122; plot(vec);
subplot 121; imshow(bw); impixelinfo
hold on

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
hold on
imshow(bw);impixelinfo

% %%%%%%%%%%%%%%%%%%% HALLAMOS LOS PUNTOS INICIALES DE LA HOJA %%%%%%%%%%%%

%Creamos de nuevo un vector
vec1 = zeros(1,col);
for i=1: col
    for j =1: fil
        if (bw(j,i) == 1)
            vec1(i) = vec1(i)+1;
        end
    end
end

%Hallamos el final del esqueje recortado
yf=x;
for i=x:col
    if(vec1(i) ~= 0)
        yf=yf+1;
    else
        break;
    end
end

%Hallamos el valor promedio del grosor (en px) del tallo
prom = 0;
for i=x:(x+100)
    prom = prom + vec(i);
end
prom = prom/100;

% %Hallamos la columna donde nace la hoja
x1 = 0;
i = x;
while(vec1(i) < (prom+10))
	x1 = i;
    i = i+1;
end

%Hallamos la fila donde nace la hoja
centroh = vec1(1,x1)/2;
y1=1;
for i=1:fil
    if (bw(i,x1) == 1)
        y1 = i;
        break;
    end
end
y1 = y1 + centroh;

%Trazamos los puntos por las coordenadas encontradas

%Punto inicial del tallo
hold on
P1=[x,0]; P2=[x,fil];
recta1 = plot([P1(1) P2(1)],[P1(2) P2(2)],'r','LineWidth',1);
P3=[0,y]; P4=[col,y];
recta2 = plot([P3(1) P4(1)],[P3(2) P4(2)],'r','LineWidth',1);

%Punto inicial de la primer hoja
hold on
P5=[x1,0]; P6=[x1,fil];
recta3 = plot([P5(1) P6(1)],[P5(2) P6(2)],'m','LineWidth',1);
P7=[0,y1]; P8=[col,y1];
recta4 = plot([P7(1) P8(1)],[P7(2) P8(2)],'m','LineWidth',1);
