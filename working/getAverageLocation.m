function averageLocation = getAverageLocation(clumps)
%Finds the average location of all the clumps in the scene

locationSumx = 0;
locationSumy = 0;

    for i = 1:length(clumps)
        try
            %Add the x and y distances between every clump
            locationSumx = locationSumx + clumps(i,1);
            locationSumy = locationSumy + clumps(i,2);
        catch
            continue;
        end
  
    end
    %Find the average clump location
    averageLocation(1,1) = locationSumx/length(clumps);
    averageLocation(1,2) = locationSumy/length(clumps);
    %Return position of [5,5] if clumps list is empty
    if (isnan(averageLocation(1)) && isnan(averageLocation(2)))
        averageLocation(:) = [5,5];
    end

