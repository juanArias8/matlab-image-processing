clear all; close all; clc
esqueje = imread('esquejeBw.jpg');
bw = im2bw(esqueje);
figure(1); imshow(bw);

[l ne] = bwlabel(bw);
propied = regionprops(l);
hold on
% for n=1:size(propied,1)
%     rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2);
% end
%Buscar áreas menores a 500
s = find([propied.Area]<2500);
%Marcamos áreas menores a 500
% for n=1:size(s,2)
%     rectangle('Position',propied(s(n)).BoundingBox,'EdgeColor','r','LineWidth',2);
% end
%Eliminamos menores 
for n=1:size(s,2)
    d = round(propied(s(n)).BoundingBox);
    bw(d(2):d(2)+d(4),d(1):d(1)+d(3)) = 0;
end
figure(2); imshow(bw);

% img = rgb2gray(esqueje);
% umb = graythresh(img);
% bw = im2bw(img,umb);
% imshow(img);
% bw2 = bwareaopen(esqueje, 2500);

bw2 = bw;
prop = regionprops(bw2,'Orientation')
x = prop.Orientation
bw3 = imrotate(bw2, x);
figure(3);
subplot 121; imshow(bw2); title('Original');
subplot 122; imshow(bw3); title('Alineada');
