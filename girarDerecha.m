function [ imaRotada ] = girarDerecha( imagen )
bw = imagen;
prop = regionprops(bw,'all');
ext = prop.Extrema;
p1 = ext(1,1);
p6 = ext(6,1);
if (p1 < 600) && (p6 < 600)
    bw = imrotate(bw,180);
end
imaRotada = bw;
end

