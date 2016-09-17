vid = videoinput('kinect', 1, 'RGB_1280x960');
src = getselectedsource(vid);

vid.FramesPerTrigger = Inf;
se = strel('line', 2, 0);

N = 8;
%CREATE LPF
filly = ones(N)/(N^2);

while(1)


%GET IMAGE
frame = getsnapshot(vid);
image(frame);

%image(frame);
%im = rgb2hsv(frame);

%imshow(im);

gray = rgb2gray(frame);


%CONVERT IMAGE FROM RGB TO GRAYSCALE
%gray = rgb2gray(frame);


%SET SIZE OF LPF

%APPLY LPF
blur = uint8(conv2(double(gray), filly));
%REMOVE CONVOLUTION ARTEFACTS
%cropped = imcrop(blur, [N, N,(length(blur(:, 1)) - 7*N), (length(blur(1,:)) - 2*N)]);
%figure, imshow(cropped);

blur = imcrop(blur, [N, N,(length(blur(:, 1)) - 7*N), (length(blur(1,:)) - 55*N)]); 
%figure, imshow(blur);



%HIGHBOOST FILTER 3x3
%filly = [0.1,0.1,0.1;0.1,1,0.1;0.1,0.1,0.1];
%blur = uint8(conv2(double(cropped), filly));
%
%blur = imcrop(blur, [3, 3,(length(blur(:, 1)) -50), (length(blur(1,:)) - 6)]);

%figure, imshow(blur);

%BW = im2bw(blur, 0.5);


%FIND EDGES USING CANNY EDGE DETECTOR(IS BEST EDGE DETECTOR)
BW = edge(blur, 'canny');
%DISPLAY EDGED IMAGE
%figure, imshow(BW);

BW = bwareaopen(BW, 200);


%figure, imshow(BW);

%BW = edge(BW, 'canny'); %COMMENTED OUT
%imshow(BW);

%HOUGH TRANSFORM IMAGE
[H, T, R] = hough(BW);  %LOOK INTO HOUGH CIRCLES
%FIND 2 HIGHEST PEAKS OF HOUGH TRANSFORM (CORRESPONDS TO 2 LONGEST LINES)
P = houghpeaks(H,6 ,'threshold',ceil(0.4*max(H(:))));
%GET LINES FROM HOUGH TRANSFORM
lines = houghlines(BW,T,R,P,'FillGap',80,'MinLength',5);

%OVERLAY LINES ON ORIGINAL IMAGE
figure, imshow(blur), hold on
rows = length(blur(:,1));
columns = length(blur(1, :));

 for k = 1:length(lines)
 	xy = [lines(k).point1; lines(k).point2];
 	% Get the equation of the line
 	x1 = xy(1,1);
 	y1 = xy(1,2);
 	x2 = xy(2,1);
 	y2 = xy(2,2);
	slope = (y2-y1)/(x2-x1);
    c = y2 - (slope*x2);
    lineEquations(k,1) = slope;
    lineEquations(k,2) = c;
    disp('eq ')
    disp(lineEquations(k,:));
 	%xLeft = 1; % x is on the left edge
 	%yLeft = slope * (xLeft - x1) + y1;
 	%xRight = columns; % x is on the reight edge.
 	%yRight = slope * (xRight - x1) + y1;
 	%plot([xLeft, xRight], [yLeft, yRight], 'LineWidth',2,'Color','green');	
 	
 	% Plot original points on the lines .
 	%plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow'); 
 	%plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');	
 end
    for (j = 1: lineEquations(end))
        syms x;
        syms y;
        eq1 =  lineEquations(j,1)*x + lineEquations(j,2);
        for (k = 1 : lineEquations(end))
            eq2 = lineEquations(j,1)*x + lineEquations(j,2);
            soln = solve([eq1,eq2],x);
            disp('Intersection')
            disp(soln)    
        end
    end
 stop = input('STOP?');
 if (stop) 
     break;
 end
    
end
delete(vid);
clear vid;
%% computing the intersections
% for every line in the loop
% calculate the intersection
% calculate the angle
% do it for 4 angles and form the imaeg

