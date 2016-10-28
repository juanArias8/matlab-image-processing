function [area,esqueLongi] = sacarProp(imagenBin)
    prop = regionprops(imagenBin,'all');
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
    
    %sacamos area
    area = prop.Area;
    esqueLongi = pb(3);
end

