# Cone-Sphere Intersection on CMB

According to inflation theory, the speed of propagation of quantum fluctuations in the early universe is not necessarily equals
to the speed of light. This makes it sounds sensible to think
of cherenkov effect, massless particles may have intersected the horizon and made
cones due to the speed of propagation of quantum fluctuations
(hereinafter called Cs) and the cherenkov effect as a result.
Cosmic Microwave Background (CMB) remaining from the era when the universe was young, could
be used as a snapshot of the whole universe which involves
these traces.However CMB is too dense to look forward special
shapes on it without the help of machine learning’s methods.On
the first step of this project we are going to portrait the general
shapes of the traces on the CMB, and find a proper method of
simulating them in order to be used in further training.

## Data
### CMB Data
We use HEALPix to work with CMB data.The Hierarchical Equal Area iso-Latitude Pixelization, or
[HEALPix](https://iopscience.iop.org/article/10.1086/427976/pdf) in short, is a versatile data structure with an associated library of computational algorithms which was first
developed to address the data processing and analysis needs of
the present generation of cosmic microwave background experiments.
* [CMB data](https://drive.google.com/drive/folders/1R_WOCLi3S2RIhC0V55duOmJIvfaydLs3?usp=sharing) - The CMB data from HEALPix
* [use CMB data](Data/CMB_data.ipynb) - used to work with CMB data 

### Cone-Sphere Intersection Data
We portrait the general shapes of the traces on the CMB, and find a proper method of
simulating them in order to be used in further training.
Simulation is used for generating intersection curves’
data with the same format as the CMB data.
Intersection matrixs are Nθ × Nφ matrix that the nonzero elements’ position stand for intersection’s {θ, φ}, they saved as black and white images.
And the cones parameters($`θ_{Cs}`$, $`\vec{r_0} = x_0\hat{x} + y_0\hat{y} + z_0\hat{z}`$, $`\vec{n} = n_x\hat{x} + n_y\hat{y} + n_z\hat{z}`$) are in labels data frame.  
* [simulation data](https://drive.google.com/drive/folders/1SMUGfrpntOBXg3y3lDTwlyd7YEId2fL3?usp=sharing) - The cone-sphere intersection data 
* [data generator](Data/Cone_sphere_intersection_curve_simulation.ipynb) - used to generates simulation data 

## Basic Machine Learning Techniques
Some traditional methods are examined which are commonly used in machine learning,to find $`θ_{Cs}`$ out of the cone-sphere intersection curves.
We test following methods:
1.  SVR
2.  KNN
3.  Kernel Ridge
4.  Linear Regression
5.  Decision Tree


Final table of parameters that are crucial for finding the best estimator:


| model | RMSE | fit time | predict time
| ------ | ------ | ------ | ------ |
| SVR | 0.1257 | 8’:35” | 8’:34” |
| KNN | 0.1044 | 1.26s | 12’:38” |
| Kernel Ridge | 0.2331 | 35.9s | 9.11s |
| Linear Regression | 0.1387 | 5.83s | 2.12s |
| Decision Tree | 0.1314 | 8.07s | 826 ms |

## Neural Network Techniques 
### image processing
We use Otsu thresholding algorithm to find the best threshold value to make CMB a binary image and after 
that the connected components algorithm is used to find the connected pixels. 


* [matlab code](Neural Network Techniques/image processing/cmb_analyzer.m) - image processing algorithm
* [Otsu](Neural Network Techniques/image processing/OtsuThersholding.m) - used in image processing algorithm 
* [result](Neural Network Techniques/image processing/connected_area.jpg) - binary image


### curve tracing
There is an algorithm which separate curves based on different points gradient. After finding curves on CMB we use this algorithm to trace curves and divide them into separate curves. Now we can use 
this separate curves as input of our model which $`θ_{Cs}`$ is its output. 

* [curve tracing](Neural Network Techniques/curve tracing/Curve_Tracing.ipynb) - curve tracing algorithm 





