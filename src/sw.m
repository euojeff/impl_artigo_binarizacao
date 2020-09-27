function [ out ] = sw( otsu, skel )

    labels = bwlabel(skel, 8);
    
    elements = unique(labels(:));
    
    qtdEL = length(elements);
    
    maxSWs = zeros(1, qtdEL);
    
    
    for i = 1: qtdEL-1
    
       [k, l] = find(labels==i);
       
       indexs = [k l];
       
       SW = zeros(1, length(l));
       
       for j = 1: length(l)
        SW(j) = findSW( indexs(j, :), otsu );     
       end
       
       maxSWs(i) = max(SW);
       
    end
    
     out = mean(maxSWs);

end


function [ out ] = findSW( index, im )

        [IMlinha, IMcoluna] = size(im);
        linha = index(1);
        coluna = index(2);
        
        width = 0;

        for i = coluna : IMcoluna
            if im(linha, i) == 0
                width = width + 1;
            else
                break;
            end
        end
        
        out = (width * 2) + 1;

end

