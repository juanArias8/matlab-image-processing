bw = imread('ima1.bmp');
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

%Guardamos en sv el tamaño del vector
sv = size(vec)

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

%Guardamos en y1 la fila donde inicia el esqueje (inicio del tallo) 
y1 = 0;
for i=1: fil
    if (bw(i,x) == 1)
        y1 = i;
        break;
    end
end
y1 = y1 +sumax;

%%%%%%%%%%%%%%%%%%% HALLAMOS LOS PUNTOS INICIALES DE LA HOJA %%%%%%%%%%%%%%
%Guardamos en y la columna donde termina el esqueje
y=x;
for i=x:sv(2)
    if(vec(i) ~= 0)
        y=y+1;
    else
        break;
    end
end

%Hallamos el valor promedio del grosor (en px) del tallo
prom = 0;
for i=x:(x+200)
    prom = prom + vec(i);
end
prom = prom/200;


%Hallamos la columna donde nace la hoja
dis = ((x+400));
co = 0;
t = prom+15;
for i=x:(dis)
    if (vec(i) < (t))
        co = i;
    end
end


%Contamos el número de pixeles blancos en la columna y 
%Lo almacenamos en sumax
sumax = 0;
for i=1: fil
    if (bw(i,co) == 1)
        sumax = sumax+1;
    end
end
sumax = sumax/2;


%Hallamos la fila donde nace la hoja y le sumamos la mitad del valor de
%sumax
fi = 0;
for i=1: fil
    if (bw(i,co) == 1)
        fi = i;
        break;
    end
end
fi = fi+sumax;


%%%%%%%%%% TRAZAMOS DOS RECTAS POR LOS PUNTOS ENCONTRADOS %%%%%%%%%%%%%%%%%
subplot 121; imshow(bw); impixelinfo
hold on;
%Trazamos rectas por los puntos 
P1=[co,0]; P2=[co,fil];
recta = plot([P1(1) P2(1)],[P1(2) P2(2)],'r','LineWidth',1);

P3=[0,fi]; P4=[col,fi];
recta1 = plot([P3(1) P4(1)],[P3(2) P4(2)],'r','LineWidth',1);

P5=[x,0];P6=[x,fil];
recta2 = plot([P5(1) P6(1)],[P5(2) P6(2)],'g','LineWidth',1);

P7=[0,y1]; P8=[col,y1];
recta3 = plot([P7(1) P8(1)],[P7(2) P8(2)],'g','LineWidth',1);