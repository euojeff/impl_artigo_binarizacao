function [ out ] = finalBinarization( otsu, co )

    compCOdil = imdilate(not(co),ones(3));
    
    out = not(or(not(co), compCOdil.*not(otsu)));
    
    figure('Name','Final Binarization'); imshow(out);

end

