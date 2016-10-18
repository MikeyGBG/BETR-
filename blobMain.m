try
    delete(colorVid)
    clear colorVid
catch
end
 
colorVid = videoinput('kinect', 1, 'RGB_1280x960');
colorVid.FramesPerTrigger = 1;
colorVid.TriggerRepeat = Inf;
triggerconfig(colorVid, 'manual');

start(colorVid);

cim = image(...
    [1 1280],...
    [1 960],...
    zeros(960, 1280, 3),...
    'CDataMapping', 'scaled'...
    );


for i = 1:200

    trigger(colorVid)
    colorIm = getdata(colorVid);
    %pre-processing
    gray = rgb2gray(colorIm);
    BW = edge(gray, 'canny', 0.2);
    cleanBW = bwmorph(BW, 'clean');
    bridgeBW = bwmorph(cleanBW, 'bridge');
    thickBW = bwmorph(bridgeBW, 'thicken');
    filteredBW = bwareaopen(thickBW, 450);
    closedBW = imfill(filteredBW, 'holes');
    %blob detection using threshold area
    dominoInImage = getDominoInImage(closedBW, colorIm);
    set(cim, 'cdata', dominoInImage);
    
end

delete(colorVid)
clear colorVid

