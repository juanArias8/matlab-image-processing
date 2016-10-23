function [aux2] = eliminaCeldasB( imagenBin,capa )
 [fil,col] = size(imagenBin);
 ee=strel('disk',10);
 aux=imdilate(imagenBin,ee);
 aux2=capa;
 sumaPosi =0;

 for i=1: fil
    for j =1: col
        if (aux(i,j) == 255)
            sumaPosi = sumaPosi + 1;
        end
    end
    if(sumaPosi>col-10)
        for p=1: col
            aux2(i,p) = 0;
        end
    end
    sumaPosi = 0;
end
end

