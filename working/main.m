%Main script
clf;
%Location of workspace in pixels
workSpace = [370, 300, 895-371, 847-292];  %100, 220, 400, 120

%Delete vid object if it exists
try
    delete(colorVid);
    clear colorVid;
catch
end

%Delete rotMat and transVec if they have a value from last execution
try
    delete(rotMat);
    delete(transVec);
catch
end



%% Initialize color video device
tic;
%Get videoinput (vi) object
colorVid = videoinput('kinect', 1, 'RGB_1280x960');

%Set input settings
colorVid.FramesPerTrigger = 1;  %Only request one frame per trigger call
colorVid.TriggerRepeat = Inf;   %Tell vi object to allow inf trigger calls

%% Set trigger config for vi object
triggerconfig(colorVid, 'manual');


%% Start vi device
start(colorVid);

%% Get and display 200 frames from vi devices

cal = 0;
%prompt to see if camera calibration is neccessary
calib = input('Calibrate Camera?\n0 - no, 1 -yes: ');

if (calib)
    camMat = getIms(colorVid);
end



input('Place Central Frame');

rotMat = [];

%Try and calculate camera relative to central frame
while (1)
     try
        %Trigger a frame request
        trigger(colorVid)
        % Get the color frame RGB values
        colorIm = getdata(colorVid);
        [rotMat, transVec, framePoints] = detectCentralFrame(camMat, colorIm);

     catch
         disp('Central Frame not detected');
         num = num +1;
         if (num < 5)
             continue;
        end
     end
    ext = input('Happy with frame placement?');
     num = 0;
    if (ext)
        if (~isempty(rotMat))
            break
        end
    end
end

%setup the figure for domino location and tracking
cim = initFig(workSpace);

%Prompts user to see if they want to continue 
cont = input('Domino Placed?');
if ~cont
    return
end

%Get 100 frames and procces
happy = 0;
while~(happy)
    for i = 1:100
        %Trigger a frame request
        trigger(colorVid)
        
        % Get the color frame RGB values
        colorIm = getdata(colorVid);
        try
            [J, domMM] = findDom(colorIm, camMat, workSpace);
        catch
        end
        
        %find the dominos position relative to the central frame
        domRelFrame = domRefCF(rotMat, transVec, domMM);
 
         fprintf('Position of domino in central frame is X: %d Y: %d \n',...
             domRelFrame(1), domRelFrame(2)); 

        % Update data in image display objects
        set(cim, 'cdata', J); %Color

        drawnow;
    end
    
    happy = input('Happy?');
 end
    

    input('Start Tracking?');
    
    happy2 = 0;

while ~(happy2)
    for i = 1:100
        %Trigger a frame request
        trigger(colorVid)
        
        % Get the color frame RGB values
        [colorIm, colorTime] = getdata(colorVid);
        try
            [J, domMM] = findDom(colorIm, camMat, workSpace);
        catch
        end

        times(i) = colorTime;
        domLocation(i,1) = domMM(1);
        domLocation(i,2) = domMM(2);
        
        %Find the differnce in location of the domino over the past 5
        %frames
        if (i > 5)
            LocationChange = ((domLocation(i,1) - domLocation(i-5,1))^2 + ...
                (domLocation(i,2) - domLocation(i-5, 2))^2)^.5;
            speed = LocationChange/(times(i)-times(i-5));
            fprintf('Speed of domino in mm/s is %d mm/s \n', round(speed));
        end

        % Update data in image display objects
        set(cim, 'cdata', J); %Color

        drawnow;
    end
    happy2 = input('Happy?');
end
%% Cleanup vi device
delete(colorVid);
clear colorVid;

toc;