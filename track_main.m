function track_main (x_min, y_min, height, width) 
% uses the x and y co-ordinates of the dominoes
% uses the pixel horizontal and vertical heights

%% Load In Images
imagefiles = dir('data/*.png');      
nfiles = length(imagefiles);    % Number of files found
images = cell(1, nfiles);

for ii=1:nfiles
   currentfilename = fullfile('data', imagefiles(ii).name);
   currentimage = imread(currentfilename);
   images{ii} = im2double(currentimage);
end
%% Get and display 200 frames from vi devices
figure('Position', [100, 100, 1000, 700]);

% There are many ways to plot an image
% 'imshow' tends to be the easiest how ever it is slow
% the following constructs an image object that can
% have its data overwritten directly improving image display
% performance

% Setup plot
set(gca,'units','pixels');
% Aquire size of video image format
sz = size(images{1});

% Construct image display object
cim = image(...
    [1 sz(2)],...
    [1 sz(1)],...
    zeros(sz(1), sz(2), 1),...
    'CDataMapping', 'scaled'...
);

% Ensure axis is set to improve display
colormap gray;
axis image;

%% Setup tracking
im = imgaussfilt(images{1}, 4);

% Update data in image display objects
set(cim, 'cdata', images{1});
drawnow;

% uses the info from the other file to track the dominos
template_rect(1) = x_min;
template_rect(2) = y_min;
template_rect(3) = height;
template_rect(4) = width;

% for the backup plan
%template_rect = round(getrect())

template = im(...
    template_rect(2):(template_rect(2) + template_rect(4)), ...
    template_rect(1):(template_rect(1) + template_rect(3)) ...
    );
%Initialise Result from first frame
[result, it, res] = track_template(im, template, [template_rect(1); template_rect(2)]);
fprintf('Initialised track location to X: %g, Y: %g, it: %i, r: %g\n', result(1), result(2), it, res);

%% Begin tracking
result_handle = 0;
for i = 2:nfiles

    % Get the frame and metadata.
    im = imgaussfilt(images{i}, 4);

    if result_handle ~= 0
        delete(result_handle);
    end

    % Update data in image display objects
    set(cim, 'cdata', images{i});
    disp('before')
    [new_result, it, res] = track_template(im, template, result);
    disp('after')
    
    % Output tracking results
    if isnan(res)
        fprintf('Lost tracking... initialising with previous result');
    else
        fprintf('Tracked template to X: %g, Y: %g, it: %i, r: %g\n', result(1), result(2), it, res);
    end

    % Update if result is ok
    if ~any(isnan(new_result))
        result=new_result;
    end

    % Draw result position on image
    hold on; 
    result_handle = scatter(result(1), result(2));
    hold off;

    % Force a draw update
    drawnow;
end
