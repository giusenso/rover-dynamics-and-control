toWorkspace(simulation,'N','simout');
N_vec(:,1) = N.Time;
N_vec(:,2:4) = N.Data;
toWorkspace(simulation,'tau_input','simout1');
tau_input_vec(:,1) = tau_input.Time;
tau_input_vec(:,2:4) = tau_input.Data;
toWorkspace(simulation,'acc_input','simout2');
acc_input_vec(:,1) = acc_input.Time;
acc_input_vec(:,2) = acc_input.Data;
toWorkspace(simulation,'vel','vel');
vel_vec(:,1) = vel.Time;
vel_vec(:,2) = vel.Data;
toWorkspace(simulation,'acc','acc');
acc_vec(:,1) = acc.Time;
acc_vec(:,2) = acc.Data;
toWorkspace(simulation,'pos','pos');
pos_vec(:,1) = pos.Time;
pos_vec(:,2) = pos.Data;

v_ref_ts_vec(:,1) = v_ref_ts.Time;
v_ref_ts_vec(:,2) = v_ref_ts.Data;

