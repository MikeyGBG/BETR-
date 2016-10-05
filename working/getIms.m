function camMat = getIms(vid)
%Grabs 20 images from the vid object and passes them to camCal function
%Returns the camera matrix

for i =1:20

        trigger(vid);

        [Im, Time, Meta] = getdata(vid);
        files{i} = Im;

end
disp('stop dANCE');
for i =1:20
    
        fName = sprintf('calIm%d.png', i);

        imwrite(files{i}, fName);
end
 
    
camMat = camCal('calIm');




