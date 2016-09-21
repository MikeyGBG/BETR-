function averageLocation = getAverageLocation(clumps)

locationSumx = 0;
locationSumy = 0;

    for i = 1:length(clumps)
        try
            locationSumx = locationSumx + clumps(i,1);
            locationSumy = locationSumy + clumps(i,2);
        catch
            continue;
        end
  
    end
    averageLocation(1,1) = locationSumx/length(clumps);
    averageLocation(1,2) = locationSumy/length(clumps);
    if (isnan(averageLocation(1)) && isnan(averageLocation(2)))
        averageLocation(:) = [5,5];
    end

