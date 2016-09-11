function [x,y,z]=rgbd2xyz()
%interpolate depth image to fit dimensions of pixel array (scale it)

%map interpolated depth image to 

pcfromkinect(depthImage,depthDevice); %returns a ptcloud with origin at center of 
