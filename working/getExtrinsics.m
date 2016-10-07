function [rotationMatrix, translationVector, imagePoints] = getExtrinsics(cameraParams, image);
%Gives the rotationMatrix and translation vector from the central frame to
%the camera

im = undistortImage(image, cameraParams);
worldPoints = generateCheckerboardPoints([4 5], 16);
imagePoints = detectCheckerboardPoints(im);

J = insertMarker(im, imagePoints, '+', 'color', 'red', 'size', 5);
imshow(J);

[rotationMatrix, translationVector] = extrinsics(imagePoints, worldPoints, cameraParams);


end