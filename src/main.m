function [] = main( imName )

    mat = imread(strcat('img/',imName));

    [h, w, p] = size(mat);

    if p == 1
        im = mat;
    else
        im = rgb2gray(mat);
    end


    figure('Name','Imagem Original');imshow(im);

    ni = niblack(im, -0.2, 60);
    fundo = not(ni);

    %Foreground Dilatado
    nidilatado = not(imdilate(not(ni),ones(3)));
    figure('Name','Foreground Dilatado');imshow(ni);

    %Background
    bg = inpainting(im,nidilatado);
    normal = normalization(im, bg);
    figure('Name','Background Estimado');imshow(bg);

    figure('Name','Normalization');imshow(normal);

    imOtsu = otsu(normal);

    skel = bwmorph(not(imOtsu),'skel',Inf);
    figure('Name','Skel');imshow(skel);

    local = localBinarization( im, normal,bg, imOtsu, skel);

    final = finalBinarization(imOtsu, local);
    
    imwrite(final,strcat('img/BIN_',imName),'bmp');

end