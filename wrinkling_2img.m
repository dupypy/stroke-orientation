close all
clear all

image1 = 'images/Square.jpg';
image2 = 'images/Square90.jpg';

[thetas1, lens1, image_info1] = stats(image1);
[thetas2, lens2, image_info2] = stats(image2);
% fix image2 as reference and rotate image1
[histw2, intervals2] = histwc(thetas2, lens2, 30, [0 180]); 

mindist = inf;
bestangle = 0;
matchhist = [];

for rot_angle = 0:179
    newthetas = rotate(thetas1, rot_angle);
    [histw1, intervals] = histwc(newthetas, lens1, 30, [0 180]);
    dist = KLDiv(histw1', histw2');
    
    if dist < mindist
        mindist = dist;
        bestangle = rot_angle;
        matchhist = histw1;
    end
end

mindist
bestangle

options.angle_bound = [0 20];
options.color = ['r'];
showimage(thetas1, image_info1, options);
showhist(intervals, matchhist);
