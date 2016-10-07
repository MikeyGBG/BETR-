function camMat = getIms(vid)
%Grabs 20 images from the vid object and passes them to camCal function
%Returns the camera matrix

for i =1:20

        trigger(vid);
        Im = getdata(vid);
        fName = sprintf('calIm%d.png', i);

        imwrite(Im, fName);
end
disp('stop dANCE');
 
camMat = camCal('calIm');




