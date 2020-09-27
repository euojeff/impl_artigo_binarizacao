function [ out ] = normalization( i, bg )

    f = (double(i) + 1)./ (double(bg) + 1);
    
    fmax = double(max(f(:)));
    fmin = double(min(f(:)));
    imax = double(max(i(:)));
    imin = double(min(i(:)));

    out = ((imax-imin)*(f - fmin)/(fmax - fmin)) + imin;
    out = uint8(out);


end

