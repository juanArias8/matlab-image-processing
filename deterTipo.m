function tipo  = deterTipo( lmax,lmin,pHoja,longiEsque,pHojaEsq )
    if longiEsque < lmax
        if longiEsque > lmin
            if pHojaEsq > pHoja
                tipo = 'ideal';
            else
                tipo = 'hoja en base';
            end
        else
            tipo = 'corto';
        end
    else
        tipo = 'largo';
    end


end

