function locations = getClumps(featureLocations)
%Returns the x and y co ordinates of features which have enough
%neighbouring features within a distance threshold to define a clump

    dist = 10;          %Straight line distance threshold
    nAmount = 2;        %Number of neighbouring features needed for a clump
    neighbours = 0;
    locations = [];
    lNum = 1;   
    
    %Find the distance between one feature and every other
    for i = 1:(length(featureLocations))
        currentLoc = featureLocations(i, :);
        neighbours = 0;
        for j = 1:(length(featureLocations))
            if ( i ~= j)
                compLoc = featureLocations(j, :);
                if (sqrt((currentLoc(1) - compLoc(1))^2 + ...
                        (currentLoc(2) - compLoc(2))^2) < dist)
                    neighbours = neighbours + 1;
                end
                %Once the required number of neighbours to define a clump,
                %is reached, stop processing the feature
                if (neighbours > nAmount) 
                    break;
                end
            end       
        end
        %IF a feature has enough neighbours add its location to the list of
        %clumps
        if (neighbours >= nAmount)
            locations(lNum, :) = currentLoc;
            lNum = lNum + 1;
        end
    end
end
        