function locations = getClumps(featureLocations)
    dist = 10;
    nAmount = 2;
    neighbours = 0;
    locations = [];
    lNum = 1;
    for i = 1:(length(featureLocations))
        currentLoc = featureLocations(i, :);
        neighbours = 0;
        for j = 1:(length(featureLocations))
            if ( i ~= j)
                compLoc = featureLocations(j, :);
                if (sqrt((currentLoc(1) - compLoc(1))^2 + (currentLoc(2) - compLoc(2))^2) < dist)
                    neighbours = neighbours + 1;
                end
                if (neighbours > nAmount) 
                    break;
                end
            end
        
        
        end
        if (neighbours >= nAmount)
            locations(lNum, :) = currentLoc;
            lNum = lNum + 1;
    end
        
end