bw1 = imread('esquejeBw2.bmp');
figure(1); 
subplot 121; imshow(bw1);
bw = im2bw(bw1);
subplot 122;imshow(bw);
bw = bwareaopen(bw,1000);
prop= regionprops(bw,'all');

hold on
pe = prop.Extrema
p1 = pe(1,1)
p5 = pe(5,1)
if (p1 < 700) && (p5 < 700)
    bw = imrotate(bw,180);
    hold on
    imshow(bw);
end

prop= regionprops(bw,'all');
N = length(prop);

hold on
pe = prop.Extrema
plot(pe(:,1),pe(:,2),'m*','LineWidth',1.5);

pb = prop.BoundingBox
rectangle('Position',pb,'EdgeColor','g','LineWidth',2);
hold on

pch = prop.ConvexHull
plot(pch(:,1),pch(:,2),'LineWidth',2);
hold on

pc = prop.Centroid
plot(pc(1),pc(2),'*','MarkerSize',10,'LineWidth',2);

hold on
P1=[pe(8,1) pe(8,2)];P2=[pe(4,1) pe(4,2)];
recta = plot([P1(1) P2(1)],[P1(2) P2(2)],'r','LineWidth',2)

 
hold on
po = prop.Orientation
bw2 = imrotate(bw,-po);
figure(2); imshow(bw2);
% figure(2);
% subplot 121; imshow(bw); title('Original');
% subplot 122; imshow(bw2); title('Alineada');