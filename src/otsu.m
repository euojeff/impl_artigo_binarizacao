function [bw] = otsu(im)


    level = graythresh(im);
    bw = im2bw(im,level);
    figure('Name','Otsu');imshow(bw);
    
    bw = postProcess(bw);
    figure('Name','OtsuPost');imshow(bw);

end


function [out] = postProcess(bwOtsu)

        % No artigo o foreground é 1 e o background é 0. Mas no matlab é 0
        % o foreground e 1 o back.
        
        compOtsu = not(bwOtsu);
        
        labels = bwlabel(compOtsu, 8);
    
        elements = unique(labels(:));

        qtdEL = length(elements);
        
        %Imagem Branca
        out = (bwOtsu.*0) + 1;
        
        alturas = zeros(1,qtdEL-1);
        
        %seta array de alturas para facilitar buscas
        for i = 1: qtdEL-1

            [h, w] = find(labels == i);
            alturas(i) = max(h) - min(h);
            
        end
        
        
        sumRatio = 0;
        HThreshold = 0;
        for i = 1: length(bwOtsu)
            
            componentes = find(alturas == i);
            
            if (length(componentes) ~= 0)
            
                %Somar todos os pixels da mesma altura
                SUMOJ = 0;

                for j = 1: length(componentes)
                    index = labels == componentes(j);
                    SUMOJ = SUMOJ + sum(compOtsu(index));
                end


                RP = SUMOJ/sum(compOtsu(:));
                RC = length(componentes)/length(alturas);

                sumRatio = sumRatio + (RP/RC);

                if (sumRatio > 1)
                    HThreshold = i;
                    break;
                end
            
            end
            
        end
        
        
            componentes = find(alturas >= HThreshold);  
            for j = 1: length(componentes)
                index = labels == componentes(j);
                out(index) = 0;
            end
end