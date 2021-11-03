function draw_axis(x,y,angle)
l = 0.20;
line([x, x+l*cos(angle)], [y, y+l*sin(angle)], 'Color','red', 'Linewidth', 1)
line([x, x+l*cos(angle+pi/2)], [y, y+l*sin(angle+pi/2)], 'Color','red', 'Linewidth', 1)
end