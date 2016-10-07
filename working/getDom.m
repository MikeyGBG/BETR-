function domMM = getDom(camMat, workSpace, avgLocation)
 principalPoint(1,1) = camMat.PrincipalPoint(1,1) - workSpace(1,1);
        principalPoint(1,2) = camMat.PrincipalPoint(1,2) - workSpace(1,2);
        domPos(1,1) = avgLocation(1,1) - principalPoint(1,1);
        domPos(1,2) = avgLocation(1,2) - principalPoint(1,2);
        domMM = domPos / 1.724;

        
end