function cameraParams = camCal(baseName)
    %specify the number of images and read them from file
    numImages = 20;
    files = cell(1, numImages);
    for i = 1:numImages
        num = sprintf('%d', i);
        files{i} = fullfile(strcat(baseName, num, '.png'));
    end


    % Detect the checkerboard corners in the images.
    [imagePoints, boardSize] = detectCheckerboardPoints(files);

    % Generate the world coordinates of the checkerboard corners in the
    % pattern-centric coordinate system, with the upper-left corner at (0,0).
    squareSize = 22; % in millimeters
    worldPoints = generateCheckerboardPoints(boardSize, squareSize);

    % Try to calibrate the camera.
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
        disp('Calibration ERRROR!!');
        cameraParams = [];
    end

end