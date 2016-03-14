close all
clear all

% Specify parameter values
image = 'images/1.jpg';
minlength = 10;
tol = 2;
rotate_angle = 0;
nbins = 30;
bound = [0 180];
options.angle_bound = [30 50; 110 140; 170 5];  
options.color = ['r', 'g', 'b'];

% Analyze images
[thetas, lens, image_info] = stats(image, minlength, tol);
newthetas = rotate(thetas, rotate_angle);
[histw, intervals] = histwc(newthetas, lens, nbins, bound); 

% Show histogram and overlay plots 
showhist(intervals, histw);
showimage(thetas, image_info, options);
