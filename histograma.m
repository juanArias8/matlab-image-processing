bw = imread('esquejeBw2.bmp');
[fil,col] = size(bw);
vec = zeros(1,col);
for i=1: col
    for j =1: fil
        if (bw(j,i) == 1)
            vec(i) = vec(i)+1;
        end
    end
end
figure(1);
subplot 121; imshow(bw);
subplot 122; plot(vec);

sv = size(vec)
x=1;
for i=1:sv(2)/2
    if(vec(i) == 0)
        x=x+1;
    else
        break;
    end
end

suma = x;

    
    
    
    
        