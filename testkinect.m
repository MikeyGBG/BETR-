%% Initialize color video device
tic;
%Get videoinput (vi) object
colorVid = videoinput('kinect', 1, 'RGB_640x480');

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

% There are many ways to plot an image
% 'imshow' tends to be the easiest how ever it is slow
% the following constructs and image object that can
% have its data overwritten directly improving image display
% performance

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
    [1 size(1)],...
    [1 size(2)],...
    zeros(size(2), size(1), 3),...
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
    zeros(size(2), size(1)),...
    'CDataMapping', 'scaled'...
);

% Ensure axis is set to improve display
axis image;

%try

    for i = 1:100
        %Trigger a frame request
        trigger([colorVid depthVid])

        % Get the color frame and metadata.
        [colorIm, colorTime, colorMeta] = getdata(colorVid);
        
        gray = rgb2gray(colorIm);
        gray = uint8(conv2(filly, double(gray)));
        %BW = im2bw(gray, 0.7);
        %BW = uint8(BW(:,:)*255);
        corners = detectMinEigenFeatures(gray);
        centers = imfindcircles(gray, [1,20],'ObjectPolarity','dark');
        clumps = getClumps(corners.Location);
        avgLocation = getAverageLocation(clumps);
        avgLocation = refineAvgLoc(avgLocation, clumps);
       
        J = insertMarker(gray,avgLocation,'x', 'color', 'red', 'size', 10);
        if ~(isempty(centers))
        J = insertMarker(J,centers,'circle', 'color', 'blue', 'size', 10);
        end

        % Get the depth frame and metadata.
        [depthIm, depthTime, depthMeta] = getdata(depthVid);

        % Update data in image display objects
        set(cim, 'cdata', J); %Color
        set(dim, 'cdata', depthIm); %Depth
        
        % Force a draw update
        drawnow;
    end
    
% catch ME
%     fprintf('Error thrown processing frames: %s - %s\n', ME.identifier, ME.message);
% end

%% Cleanup vi devices
delete([colorVid depthVid]);
clear colorVid;
clear depthVid;

toc;