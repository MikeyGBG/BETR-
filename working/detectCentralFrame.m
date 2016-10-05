function [rot, trans, imagePoints] = detectCentralFrame(camMat, colorIm)
[rot, trans, imagePoints] = getExtrinsics(camMat, colorIm);
 RPY = tr2rpy(rot, 'deg');
 transf(1) = trans(1)*rot(1,1)+ trans(2)*rot(1,2) + trans(3)*rot(1,3);
 transf(2) = trans(1)*rot(2,1)+ trans(2)*rot(2,2) + trans(3)*rot(2,3);
 transf(3) = trans(1)*rot(3,1)+ trans(2)*rot(3,2) + trans(3)*rot(3,3);
 message = sprintf('X: %d\tY: %d\t Z: %d\n', round(transf(1)), round(transf(2)), round(transf(3)));
 message2 = sprintf('ROLL: %d\tPITCH: %d\tYAW: %d\n', round(RPY(1)), round(RPY(2)), round(RPY(3)));
 disp(message2);
 disp(message);
end