function avgLoc = refineAvgLoc(averageLocation, clumps)
%Removes the outliers from the clumps which are further from the average
%location by the distance threshold
locations = [];
distThresh = 100;   %Distance threshold
l = 1;
    
%Find the distance from clump to average location, adding the clump to the
%locations list if it is within the distancer threshold away
    for i = 1:length(clumps)
        try
            if ~(sqrt(((clumps(i,1) - averageLocation(1))^2 + (clumps(i, 2) - averageLocation(2))^2)) > distThresh)
                locations(l, :) = clumps(i, :);
                l = l + 1;
            end
        catch
            continue;
        end
    
    end
    %Find the new average location of the clumps after the outliers have
    %been removed
    avgLoc = getAverageLocation(locations);
end
