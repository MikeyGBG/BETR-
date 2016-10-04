%Main script

%Location of workspace in pixels
workSpace = [336, 345, 908-336, 863-345];  %100, 220, 400, 120

try
    delete([colorVid depthVid]);
    clear colorVid;
    clear depthVid;
catch
end


%% Initialize color video device
tic;
%Get videoinput (vi) object
colorVid = videoinput('kinect', 1, 'RGB_1280x960');

%Set input settings
colorVid.FramesPerTrigger = 1;  %Only request one frame per trigger call
colorVid.TriggerRepeat = Inf;   %Tell vi object to allow inf trigger calls


%% Initialize color video device
depthVid = videoinput('kinect', 2, 'Depth_640x480');

%Set input settings
depthVid.FramesPerTrigger = 1;  %Only request one frame per trigger call
depthVid.TriggerRepeat = Inf;   %Tell vi object to allow inf trigger calls


%% Set trigger config for vi objects
triggerconfig([colorVid depthVid], 'manual');


%% Start vi devices
start([colorVid depthVid]);

%% Get and display 200 frames from vi devices
figure('Position', [100, 100, 600, 1000]);

% Construct Color image subplot
subplot(2, 1, 1);

% Setup plot
set(gca,'units','pixels');
set(gca,'xlim',[0 255]);
set(gca,'ylim',[0 255]);

% Aquire size of video image format
size = colorVid.VideoResolution;

% Construct image display object
cim = image(...
    [1 workSpace(3)],...
    [1 workSpace(4)],...
    zeros(workSpace(4), workSpace(3), 3),...
    'CDataMapping', 'scaled'...
);

% Ensure axis is set to improve display
axis image;

% Construct Depth image subplot
subplot(2, 1, 2);



% Setup plot
set(gca,'units','pixels');
set(gca,'xlim',[0 255]);
set(gca,'ylim',[0 255]);

% Aquire size of video image format
size = depthVid.VideoResolution;

% Construct image display object
% Remember depth image is single channel where color is 3 channels
dim = image(...
    [1 size(1)],...
    [1 size(2)],...
    zeros(size(2), size(1), 3),...
    'CDataMapping', 'scaled'...
);

% Ensure axis is set to improve display
axis image;

%prompt to see if camera calibration is neccessary
calib = input('Calibrate Camera?\n0 - no, 1 -yes: ');
if calib
    camMat = getIms(colorVid);
end

%Prompts user to see if they want to continue 
cont = input('continue?');
if ~cont
    return
end

%Get 100 frames and procces
    for i = 1:100
        %Trigger a frame request
        trigger([colorVid depthVid])

        % Get the color frame and metadata.
        [colorIm, colorTime, colorMeta] = getdata(colorVid);

        
        
        N = 8;
        %CREATE LPF
        filly = ones(N)/(N^2);

        %Convert the RGB image to gray scale
        gray = rgb2gray(colorIm);
        %Crop the image to only show the workspace
        gray = imcrop(gray, workSpace);
        %Detect the SURF features in the image
        corners = detectSURFFeatures(gray);
        
        %Find the clumped feature locations
        clumps = getClumps(corners.Location);
        %Find the average location of the clumped feature locations
        avgLocation = getAverageLocation(clumps);
        %Remove the outling clumps
        avgLocation = refineAvgLoc(avgLocation, clumps);
        
        %Crop the image around the average location (Should contain a
        %domino)
        valueImage = imcrop(gray, [avgLocation(1) - 55, avgLocation(2) - 55, 110, 110]);
        
        %Convert the domino image to BW
        BW = im2bw(valueImage, 0.6);
            
        %Find the circles in the BW image
         centers = imfindcircles(BW, [1,10], 'ObjectPolarity', 'Dark', 'Sensitivity', 0.8);
        
       
       %Insert the average locaiton of the clumps as a red X into the gray
       %scale image
       J = insertMarker(gray,avgLocation,'x', 'color', 'red', 'size', 3);
       %Plot the circles on the domino image and grayscale image
       if ~(isempty(centers))
            valueImage = insertMarker(valueImage,centers, 'circle', 'color', 'green', 'size', 3);
            centers(:,1) = centers(:,1) + avgLocation(1) - 55;
            centers(:,2) = centers(:,2) + avgLocation(2) - 55;
            J = insertMarker(J,centers, 'circle', 'color', 'green', 'size', 3);

       end
       %Plot the clumps on the gray scale image (NOTE: includes outliers)
       if ~(isempty(clumps))
        for i = 1:length(clumps(:, 1))
            J = insertMarker(J, clumps(i, :), '+', 'color', 'red', 'size', 3);
        end
       end
       disp('Position (XYZ) IS');[avgLocation(2)*1.12, 0, avgLocation(1)*1.12]
     
        % Get the depth frame and metadata.
        [depthIm, depthTime, depthMeta] = getdata(depthVid);

        % Update data in image display objects
        set(cim, 'cdata', J); %Color
        set(dim, 'cdata', valueImage); %Depth
        
        % Force a draw update
        drawnow;
    end
%% Cleanup vi devices
delete([colorVid depthVid]);
clear colorVid;
clear depthVid;

toc;