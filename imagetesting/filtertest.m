%while 1
for threshhold=1
sloth = imread('sloth.jpeg'); %returns image as m*n*3 rgb matrix  for m*n image
greysloth=rgb2gray(sloth);
blur=imgaussfilt(greysloth,threshhold);
cannysloth=edge(blur,'canny');
mask=ones(9)*1.2;

mask(2:4,2:4)=1;


cannysloth=conv2(single(cannysloth),mask,'same');
cannysloth=cannysloth/max(max(cannysloth));
edgesgone=uint8(zeros(size(sloth)));
edgesonly=uint8(zeros(size(sloth)));
for i=1:2 %red and green channels only
    edgesgone(:,:,i)=sloth(:,:,i) .* uint8(~cannysloth);
    edgesonly(:,:,i)=sloth(:,:,i) .* uint8(cannysloth);
end
labsloth=uint8(rgb2lab(sloth));
labdiff=(labsloth(:,:,1))-greysloth;
clf
imshow(cannysloth);
end
%end
%imsave