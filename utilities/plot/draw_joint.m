function draw_joint(x,y)
joint_rad = 0.05;
rectangle('Position', [x-joint_rad,y-joint_rad, 2*joint_rad,2*joint_rad], 'Curvature',[1 1], 'Linewidth', 0.8)
end