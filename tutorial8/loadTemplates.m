%script for loading a library of template images to a single scene image 
%possibly for use with sift-like feature matching technique

files = dir('./templates/*.jpg')';
numims=size(files,1);
i=0;
%preallocate matrix of template images

%read in the templates from the templates directory
for file=files
    i=i+1;
    imname=file.name;
    imdir=strcat('./templates/',imname);
    imname=imname(1:2); %label for the image (the first 2 characters for this case)
    im=imread(imdir);
    [Irows(i), Icols(i), InumberOfColorChannels] = size(im);
    %convert to greyscale single if not already:
    if InumberOfColorChannels>1     Ig = single(rgb2gray(im)); else   Ig = single(im); end 
    templates(i,:,:)=Ig;
end
%From here we can iterate over individual template images by accessing them
%as templates(i,:,;)
%%for testing 
%imScene=imread('DominoSetup.1.jpg');
%images2dsiftmatch(imScene,squeeze(templates(6,:,:)));