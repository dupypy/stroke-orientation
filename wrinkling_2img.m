close all
clear all

% Specify parameter values
image1 = 'images/Square.jpg';
image2 = 'images/Square90.jpg';
minlength1 = 10;
minlength2 = 10;
tol1 = 2;
tol2 = 2;
nbins = 30;
bound = [0 180];
plot_option = ''  % both, none, image1, image2
options.angle_bound = [0 20];  
options.color = ['r'];

[thetas1, lens1, image_info1] = stats(image1, minlength1, tol1);
[thetas2, lens2, image_info2] = stats(image2, minlength2, tol2);
% fix image2 as reference and rotate image1
[histw2, intervals2] = histwc(thetas2, lens2, nbins, bound); 

mindist = inf;
bestangle = 0;
matchhist = [];

for rot_angle = 0:179
    newthetas = rotate(thetas1, rot_angle);
    [histw1, intervals] = histwc(newthetas, lens1, nbins, bound);
    dist = KLDiv(histw1', histw2');
    
    if dist < mindist
        mindist = dist;
        bestangle = rot_angle;
        matchhist = histw1;
    end
end

fprintf('The minimum KL Divergence is %f\n', mindist)
fprintf('The rotated angle is %d\\circ\n', bestangle)

if sctr
showimage(thetas1, image_info1, options);
showhist(intervals, matchhist);
