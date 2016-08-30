vid = videoinput('kinect', 1, 'RGB_1280x960');
src = getselectedsource(vid);

vid.FramesPerTrigger = 1;

%GET IMAGE
frame = getsnapshot(vid);
image(frame);

%CONVERT IMAGE FROM RGB TO GRAYSCALE
gray = rgb2gray(frame);

%HIGHBOOST FILTER 3x3
%filly = [0.1,0.1,0.1;0.1,1,0.1;0.1,0.1,0.1];
%blur = uint8(conv2(double(gray), filly));

%SET SIZE OF LPF
N = 5;
%CREATE LPF
filly = ones(N)/(N^2);
%APPLY LPF
blur = uint8(conv2(double(gray), filly));
%REMOVE CONVOLUTION ARTEFACTS
blur = imcrop(blur, [N, N,(length(blur(:, 1)) - 7*N), (length(blur(1,:)) - 2*N)]);

%FIND EDGES USING CANNY EDGE DETECTOR(IS BEST EDGE DETECTOR)
BW = edge(blur, 'canny');
%DISPLAY EDGED IMAGE
figure, imshow(BW);

%HOUGH TRANSFORM IMAGE
[H, T, R] = hough(BW);  %LOOK INTO HOUGH CIRCLES
%FIND 2 HIGHEST PEAKS OF HOUGH TRANSFORM (CORRESPONDS TO 2 LONGEST LINES)
P = houghpeaks(H,2,'threshold',ceil(0.4*max(H(:))));
%GET LINES FROM HOUGH TRANSFORM
lines = houghlines(BW,T,R,P,'FillGap',80,'MinLength',5);

%OVERLAY LINES ON ORIGINAL IMAGE
figure, imshow(frame), hold on
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2), 'LineWidth',2,'Color','green');
end

%PLOT LINES BETWEEN THE END POINTS OF 2 LONGEST LINES (SHOULD GIVE THE SHORT DOMINO EDGES)
xy = [lines(1).point1; lines(2).point1];
plot(xy(:,1),xy(:,2), 'Color', 'red');
xy = [lines(1).point2; lines(2).point2];
plot(xy(:,1),xy(:,2), 'Color', 'red');
