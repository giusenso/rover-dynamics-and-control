function x = deleteDuplicates(x,c)

for i = 1 : length(x)-1
    if x(i,c) == x(i+1,c)
        x(i,:) = NaN;
    end
end

x = sortrows(x);

end