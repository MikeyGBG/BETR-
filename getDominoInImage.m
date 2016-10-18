function dominoInImage = getDominoInImage(closedBW, colorIm)
%Given a BW and colorIM, this function returns an RGB image containing
%markers and bounding boxes, corresponding to the centroid and area of
%detected dominos

blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
    'AreaOutputPort', false, 'CentroidOutputPort', false, ...
    'MinimumBlobArea', 150);
bbox = step(blobAnalysis, closedBW);
dominoInImage = insertShape(colorIm, 'Rectangle', bbox, 'Color', 'green');
numDominos = size(bbox, 1);
dominoInImage = insertText(dominoInImage, [10 10], numDominos, 'BoxOpacity', 1, ...
    'FontSize', 14);

centroid = regionprops(closedBW,'Centroid');
centroids = cat(1, centroid.Centroid);

for i = 1:length(centroid)
    dominoInImage = insertMarker(dominoInImage, centroids);
end

