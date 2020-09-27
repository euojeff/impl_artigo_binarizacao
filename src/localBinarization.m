function [ out ] = localBinarization( original, normal,background, otsu, skel)

    SW = sw( otsu, skel );
    
    fg = original(skel==1);
    %fg = original;
    
    bg = background(skel==1);
    
    
    C = (-50) * log10((mean(double(fg(:))) + std(double(fg(:))))/(mean(double(bg(:))) - std(double(bg(:)))));
    
    k = (-0.2)-((0.1)*(C/10));
    
    W = 2*SW;
    
    out = niblack(normal,k,W);
    
    figure('Name','Local Binarization'); imshow(out);
    
    out = merge(otsu, out, C);
    
    figure('Name','Melhorada'); imshow(out);
    

end

function [ out ] = merge( otsu, ni, C)


    labels = bwlabel(not(ni), 8);
    
    elements = unique(labels(:));
    
    qtdEL = length(elements);
    
    %Imagem Branca
    out = (otsu.*0) + 1;
    
    for i = 1: qtdEL-1
        
        index = find(labels==i);
       
       if 100*(sum(not(otsu(index)).*not(ni(index)))/sum(not(ni(index)))) >= C
           out(index) = 0;
       end
       
       
    end
end

