function [m, a] = ab2v(v1, v2)
% Magnitud del vector es su norma
m(1) = norm(v1);
m(2) = norm(v2); 

% Min. ángulos de vector 1 a ejes
a(1 : 3) = acosd(v1 / m(1));
% Min. ángulos de vector  a ejes
a(4 : 6) = acosd(v2 / m(2)); 

% Dot product dot(v1, v2) equals sum(v1 .* v2)
a(7) = acosd(dot(v1, v2) / m(1) / m(2)); 
end

