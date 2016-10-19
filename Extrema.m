bw1 = imread('esquejeBw3.bmp');
bw = im2bw(bw1);
imshow(bw);

bw = bwareaopen(bw,1000);
% [L Ne]=bwlabel(bw);
% 
% propied= regionprops(L);
% for n=1:size(propied,1)
%     rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
% end
% 
% s=find([propied.Area]<500);
% for n=1:size(s,2)
%     d=round(propied(s(n)).BoundingBox);
%     bw(d(2):d(2)+d(4),d(1):d(1)+d(3))=0;
% end

prop= regionprops(bw,'all');
N = length(prop);

pb = prop.BoundingBox
rectangle('Position',pb,'EdgeColor','g','LineWidth',2);
hold on

pch = prop.ConvexHull
plot(pch(:,1),pch(:,2),'LineWidth',2);
hold on

pe = prop.Extrema
plot(pe(:,1),pe(:,2),'m*','LineWidth',1.5);
hold on

pc = prop.Centroid
plot(pc(1),pc(2),'*','MarkerSize',10,'LineWidth',2);

hold on
P1=[pe(4,1) pe(4,2)];P2=[pc(1) pc(2)];
 plot([P1(1) P2(1)],[P1(2) P2(2)],'r','LineWidth',2)