function cameraParams = camCal(baseName)
%Returns the camera calibration matrix from the baseName of image files
%containing a checkerboard pattern.

    %specify the number of images used for calibration, and read them from file
    numImages = 20;
    files = cell(1, numImages);
    for i = 1:numImages
        num = sprintf('%d', i);
        files{i} = fullfile(strcat(baseName, num, '.png'));
    end

    % Detect the checkerboard corners in the images.
    [imagePoints, boardSize] = detectCheckerboardPoints(files);

    % Generate the world coordinates of the checkerboard corners in the
    % pattern-centric coordinate system, with the upper-left corner at (0,0)

    squareSize = 28; % in millimeters
    worldPoints = generateCheckerboardPoints(boardSize, squareSize);

    % Try to obtain the camera paramaters from the given worldPoints of the
    % checkerboard corners and the corresponding image points in the image 
    % plane.
    try
        cameraParams = estimateCameraParameters(imagePoints, worldPoints);

        % Evaluate calibration accuracy.
        figure; showReprojectionErrors(cameraParams);
        title('Reprojection Errors');
        figure, imshow(files{1});
        hold on
        plot(imagePoints(:,1,1), imagePoints(:,2,1),'go');
        plot(cameraParams.ReprojectedPoints(:,1,1),cameraParams.ReprojectedPoints(:,2,1), 'r+');
        hold off;
    
    catch 
        disp('Calibration Error!');
        cameraParams = [];
    end
end