function locations = getClumps(featureLocations, rect)
%Returns the x and y co ordinates of features which are within a certain
%Distance thrershold
    dist = 10;          %Distance threshold
    nAmount = 2;        %Number of neighbours needed for a clump
    neighbours = 0;
    locations = [];
    lNum = 1;   
    
    %Find the distance between one feature and every other
    for i = 1:(length(featureLocations))
        currentLoc = featureLocations(i, :);
        %if the feature is not in the rectangle
         if (currentLoc(1,1) > rect(1,1))
             if (currentLoc(1,2) > rect(1,2))  
                 if (currentLoc(1,1) < rect(1,3))
                     if (currentLoc(1,2) < rect(1,4))
                         %disp('ur dads ur mum');
                      continue;
                     end
                 end
            end
         end
        neighbours = 0;
        for j = 1:(length(featureLocations))
            if ( i ~= j)
                compLoc = featureLocations(j, :);
                if (sqrt((currentLoc(1) - compLoc(1))^2 + (currentLoc(2) - compLoc(2))^2) < dist)
                    neighbours = neighbours + 1;
                end
                %Once the number of neighbours is reached stop processing
                %the clump
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
        