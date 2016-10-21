bw = imread('esquejeBw.bmp');
imshow(bw);
A = edge(bw,'sobel','horizontal');
figure, imshow(A);
[m,n] = size(A);
theta = -30:30;
[l1,l2] = size(theta);
p = (m^2+n^2)^0.5/100;
rho1 = 0:p:(m^2+n^2)^0.5;
[l3,l4] = size(rho1);
n = zeros(l4,l2);
for i = 1:m,
    for j=1:n,
        if(A(i,j)==1)
            for k = 1:l2,
                rho2 = i*cos(theta(k)*pi/180)+j*sin(theta(k)*pi/180);
                q = 1;
                while q <l4
                    if(rho1(q) < rho2 && rho2<=rho1(q+1))
                        n(q,k)=n(q,k)+1;
                    end
                    q=q+1;
                end
            end
        end
    end
end


recta = n(1,1);
for i=1:l4
    for j=1:l2
        if (n(i,j)>recta)
            recta=n(i,j);
            theta_recta=theta(j);
        end
    end
end
