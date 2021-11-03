function x = deleteNaN(x)

index = 0;
for i = 2:length(x)
    if isnan(x(i,1)) && not(isnan(x(i-1,1)))
        index = i;
    end
end

if index ~= 0
    x = x(1:index-1,:);
end
end