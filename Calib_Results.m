% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2290.768358336228200 ; 2202.043356909690400 ];

%-- Principal point:
cc = [ 553.885862554860980 ; 71.120410703081873 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.623388233236894 ; 3.826098939611033 ; -0.095090966499475 ; 0.017462719959154 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 529.215784809968910 ; 599.073040813465350 ];

%-- Principal point uncertainty:
cc_error = [ 43.163085346680106 ; 244.225650453755780 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.816590833862452 ; 6.166731913157291 ; 0.183541024834722 ; 0.019531897053707 ; 0.000000000000000 ];

%-- Image size:
nx = 1200;
ny = 900;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 20;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.972793e+00 ; -1.840952e+00 ; 2.071978e-01 ];
Tc_1  = [ 4.745737e+01 ; 5.591396e+02 ; 2.179867e+03 ];
omc_error_1 = [ 7.324809e-02 ; 5.545807e-02 ; 9.105081e-02 ];
Tc_error_1  = [ 4.230647e+01 ; 2.437565e+02 ; 4.750122e+02 ];

%-- Image #2:
omc_2 = [ 1.981185e+00 ; -1.876450e+00 ; 3.155757e-01 ];
Tc_2  = [ 5.017523e+01 ; 5.485446e+02 ; 2.210707e+03 ];
omc_error_2 = [ 7.455430e-02 ; 6.329856e-02 ; 8.759585e-02 ];
Tc_error_2  = [ 4.283402e+01 ; 2.464050e+02 ; 4.749674e+02 ];

%-- Image #3:
omc_3 = [ 1.977875e+00 ; -1.872515e+00 ; 3.116748e-01 ];
Tc_3  = [ 5.000236e+01 ; 5.482247e+02 ; 2.209295e+03 ];
omc_error_3 = [ 7.424918e-02 ; 6.266138e-02 ; 8.700075e-02 ];
Tc_error_3  = [ 4.280734e+01 ; 2.462928e+02 ; 4.750105e+02 ];

%-- Image #4:
omc_4 = [ 1.978464e+00 ; -1.871397e+00 ; 3.249817e-01 ];
Tc_4  = [ 5.015396e+01 ; 5.495018e+02 ; 2.215769e+03 ];
omc_error_4 = [ 7.433448e-02 ; 6.327955e-02 ; 8.585997e-02 ];
Tc_error_4  = [ 4.292562e+01 ; 2.469599e+02 ; 4.758226e+02 ];

%-- Image #5:
omc_5 = [ 1.970217e+00 ; -1.909118e+00 ; 3.618251e-01 ];
Tc_5  = [ 6.527508e+01 ; 5.198206e+02 ; 2.234546e+03 ];
omc_error_5 = [ 7.133559e-02 ; 6.411887e-02 ; 8.298341e-02 ];
Tc_error_5  = [ 4.325691e+01 ; 2.489040e+02 ; 4.779517e+02 ];

%-- Image #6:
omc_6 = [ 1.970169e+00 ; -1.909578e+00 ; 3.684973e-01 ];
Tc_6  = [ 6.540789e+01 ; 5.201739e+02 ; 2.236297e+03 ];
omc_error_6 = [ 7.128042e-02 ; 6.439381e-02 ; 8.254389e-02 ];
Tc_error_6  = [ 4.328743e+01 ; 2.490847e+02 ; 4.781336e+02 ];

%-- Image #7:
omc_7 = [ 4.820431e-02 ; -2.979351e+00 ; 6.879611e-01 ];
Tc_7  = [ 7.131447e+01 ; 4.129494e+02 ; 2.293162e+03 ];
omc_error_7 = [ 9.689014e-03 ; 5.980966e-02 ; 1.479274e-01 ];
Tc_error_7  = [ 4.419907e+01 ; 2.545115e+02 ; 4.845671e+02 ];

%-- Image #8:
omc_8 = [ 1.983394e+00 ; -1.973099e+00 ; 3.746081e-01 ];
Tc_8  = [ 8.984040e+01 ; 4.888282e+02 ; 2.265189e+03 ];
omc_error_8 = [ 6.924934e-02 ; 6.628762e-02 ; 8.740938e-02 ];
Tc_error_8  = [ 4.380352e+01 ; 2.519736e+02 ; 4.823588e+02 ];

%-- Image #9:
omc_9 = [ 1.979137e+00 ; -1.969871e+00 ; 3.867815e-01 ];
Tc_9  = [ 8.999975e+01 ; 4.883737e+02 ; 2.264287e+03 ];
omc_error_9 = [ 6.867255e-02 ; 6.617568e-02 ; 8.575280e-02 ];
Tc_error_9  = [ 4.378017e+01 ; 2.518865e+02 ; 4.821451e+02 ];

%-- Image #10:
omc_10 = [ 1.978827e+00 ; -1.964647e+00 ; 3.204600e-01 ];
Tc_10  = [ 8.917138e+01 ; 4.872163e+02 ; 2.256183e+03 ];
omc_error_10 = [ 6.979321e-02 ; 6.385600e-02 ; 9.047790e-02 ];
Tc_error_10  = [ 4.367241e+01 ; 2.510624e+02 ; 4.818997e+02 ];

%-- Image #11:
omc_11 = [ 2.046169e+00 ; -2.065347e+00 ; 3.417137e-01 ];
Tc_11  = [ 1.151647e+02 ; 4.609363e+02 ; 2.294993e+03 ];
omc_error_11 = [ 7.383005e-02 ; 7.362489e-02 ; 1.073758e-01 ];
Tc_error_11  = [ 4.428519e+01 ; 2.549156e+02 ; 4.859147e+02 ];

%-- Image #12:
omc_12 = [ 2.817831e+00 ; -1.530717e-02 ; 6.607085e-03 ];
Tc_12  = [ -9.486862e+01 ; 4.624393e+02 ; 2.291329e+03 ];
omc_error_12 = [ 1.095567e-01 ; 7.622751e-03 ; 7.571505e-02 ];
Tc_error_12  = [ 4.423714e+01 ; 2.551102e+02 ; 4.884727e+02 ];

%-- Image #13:
omc_13 = [ 2.818863e+00 ; -1.708885e-02 ; -6.325473e-03 ];
Tc_13  = [ -9.490943e+01 ; 4.623578e+02 ; 2.290639e+03 ];
omc_error_13 = [ 1.101924e-01 ; 7.669643e-03 ; 7.597970e-02 ];
Tc_error_13  = [ 4.421755e+01 ; 2.549658e+02 ; 4.879738e+02 ];

%-- Image #14:
omc_14 = [ 2.907258e+00 ; -2.551616e-02 ; 5.093445e-02 ];
Tc_14  = [ -7.102511e+01 ; 4.333182e+02 ; 2.310302e+03 ];
omc_error_14 = [ 1.240107e-01 ; 1.035460e-02 ; 1.142712e-01 ];
Tc_error_14  = [ 4.455006e+01 ; 2.569870e+02 ; 4.922808e+02 ];

%-- Image #15:
omc_15 = [ 2.938891e+00 ; -2.468967e-02 ; 5.736619e-02 ];
Tc_15  = [ -7.101309e+01 ; 4.335904e+02 ; 2.311911e+03 ];
omc_error_15 = [ 1.358056e-01 ; 1.215320e-02 ; 1.377969e-01 ];
Tc_error_15  = [ 4.456365e+01 ; 2.571617e+02 ; 4.928082e+02 ];

%-- Image #16:
omc_16 = [ 3.015406e+00 ; -3.604988e-02 ; -9.103192e-02 ];
Tc_16  = [ -7.101342e+01 ; 4.357844e+02 ; 2.326377e+03 ];
omc_error_16 = [ 1.534188e-01 ; 1.425760e-02 ; 1.494527e-01 ];
Tc_error_16  = [ 4.482057e+01 ; 2.580663e+02 ; 4.927187e+02 ];

%-- Image #17:
omc_17 = [ 3.031315e+00 ; -2.450624e-02 ; -2.930025e-02 ];
Tc_17  = [ -5.020295e+01 ; 4.013719e+02 ; 2.342483e+03 ];
omc_error_17 = [ 1.850250e-01 ; 1.573416e-02 ; 1.854500e-01 ];
Tc_error_17  = [ 4.494212e+01 ; 2.594365e+02 ; 4.953622e+02 ];

%-- Image #18:
omc_18 = [ 3.048089e+00 ; -2.192953e-02 ; -6.987107e-04 ];
Tc_18  = [ -5.019072e+01 ; 4.015305e+02 ; 2.342700e+03 ];
omc_error_18 = [ 1.564398e-01 ; 1.452098e-02 ; 1.652750e-01 ];
Tc_error_18  = [ 4.493177e+01 ; 2.593781e+02 ; 4.949971e+02 ];

%-- Image #19:
omc_19 = [ -3.173828e+00 ; 3.545134e-02 ; 1.311675e-01 ];
Tc_19  = [ -4.951676e+01 ; 4.027644e+02 ; 2.353452e+03 ];
omc_error_19 = [ 1.177627e-01 ; 1.233726e-02 ; 1.069420e-01 ];
Tc_error_19  = [ 4.524599e+01 ; 2.604676e+02 ; 4.948047e+02 ];

%-- Image #20:
omc_20 = [ 3.000962e+00 ; 2.365342e-03 ; 2.265061e-01 ];
Tc_20  = [ -2.902104e+01 ; 3.597573e+02 ; 2.297780e+03 ];
omc_error_20 = [ 1.051097e-01 ; 1.530589e-02 ; 7.553886e-02 ];
Tc_error_20  = [ 4.411296e+01 ; 2.540705e+02 ; 4.845447e+02 ];

