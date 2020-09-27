function [ out ] = inpainting( original, im)

    [h, w] = size(original);
    
    im(1,:)
    
    original = double(original);

    xStart = [2, 2, w-1, w-1];
    xEnd = [w-1, w-1, 2, 2];
    yStart = [2, h-1, 2, h-1];
    yEnd = [h-1, 2, h-1, 2];
    
    p = zeros(h, w, 4);

    for i = 1 : 4
        
        %figure('Name', 'm');imshow(im);
        m = im;
        
        %figure('Name', 'm');imshow(m);
        if i == 1 || i == 3
            for y = yStart(i) : yEnd(i)
                if i == 1 || i == 2
                    for x = xStart(i) : xEnd(i)
                        if m(y, x) == 0
                            p(y, x, i) = med(x, y, original, m);
                            %original(y, x) =  p(y, x, i);
                            m(y, x) = 1;
                        end
                    end
                else
                    for x = xStart(i) : -1: xEnd(i)
                        if  m(y, x) == 0
                            p(y, x, i) = med(x, y, original, m);
                            %original(y, x) =  p(y, x, i);
                            m(y, x) = 1;
                        end
                    end
                end
            end
        else
            for y = yStart(i) : -1: yEnd(i)
                if i == 1 || i == 2
                    for x = xStart(i) : xEnd(i)
                        if m(y, x) == 0
                            p(y, x, i) = med(x, y, original, m);
                            %original(y, x) =  p(y, x, i);
                            m(y, x) = 1;
                        end
                    end
                else
                    for x = xStart(i) : -1: xEnd(i)
                        if m(y, x) == 0
                            p(y, x, i) = med(x, y, original, m);
                            %original(y, x) =  p(y, x, i);
                            m(y, x) = 1;
                        end
                    end
                end
            end 
        end
    end
    
    figure('Name', 'I = 1');imshow(uint8(p(:,:,1)));
    figure('Name', 'I = 2');imshow(uint8(p(:,:,2)));
    figure('Name', 'I = 3');imshow(uint8(p(:,:,3)));
    figure('Name', 'I = 4');imshow(uint8(p(:,:,4)));
    
    
    out = original;
    
    for y = 2: h-1
        for x = 2: w-1
            if im(y, x) == 0
                max(p(y, x, :))
                out(y, x) = max(p(y, x, :));
            end
        end
    end
    
    out = uint8(out);
    
    figure('Name','PQP');imshow(out);

end

function [imp] = med(x, y, original, m)

        L = 255 - original(y, x - 1)*m(y, x - 1);
        T = 255 - original(y - 1, x)*m(y - 1, x);
        R = 255 - original(y, x + 1)*m(y, x + 1);
        B = 255 - original(y + 1, x)*m(y + 1, x);

        imp = mean([L T R B]);

end

