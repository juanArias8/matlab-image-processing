function  esquejeAlineado = alinearEsqueje(esquejeBin)
%--------------------------------------------------------------------------
%-- 1. Inicio de la función esquejeAlineado -------------------------------
%--------------------------------------------------------------------------   
esquejeAlineado = imrotate(esquejeBin,180);%llevamos la imagen binarizada girada 180 grados
figure(1);imshow(esquejeAlineado);%mostramos como quedo la figura después haber sido girada
title('Esqueje girado para alinear');%le ponemos un titulo donde se explica que se hizo
%--------------------------------------------------------------------------
%-- 2. Sacamos las propiedades del esqueje binarizado ---------------------
%--------------------------------------------------------------------------
prop = regionprops(esquejeAlineado,'all');%obtenemos las propiedades de la imagen
N = length(prop);
%--------------------------------------------------------------------------
%-- 3. Sacamos el el rectangulo que rodeara al esqueje binarizado  --------
%--------------------------------------------------------------------------
pb = prop.BoundingBox %Establece el rectángulo más pequeño que puede contener toda la región
rectangle('Position',pb,'EdgeColor','g','LineWidth',2);%dibujamos el rectangulo
hold on
%--------------------------------------------------------------------------
%-- 3. Sacamos los puntos que rodeara al esqueje binarizado  --------------
%--------------------------------------------------------------------------
pch = prop.ConvexHull%crea los puntos de la imagen binaría
plot(pch(:,1),pch(:,2),'LineWidth',2);%dibujamos los puntos
hold on
%--------------------------------------------------------------------------
%-- 4. Sacamos los puntos extremos que tiene el esqueje binarizado  -------
%--------------------------------------------------------------------------
pe = prop.Extrema%Obtenemos los puntos extremos de la imagen binarizada
plot(pe(:,1),pe(:,2),'m*','LineWidth',1.5);%dibujamos los puntos extremos
hold on
%--------------------------------------------------------------------------
%-- 5. Sacamos el centroide que tiene el esqueje binarizado  --------------
%--------------------------------------------------------------------------
%pone el centroide
pc = prop.Centroid%Obetenemos el punto centro del area binarizada
plot(pc(1),pc(2),'*','MarkerSize',10,'LineWidth',2);%dibujamos el centroide
%--------------------------------------------------------------------------
%-- 6. Dibujamos las lineas que van desde el centroide hasta los estremos -
%--------------------------------------------------------------------------
hold on
P1=[pe(8,1) pe(8,2)];P2=[pc(1) pc(2)];%creamos los diferentes punto de las rectas
plot([P1(1) P2(1)],[P1(2) P2(2)],'r','LineWidth',2)%dibujamos las rectas

P1=[pe(6,1) pe(6,2)];P2=[pc(1) pc(2)];%creamos los diferentes punto de las rectas
plot([P1(1) P2(1)],[P1(2) P2(2)],'r','LineWidth',2)%dibujamos las rectas

P1=[pe(4,1) pe(4,2)];P2=[pc(1) pc(2)];%creamos los diferentes punto de las rectas
plot([P1(1) P2(1)],[P1(2) P2(2)],'g','LineWidth',2)%dibujamos las rectas

P1=[pe(2,1) pe(2,2)];P2=[pc(1) pc(2)];%creamos los diferentes punto de las rectas
plot([P1(1) P2(1)],[P1(2) P2(2)],'b','LineWidth',2)%dibujamos las rectas
%--------------------------------------------------------------------------
%-- 6. Dibujamos las lineas que van a pasar por el centroide --------------
%--------------------------------------------------------------------------
[fil,col] = size(esquejeAlineado);%Obtenemos ancho y largo de la imagen
%creando lineas del eje x
P1=[pc(1),0]; P2=[pc(1),fil];%creamos los diferentes punto de las rectas
plot([P1(1) P2(1)],[P1(2) P2(2)],'g','LineWidth',2);%dibujamos las rectas
%creando lineas del eje y
P3=[0,pc(2)]; P4=[col,pc(2)];%creamos los diferentes punto de las rectas
plot([P3(1) P4(1)],[P3(2) P4(2)],'g','LineWidth',2);%dibujamos las rectas
hold on
%--------------------------------------------------------------------------
%-- 6. sacamos el angulo que se esta desviado el esqueje con el centroide -
%--------------------------------------------------------------------------
v1 = [pe(4,1)-pc(1) 0 0]%creamos los vectores con las puntos del cemtroide y los puntos extremos
v2 = [pe(4,1)-pc(1) -(pe(4,2)-pc(2)) 0] %creamos los vectores con las puntos del cemtroide y los puntos extremos

[a1, a2] = ab2v(v1, v2);%le llevamos a la función los dos vectores
%--------------------------------------------------------------------------
%-- 7. Alineamos la imagen dependiendo del angulo que se haya generado ----
%--------------------------------------------------------------------------
if v2(2)>0
    esquejeAlineado = imrotate(esquejeAlineado, -a2(7));%si el y es positivo se va alinear hacia abajo
else
    esquejeAlineado = imrotate(esquejeAlineado, a2(7));%si el y es negativo se va alinear hacia arriba
end
esquejeAlineado = imrotate(esquejeAlineado,180);%volvemos el esqueje a su forma original
end

