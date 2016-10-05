function [rotationMatrix, translationVector, imagePoints] = getExtrinsics(cameraParams, image);
%Gives the rotationMatrix and translation vector from the central frame to
%the camera
try
worldPoints = generateCheckerboardPoints([4 5], 17);
im = undistortImage(image, cameraParams);
[imagePoints, boardSize] = detectCheckerboardPoints(im);
[rotationMatrix, translationVector] = extrinsics(imagePoints, worldPoints, cameraParams);
J = insertMarker(im, imagePoints, '+', 'color', 'red', 'size', 5);
%J = insertMarker(J, camMat.PrincipalPoint, 'circle', 'color', 'green', 'size', 5);
imshow(J);
catch
    disp('Central Frame not detected');
    rotationMatrix = [0,0,0; 0,0,0; 0,0,0];
    translationVector = [-20,-20,0];
end