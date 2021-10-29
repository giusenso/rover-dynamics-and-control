x = [2   2     5      6     7     8     9     10]';

logicMap = x<5;
firstLowerIndex = find(x<=5.1,1,'last')
firstGreaterIndex = find(x>5.1,1,'first')
%find(x==targetval, num_wanted, 'first')
