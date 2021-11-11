toWorkspace(simulation,'N','normal_forces');
N_vec(:,1) = N.Time;
N_vec(:,2:4) = N.Data;
toWorkspace(simulation,'u_input','control_effort');
u_input_vec(:,1) = u_input.Time;
u_input_vec(:,2:4) = u_input.Data;
toWorkspace(simulation,'vel','vel');
vel_vec(:,1) = vel.Time;
vel_vec(:,2) = vel.Data;
toWorkspace(simulation,'acc','acc');
acc_vec(:,1) = acc.Time;
acc_vec(:,2) = acc.Data;
toWorkspace(simulation,'pos','pos');
pos_vec(:,1) = pos.Time;
pos_vec(:,2) = pos.Data;
toWorkspace(simulation,'vel_error','vel_err');
vel_error_vec(:,1) = vel_error.Time;
vel_error_vec(:,2) = vel_error.Data;

v_ref_ts_vec(:,1) = v_ref_ts.Time;
v_ref_ts_vec(:,2) = v_ref_ts.Data;

