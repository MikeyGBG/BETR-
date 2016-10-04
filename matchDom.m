function [domNum, locations]  = matchDom(scene);
%Takes an image and tries to match the surf features of the image to the
%surf features in the domino image, returns the domino thaty was matched
%value and position on features in the scene

%Domino value array
domNums1 = [0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6];
domNums2 = [0, 1, 3, 4, 6, 1, 4, 5, 6, 0, 2, 3, 4, 5, 6, 1, 3, 3, 4, 5, 0, 3, 5, 6, 3, 4, 6];

j = 0;

%For every domino
for i = 1:length(domNums1)
try
    domFiles{i} = sprintf('dom%d%d.png', domNums1(i), domNums2(i));
    
    domImage = imread(domFiles{i});
    sceneImage = imread(scene);

    domImage = rgb2gray(domImage);
    sceneImage = rgb2gray(sceneImage);
    
    %Find SURF featured in scene and the domino image
    domPoints = detectSURFFeatures(domImage);
    scenePoints = detectSURFFeatures(sceneImage);

    %Extract the feautree descriptors of the SURF features
    [domFeatures, domPoints] = extractFeatures(domImage, domPoints);
    [sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);
    
    %Attempt to match the SURF Features
    boxPairs = matchFeatures(domFeatures, sceneFeatures, 'MaxRatio', 0.1);

    matchedBoxPoints = domPoints(boxPairs(:, 1), :);
    matchedScenePoints = scenePoints(boxPairs(:, 2), :);
    
    %Find the transformation between the domino and the scene SURF Features
    [tform, inlierBoxPoints, inlierScenePoints] = ...
        estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');

    figure;
    showMatchedFeatures(domImage, sceneImage, inlierBoxPoints, ...
        inlierScenePoints, 'montage');
    title('Matched Points (Inliers Only)');
    
    j = j + 1;
    
    %Get the value of the matched Domino
    domNum(j,1) = domNums1(i);
    domNum(j,2) = domNums2(i);
    
    %Find the average locaitron of the matched Features
    locations(j,1) = mean2(inlierScenePoints.Location(:,1));
    locations(j,2) = mean2(inlierScenePoints.Location(:,2));

catch
    message = sprintf('Error in matching domino %d%d\n', domNums1(i), domNums2(i));
    disp('message);
end
end
