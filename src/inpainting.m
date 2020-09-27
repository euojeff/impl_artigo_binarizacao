function [ out ] = inpainting( im, mask )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[h,w] = size(mask);

h = h*0.15;

media = imfilter(im,ones(h)/(h*h),'symmetric');


out = uint8(double(mask).*double(im) + double(not(mask)).*double(media));


end

