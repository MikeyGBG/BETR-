function [rot, trans, imagePoints] = detectCentralFrame(camMat, colorIm)
%Processes extrinsics returned by getExtrinsics to eliminate anomlies (ie,
%anaomolous transformation results from out of plane rotation)

[rot, trans, imagePoints] = getExtrinsics(camMat, colorIm);
RPY = tr2rpy(rot, 'deg');
yaw = RPY(3);
%Consider only in plane rotation
rot = [cosd(yaw) -1*sind(yaw) 0; sind(yaw) cosd(yaw) 0; 0 0 1];
transf(1) = trans(1)*rot(1,1)+ trans(2)*rot(1,2) + trans(3)*rot(1,3);
transf(2) = trans(1)*rot(2,1)+ trans(2)*rot(2,2) + trans(3)*rot(2,3);
%The height of the camera, z, is fixed, so z' is fixed (out of plane rotations
%neglected)
transf(3) = 600;

message = sprintf('X: %d\tY: %d\t Z: %d\n', round(transf(1)), round(transf(2)), round(transf(3)));
message2 = sprintf('ROLL: %d\tPITCH: %d\tYAW: %d\n', round(RPY(1)), ...
    round(RPY(2)), round(sign(RPY(3))*(abs(180-abs(RPY(3))))));
disp(message2);
disp(message);
end
