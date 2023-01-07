clc
clear
close all
%% CMB read
cmb = csvread('cmb-5000-2sigma-N.csv');
%% CMB read
cmb(cmb == 2000) = 1;
cmb(cmb == 0) = 0;
% imshow(cmb(65:75, 100:110))
% imshow(cmb(80:end, 1:10))
% cmb_sample = cmb(80:end, 1:10);
cmb_sample = cmb;
cmb_sample = ~cmb_sample;
imshow(cmb_sample)
stats = regionprops('struct',bwconncomp(cmb_sample,4),'BoundingBox','Image','Area','Extent','Centroid','Solidity','PixelIdxList','PixelList');
max = stats(1).Area;
for i = 1:length(stats)
    if stats(i).Area > max
        max = stats(i).Area;
        max_point = i;
    end 
    if stats(i).Area < 100
        cmb_sample(stats(i).PixelIdxList) = 0;
    end
    
end
cmb_sample(stats(max_point).PixelIdxList) = 0;
figure
imshow(cmb_sample)
%% 5000 - 2 sigma
cmb = csvread('cmb-5000-2sigma-N.csv');
cmb(cmb == 2000) = 1;
cmb(cmb == 0) = 0;
% imshow(cmb(65:75, 100:110))
% imshow(cmb(80:end, 1:10))
% cmb_sample = cmb(80:end, 1:10);
cmb_sample = cmb;
cmb_sample = ~cmb_sample;
%imshow(cmb_sample)
stats = regionprops('struct',bwconncomp(cmb_sample,4),'BoundingBox','Image','Area','Extent','Centroid','Solidity','PixelIdxList','PixelList');
%%
for i = 1:length(stats)
    if stats(i).Area < 800
        cmb_sample(stats(i).PixelIdxList) = 0;
    end
end
figure
imshow(cmb_sample)
stats = regionprops('struct',bwconncomp(cmb_sample,4),'BoundingBox','Image','Area','Extent','Centroid','Solidity','PixelIdxList','PixelList');
%% Otsu
cmb_tmp = csvread('cmb-200-2sigma-tmp.csv');
cmb_tmp = floor(cmb_tmp);
cmb_tmp = cmb_tmp + abs(min(min(cmb_tmp)));
offset = 0;
[~, k] = OtsuThersholding(cmb_tmp, offset);
cmb_tmp = 0.*(cmb_tmp<=k+offset) + 255.*(cmb_tmp>k+offset);
figure
imshow(uint8(cmb_tmp))
stats = regionprops('struct',bwconncomp(cmb_tmp,4),'BoundingBox','Image','Area','Extent','Centroid','Solidity','PixelIdxList','PixelList');
for i = 1:length(stats)
    if stats(i).Area < 50 || stats(i).Area > 100000
        cmb_tmp(stats(i).PixelIdxList) = 0;
    end
end
stats = regionprops('struct',bwconncomp(cmb_tmp,4),'BoundingBox','Image','Area','Extent','Centroid','Solidity','PixelIdxList','PixelList');
figure
imshow(uint8(cmb_tmp))
title('connected area bigger than 50 pixels and smaller than 100000 pixels')


