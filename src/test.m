im = imread('doc1.bmp');
ot = otsu(im);

imshow(ot);

bwconncomp(otsu(im));