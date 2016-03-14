%function showimage(original, edgeim, seglist, im, imHeight, imWidth, histw, intervals)
function showimage(thetas, image_info, options)

if nargin <= 2
    options = [];
end

original = image_info.original;
im = image_info.im;
edgeim = image_info.edgeim;
seglist = image_info.seglist{1};
imHeight = image_info.imHeight;
imWidth = image_info.imWidth;
lines = image_info.lines;

figure
imshow(original);

figure('position', [0, 0, imWidth, imHeight]); 
imshow(edgeim);

% Draw the fitted line segments stored in seglist in figure window 3 with
% a linewidth of 2 and random colours
figure('position', [0, 0, imWidth, imHeight]);
drawedgelist(seglist, size(im), 2, [0 0 1]); 
axis off

% Hightlight edges with particular angles
if isfield(options, 'angle_bound')
    figure('position', [0, 0, imWidth, imHeight]);
    angleset = size(options.angle_bound, 1);
    
   
    for k = 1:length(thetas)
        theta = thetas(k);
        linecolor = 'k';
        for j = 1:angleset
            anglelow = options.angle_bound(j, 1);
            anglehigh = options.angle_bound(j, 2);
            if anglelow <= anglehigh
                if theta > anglelow && theta < anglehigh
                    linecolor = options.color(j);
                end            
            else 
                if anglelow < theta || theta < anglehigh
                    linecolor = options.color(j);     
                end
            end
                               
        end

        curline = lines(k, :);
        plot(curline([1 3]), curline([2 4]), '-', 'Color', linecolor, 'linewidth', 2);
        hold on
    end
    
    axis('equal'); 
    axis('ij');
    axis('off');
    camroll(0);
    
end
    
end

