function [J domMM] = findDom(colorIm, camMat, workSpace)
%Returns the location of a domino in mm, given an image containing a
%domino, and the camera calibration matrix for the camera which took the
%image

        %Convert the RGB image to gray scale
        gray = rgb2gray(colorIm);
        %Crop the image to only show the workspace
        gray = imcrop(gray, workSpace);
        %Detect the SURF features in the image
        corners = detectSURFFeatures(gray);
        
        %Find the clumped feature locations
        if (~isempty(corners.Location))
            clumps = getClumps(corners.Location);
            %Find the average location of the clumped feature locations
            if (~isempty(clumps))
            avgLocation = getAverageLocation(clumps);
            %Remove the outling clumps
            avgLocation = refineAvgLoc(avgLocation, clumps);
    
       
            %Insert the average locaiton of the clumps as a green X into the gray
             %scale image
            J = insertMarker(gray,avgLocation,'x', 'color', 'green', 'size', 7);
       

        
            domMM = getDom(camMat, workSpace, avgLocation);
            end
        end
end
