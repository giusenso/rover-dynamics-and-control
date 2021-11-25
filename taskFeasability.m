%% Check feasability of the task

fprintf("Check task feasability...\n");
fprintf("[ Wheel 1 ] ");
[feasibility1,unfeasibleMatrix1,T1_vec(:,4)] = checkFeasability(T1_vec,N_vec(:,1:2),tractionCoefficient);
fprintf("[ Wheel 2 ] ");
[feasibility2,unfeasibleMatrix2,T2_vec(:,4)] = checkFeasability(T2_vec,N_vec(:,[1 3]),tractionCoefficient);
fprintf("[ Wheel 3 ] ");
[feasibility3,unfeasibleMatrix3,T3_vec(:,4)] = checkFeasability(T3_vec,N_vec(:,[1 4]),tractionCoefficient);