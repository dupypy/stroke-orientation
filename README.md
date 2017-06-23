# Analyzing Stroke Orientation in Images

This script is used for determining the dominant orientations of strokes present in an input image. It constructs a histogram showing the amount of strokes in a given orientation. It can also identify if the two input images are taken at different locations on the same sample by comparing the two histograms.

## Requirement

* Matlab (tested on R2014a)

## Features
* Detect strokes and fit the strokes with segments.
* Generate a statistic histogram, with percentage of counts as a function of orientation.
* Highlight orientations with different colors on the line segments image.
* Align two images by rotation and output the rotation angle that yields minimum KL divergence.


## Usage and Examples
### Single image

First prepare an image 

<img src="images/1.jpg" width="40%">

Then Run `wrinkling_1img.m`. The outlines are detected by the Canny edge detection method 

<img src="images/1-edge.png" width="40%">

The script discards contours less than 10 pixels long, and fits the contours with discrete line segments. Below shows the image constructed by the fitted line segments.

<img src="images/1-drawedgelist.png" width="40%">

The script then calculates the length and angle of each segment and generate a histogram showing the amount of segments in a given angle. In this example, the strokes exist in 3 populations: one with an orientation at about 45°, one at about 120°, and the other one at around 0°. **Note: the angle is reported clockwise from the horizontal line.

<img src="images/1-histogram.png" width="43%">

Lastly, an optional image hightlights the strokes with the dominant angles in different colors: red: 30°\~50° , green: 110°\~140°, and blue: 170°\~5°

<img src="images/1-highlight.png" width="40%">


Running `wrinkling_1img.m` without changing parameters yields the default input image and settings. You can change the values for the following parameters:

```Matlab
% Input image file name
image = 'images/1.jpg';

% Minimum edge length of interest (measured in pixels). 
minlength = 10;

% Maximum deviation from straight line before a segment is broken in two (measured in pixels). 
tol = 2;

% Angle of rotation in a clockwise direction. 
rotate_angle = 0;

% Number of bins of the stroke orientation histogram
nbins = 30;

% A 2 elements array. Specify the lower and upper limits of the bin. 
% Default value is [0 180]
bound = [0 180];

% Populations of dominant orientation. Obtained from the histogram, can be as many ranges as needed. 
options.angle_bound = [ 30  50; 
                       110 140; 
                       170   5]; 

% Highlight dominant orientations with different colors. 
% The number of colors should be the same as the number of bounds.
options.color = ['r', 'g', 'b'];

```


### Two images

First prepare two images to align with each other 

<img src="images/Square.jpg" width=215px>
<img src="images/Square90.jpg" height=225px>

Run `wrinkling_2img.m`. The script will execute in the following order:

1. Calculate the histogram2 of image2.
2. Fix image2 as reference and rotate image1 from 0° to 179°.
3. Calculate the histogram1 of image1 at each rotated angle.
4. Compute Kullback-Leibler divergence of histogram2 and histogram1 at each rotated angle.
5. Show the value of **minumum aligned KL divergence** and its corresponding **alignment angle** as output.

#### Output:

```
The alignment angle is 90 degrees
The minimum KL Divergence is 0.001472
```

## File Dependency
- `wrinkling_1img.m`
     * `stats.m`
        * `edgelink.m`
            * `findendsjunctions.m`
        * `lineseg.m`
            * `maxlinedev.m`
     * `rotate.m` (optional)
     * `histwc.m`
     * `showhist.m`
     * `showimage.m`
        * `drawedgelist.m`
- `wrinkling_2img.m`
     * `stats.m`
        * `edgelink.m`
            * `findendsjunctions.m`
        * `lineseg.m`
            * `maxlinedev.m`
     * `histwc.m`
     * `rotate.m`
     * `KLDiv.m`

## References and Credits

* The following m files are from  Prof. Peter Kovesi's website: 
  * `edgelink.m`
  * `findendsjunctions.m`
  * `lineseg.m`
  * `maxlinedev.m`
  * `drawedgelist.m`
  
  Peter Kovesi.  MATLAB and Octave Functions for Computer Vision and Image Processing.
  Available from:
  <http://www.peterkovesi.com/matlabfns/>
* The `histwc.m` is modified from the source code written by Mehmet Suzen 
  <http://goo.gl/j8tAZD>
* The `KLDiv.m` is modified from the source code written by Nima Razavi
  <http://goo.gl/pTa86F>
* Thanks to Yu-Cheng Chen and Han-Yu Hsueh for providing images.
* Specical thanks to Steve Li for his help and constructive discussion.
