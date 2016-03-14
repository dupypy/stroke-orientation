function newthetas = rotate(thetas, rotate_angle)

newthetas = mod(thetas - rotate_angle, 180);
end