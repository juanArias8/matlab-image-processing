function  talloAlineado = alinearPorTallo(esquejeBin)
    %esquejeRecortado = esqueRecor;
    talloAlineado = esquejeBin;
    tallo = recortaTallo(esquejeBin);
    tallo = imrotate(tallo,180);
    prop = regionprops(tallo,'all');
    N = length(prop);

    %Establece el rectángulo más pequeño que puede contener toda la región, con
    %las propiedades optenida con el metodo anterior

    pb = prop.BoundingBox
    rectangle('Position',pb,'EdgeColor','g','LineWidth',2);
    hold on

    %crea los puntos de la imagen binaría
    pch = prop.ConvexHull
    plot(pch(:,1),pch(:,2),'LineWidth',2);
    hold on

    %pone puntos extremos
    pe = prop.Extrema
    plot(pe(:,1),pe(:,2),'m*','LineWidth',1.5);
    hold on

    %pone el centroide
    pc = prop.Centroid
    plot(pc(1),pc(2),'*','MarkerSize',10,'LineWidth',2);

    hold on
    P1=[pe(8,1) pe(8,2)];P2=[pc(1) pc(2)];
    plot([P1(1) P2(1)],[P1(2) P2(2)],'r','LineWidth',2)
    
    P1=[pe(6,1) pe(6,2)];P2=[pc(1) pc(2)];
    plot([P1(1) P2(1)],[P1(2) P2(2)],'r','LineWidth',2)
    
    P1=[pe(4,1) pe(4,2)];P2=[pc(1) pc(2)];
    plot([P1(1) P2(1)],[P1(2) P2(2)],'g','LineWidth',2)
    
    P1=[pe(2,1) pe(2,2)];P2=[pc(1) pc(2)];
    plot([P1(1) P2(1)],[P1(2) P2(2)],'b','LineWidth',2)
    
    disp(pe(4,1)-pe(2,1));
    
    %creando lineas de eje x
    [m,n] = size(talloAlineado);
    P1=[0 pc(2)];P2=[m pc(2)];
    plot([P1(1) P2(1)],[P1(2) P2(2)],'b','LineWidth',2)

    %creando lineas de eje y
    P1=[pc(1) 0];P2=[pc(1) n];
    plot([P1(1) P2(1)],[P1(2) P2(2)],'b','LineWidth',2)

    hold on
    v1 = [pe(4,1)-pc(1) 0 0]
    v2 = [pe(4,1)-pc(1) -(pe(4,2)-pc(2)) 0] 

    [a1, a2] = ab2v(v1, v2);
    
    talloAlineado = imrotate(talloAlineado,180);
    %esquejeRecortado = imrotate(esquejeRecortado ,180);
    if v2(2)>0
        talloAlineado = imrotate(talloAlineado, -a2(7));
        %esquejeRecortado = imrotate(esquejeRecortado ,-a2(7));
    else
        talloAlineado = imrotate(talloAlineado, a2(7));
        %esquejeRecortado = imrotate(esquejeRecortado ,a2(7));
    end
    talloAlineado = imrotate(talloAlineado,180);
    %esquejeRecortado = imrotate(esquejeRecortado,180)
end