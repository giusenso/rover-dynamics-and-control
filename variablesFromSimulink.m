toWorkspace(simulation,'N','normal_forces');
N_vec(:,1) = N.Time;
N_vec(:,2:4) = N.Data;
toWorkspace(simulation,'u_input','control_effort');
u_input_vec(:,1) = u_input.Time;
u_input_vec(:,2) = u_input.Data;
toWorkspace(simulation,'T','traction_effort');
T1_vec(:,1) = T.Time;
T2_vec(:,1) = T.Time;
T3_vec(:,1) = T.Time;
T1_vec(:,2) = T.Data(:,1);
T1_vec(:,3) = T.Data(:,4);
T2_vec(:,2) = T.Data(:,2);
T2_vec(:,3) = T.Data(:,5);
T3_vec(:,2) = T.Data(:,3);
T3_vec(:,3) = T.Data(:,6);

for i = 1 : length(T1_vec)
    T1_vec(i,4) = sqrt(T1_vec(i,2)^2+T1_vec(i,3)^2);
end

for i = 1 : length(T2_vec)
    T2_vec(i,4) = sqrt(T2_vec(i,2)^2+T2_vec(i,3)^2);
end

for i = 1 : length(T3_vec)
    T3_vec(i,4) = sqrt(T3_vec(i,2)^2+T3_vec(i,3)^2);
end

toWorkspace(simulation,'vel_x','vel_x');
vel_x_vec(:,1) = vel_x.Time;
vel_x_vec(:,2) = vel_x.Data;
toWorkspace(simulation,'vel_z','vel_z');
vel_z_vec(:,1) = vel_z.Time;
vel_z_vec(:,2) = vel_z.Data;
toWorkspace(simulation,'pos_x','pos_x');
pos_x_vec(:,1) = pos_x.Time;
pos_x_vec(:,2) = pos_x.Data;
toWorkspace(simulation,'pos_z','pos_z');
pos_z_vec(:,1) = pos_z.Time;
pos_z_vec(:,2) = pos_z.Data;
toWorkspace(simulation,'vel_error_x','vel_err_x');
vel_error_x_vec(:,1) = vel_error_x.Time;
vel_error_x_vec(:,2) = vel_error_x.Data;
toWorkspace(simulation,'vel_error_z','vel_err_z');
vel_error_z_vec(:,1) = vel_error_z.Time;
vel_error_z_vec(:,2) = vel_error_z.Data;
toWorkspace(simulation,'pos_error_x','pos_err_x');
pos_error_x_vec(:,1) = pos_error_x.Time;
pos_error_x_vec(:,2) = pos_error_x.Data;
toWorkspace(simulation,'pos_error_z','pos_err_z');
pos_error_z_vec(:,1) = pos_error_z.Time;
pos_error_z_vec(:,2) = pos_error_z.Data;

v_ref_ts_vec(:,1) = v_ref_ts.Time;
v_ref_ts_vec(:,2:3) = v_ref_ts.Data(:,1:2);

pos_ref_ts_vec(:,1) = rocker_ts.Time;
pos_ref_ts_vec(:,2:3) = rocker_ts.Data(:,1:2);
