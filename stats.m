function [thetas, lens, image_info] = stats(filename, minlength, tol)

original = imread(filename);
im = rgb2gray(original);
[imHeight, imWidth] = size(im);

% Find edges using the Canny operator with hysteresis thresholds of 0.1
% and 0.2 with smoothing parameter sigma set to 1.
edgeim = edge(im,'canny');




% Link edge pixels together into lists of sequential edge points, one
% list for each edge contour. A contour/edgelist starts/stops at an
% ending or a junction with another contour/edgelist.
% Here we discard contours less than 10 pixels long.
[edgelist] = edgelink(edgeim, minlength);

% Display the edgelists with random colours for each distinct edge
% in figure 2

%drawedgelist(edgelist, size(im), 1, 'rand', 2); axis off

% Fit line segments to the edgelists
% Line segments are fitted with maximum deviation from
     
seglist = lineseg(edgelist, tol);





%% Analyze lines

thetas = [];
lens = [];
lines = [];

for k = 1:length(seglist)
    A = seglist{k};
    
    for m = 2:size(A,1)
        x1 = A(m-1, 2);
        y1 = A(m-1, 1);
        x2 = A(m, 2);
        y2 = A(m, 1);
        dx = x2 - x1;
        dy = y2 - y1;
        if dy < 0
            dx = -dx;
            dy = -dy;
        end
        len = sqrt(dx^2 + dy^2);
        theta = acos(dx / len) * 180 / pi;         
        thetas = [thetas, theta];
        lens = [lens, len];
        lines = [lines; x1, y1, x2, y2];
    end
    
end

thetas = mod(thetas, 180);   % merge 180 and 0

image_info.original = original;
image_info.im = im;
image_info.edgeim = edgeim;
image_info.seglist = {seglist};
image_info.imHeight = imHeight;
image_info.imWidth = imWidth;
image_info.lines = lines;



end


