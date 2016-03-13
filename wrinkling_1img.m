close all
clear all

image = 'images/1.jpg';
[thetas, lens, image_info] = stats(image);
newthetas = rotate(thetas, 0);
[histw, intervals] = histwc(newthetas, lens, 30, [0 180]); 

showhist(intervals, histw);

% specify bounds to highlight from the original histogram
options.angle_bound = [30 50; 110 140; 170 5];  
options.color = ['r', 'g', 'b'];
showimage(thetas, image_info, options);
