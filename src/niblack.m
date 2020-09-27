function imt=niblack(im,k,N)
% http://www.mathworks.com/matlabcentral/fileexchange/29287-automata-engineer-2010-nitk-documented-version/content/code/niblack.m
% Niblack's method
% im = grayscale image

% Calculate local means and variance
localMean= filter2(ones(N), im) ./ (N*N);
localVar= filter2(ones(N), (double(im)-localMean).^2) ./(N*N);
localStd=sqrt(localVar);

%Find threshold levels
weight=k;
tp=localMean+weight*localStd;
%=localMean-weight*localStd;

%apply thresholds and store all three layers in one image
%i1=(im>tp)*255;
%i2=((im>tm)&(im<tp))*100;
%imt=i1+i2;

imt=(im>tp);