function cim = initFig(workSpace)
%contruct a figure
 figure('Position', [100, 0, 600, 1000]);

% Construct Color image subplot
subplot(2, 1, 1);

% Setup plot
set(gca,'units','pixels');
set(gca,'xlim',[0 255]);
set(gca,'ylim',[0 255]);

% Construct image display object
cim = image(...
    [1 workSpace(3)],...
    [1 workSpace(4)],...
    zeros(workSpace(4), workSpace(3), 3),...
    'CDataMapping', 'scaled'...
);

% Ensure axis is set to improve display
axis image;