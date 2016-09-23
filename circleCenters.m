distanceThreshold = 220;
%if two domino circles are greater than 200 pixels away, then they are
%on opposite sides of the domino

image = imread('d1.jpg');
[centersDark, radiiDark] = imfindcircles(image,[15 30],'ObjectPolarity','dark');
[centersDarkSmall, radiiDarkSmall] = imfindcircles(image,[5 15],'ObjectPolarity','dark');
markedImage = insertMarker(image,centersDark, 'x', 'color', 'white', 'size', 10);
markedImage2 = insertMarker(markedImage,centersDarkSmall, 'circle', 'color', 'green', 'size', 15);
imshow(markedImage2);

faceOneCircles = length(centersDark);
faceTwoCircles = [];

for i = 1:length(centersDark)     
    for j = i + 1:length(centersDark)
        if ((sqrt((centersDark(i,1) - centersDark(j,1))^2 + (centersDark(i,2) - centersDark(j, 2))^2)) > distanceThreshold)   
            faceTwoCircles(1,:) = centersDark(j,:);
            %decremented twice cause GAY
            faceOneCircles = faceOneCircles - 1;
        end
    end
end

values = [faceOneCircles + 1, length(faceTwoCircles(1))];