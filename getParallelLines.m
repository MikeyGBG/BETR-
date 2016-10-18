function parallelLines = getParallelLines(lines)

parallelLineNum = 0;
degreeAllowance = 2;

for k = 1:length(lines)
    for j = k+1:length(lines)
        if (lines(k).theta > lines(j).theta -degreeAllowance)&&...
                (lines(k).theta < lines(j).theta + degreeAllowance)
            parallelLineNum = parallelLineNum + 1;
            parallelLines(parallelLineNum,:) = [lines(k), lines(j)];
        end
    end
end

