function avgLoc = refineAvgLoc(averageLocation, clumps)
locations = [];
distThresh = 100;
l = 1;

%if averageLocation == [];
%    averageLocation = [20,20];

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
    avgLoc = getAverageLocation(locations);
end