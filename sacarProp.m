function [area,esqueLongi] = sacarProp(imagenBin)
%--------------------------------------------------------------------------
%-- 1. Inicio de la funci�n sacarProp -------------------------------------
%-------------------------------------------------------------------------- 
%--------------------------------------------------------------------------
%-- 2. Sacamos el el rectangulo que rodeara al esqueje binarizado  --------
%--------------------------------------------------------------------------
prop = regionprops(imagenBin,'all');%obtenemos las propiedades de la imagen
%--------------------------------------------------------------------------
%-- 3. Sacamos el el rectangulo que rodeara al esqueje binarizado  --------
%--------------------------------------------------------------------------
pb = prop.BoundingBox %Establece el rect�ngulo m�s peque�o que puede contener toda la regi�n
%--------------------------------------------------------------------------
%-- 3. Sacamos el Area de la imagen binarizada ----------------------------
%--------------------------------------------------------------------------
area = prop.Area;%obtenemos el area del la imagen
esqueLongi = pb(3);%obtenemos la longitud del esqueje obtenida del rectangulo
end

