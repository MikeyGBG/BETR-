function domRelFrame = domRefCF(rotMat, transVec, domMM)
%Returns the position of the domino relative to the central frame
  RPY = tr2rpy(rotMat, 'deg');
        yaw = RPY(3);

         rot = [cosd(yaw) -1*sind(yaw); sind(yaw) cosd(yaw)];

         %Get the x-y location of the domino relative to the frame, in mm,
         %in frame co-ordinates (considering only in plane rotation

         arcDist1 = transVec(1) - domMM(1,1);
         arcDist2 = transVec(2) - domMM(1,2);
 
         domRelFrame(1) = round((arcDist1*rot(1,1))...
              + (arcDist2*rot(1,2)));
          domRelFrame(2) = round((arcDist1*rot(2,1))...
              + (arcDist2*rot(2,2)));
end