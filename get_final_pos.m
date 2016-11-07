function [newVal, newPos] = get_final_pos(values, pos)
    MAX = length(values - 1);
    % loop over values
    for i = 1: MAX    % iterate upto the second last number
       for j = 1: MAX - i; 
           num1 = getNum(values(j,:));
           num2 = getNum(values(j+1,:));
        if (num1 > num2)
            temp = values(j,:);
            tempPos = pos(j,:);
            values(j,:) = values(j+1,:);
            pos(j,:) = pos(j+1,:);
            values(j+1,:) = temp;
            pos(j+1,:) = tempPos;
        end
       end
    end
    newVal = values;
    newPos = pos;
    disp(newVal)
    disp(newPos)
end
        
    % ascending/descending sort values array and update pos newPos
    % now our values are sorted and newPos is corresponding them 
    % return 
   
    % simplest form of node transversal, we dont need a* or algorith,
    % passing should be valid for final pos 
      % grab the sorting num (3,2) use 3 | (1,2) then use 2 instead  
        %disp('*')
        %disp(values(i,:))
        %disp('*')
        %if (values(i,1) > values(i, 2))
        %    num = values(i,1);
        %else 
        %    num = values(i, 2);
        %end 