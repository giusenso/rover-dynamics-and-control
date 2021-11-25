function [feasibility,unfeasibleMatrix,T] = checkFeasability(T_vec,N,mu)

for i = 1 : length(T_vec)
    T(i) = sqrt(T_vec(i,2)^2+T_vec(i,3)^2);
end

for i = 1:length(T)
    if N(i,2) < abs(T(i))/mu
        minMu = abs(T(i)) * (1/N(i,2))  % Min mu allowed
        if mu < minMu && mu~= 0
        unfeasibleMatrix(i,1) = abs(T(i));
        unfeasibleMatrix(i,2) = N(i,2);
        unfeasibleMatrix(i,3) = minMu;  % Min mu allowed
        end
    else
        unfeasibleMatrix(i,1) = NaN;
        unfeasibleMatrix(i,2) = NaN;
        unfeasibleMatrix(i,3) = NaN;
    end
end

index = find(and(not(isnan(unfeasibleMatrix(:,1))),and(unfeasibleMatrix(:,1) ~= 0,unfeasibleMatrix(:,1) == mu)),1,'first');

if isempty(index)
    fprintf("Feasible task: no slip detected\n");
    feasibility = 1;
else
    fprintf("Unfeasible task: slip detected\n");
    feasibility = 0;
end

T = T';

end