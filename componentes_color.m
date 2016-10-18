function [b,c]=componentes_color(a);
[fil,col,cap]=size(a);
if cap ==1
    b=a;c=a;
    return
end
a1=a;
%%%----Componentes rgb-----%
a1=normaliza(a1);
a1=w2linea(a1);
%----Componente hsv----%
a2=rgb2hsv(a);
s=a2(:,:,2);
a2=normaliza(a2);
a2=w2linea(a2);
%-----Componente lab-----%
cform=makecform('srgb2lab');
a3=applycform(a,cform);
lab=a3;
a3=normaliza(a3);
a3=w2linea(a3);
%------Componente cmyk-----%%
cform=makecform('srgb2cmyk');
a4=applycform(a,cform);
a4=normaliza(a4);
c1=a4(:,:,3);
a4=a4(:,:,1:3);

a4=w2linea(a4);%%Este debe ir desps de la re acomodacion para que queden solo 3 capas

%%-------Componente lch para esta necesito lab-----%%%
cform=makecform('lab2lch');
a5=applycform(lab,cform);
a5=normaliza(a5);
a5=w2linea(a5);

c1=normaliza(c1);
c=c1;
b=[a1;a2;a3;a4;a5];

end