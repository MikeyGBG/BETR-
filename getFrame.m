vid = videoinput('kinect', 1, 'RGB_1280x960');
src = getselectedsource(vid);

vid.FramesPerTrigger = 1;

frame = getsnapshot(vid);
image(frame);

gray = rgb2gray(frame);

filly = [0.1,0.1,0.1;0.1,1,0.1;0.1,0.1,0.1];
blur = uint8(conv2(double(gray), filly));

N = 5;
filly = ones(N)/(N^2);

blur = uint8(conv2(double(gray), filly));



BW = edge(blur, 'canny');

figure, imshow(BW);

[H, T, R] = hough(BW);  %LOOK INTO HOUGH CIRCLES



P = houghpeaks(H,4,'threshold',ceil(0.4*max(H(:))));

lines = houghlines(BW,T,R,P,'FillGap',15,'MinLength',10);
figure, imshow(frame), hold on

for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2), 'LineWidth',2,'Color','green');
 

end