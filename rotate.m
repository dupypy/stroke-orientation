function newthetas = rotate(thetas, angle)

newthetas = mod(thetas - angle, 180);
end