function images2dsiftmatch(ImageIn, TemplateIn);
% This function tries to find a template in a main image
%
% Usage:
% images2dsiftmatch(ImageIn, TemplateIn);
%
% Example use:
% images2dsiftmatch(imread('p3676a.jpg'),imadjust(imread('Dominoes_6x6.gif')));
%
% (METR4202, 2016)

%% For testing with domino & vl_feat test images:
% ImageIn=imread('DominoSetup.1.jpg');
% ImageIn=imresize(ImageIn,0.25);
% TemplateIn=imread('p3676a.jpg');
% figure(10); imshow(ImageIn);

%For Testing that SIFT is working
%ImageIn=imread('p3676a.jpg');  
%TemplateIn=imadjust(imread('Dominoes_6x6.gif'));  %Imadjust to contrast adjust GIF

%For Testing with vl_feat test images
%ImageIn = imread(fullfile(vl_root,'data','roofs1.jpg')) ;
%TemplateIn = imread(fullfile(vl_root,'data','roofs2.jpg')) ;

%% DEFINED CONSTANTS
NUM_SIFT_TO_SHOW = 50;
SAMPLERATE = 0.10;
SIFT_THRESH = 0.5;
%Dense SIFT:
binSize = 8 ;
magnif = 3 ;

%% PREPROSSING
% Image size
[Irows, Icolors, InumberOfColorChannels] = size(ImageIn);
[Trows, Tcolors, TnumberOfColorChannels] = size(TemplateIn);

%Convert Images to Single (Grayscale)
if InumberOfColorChannels>1     Ig = single(rgb2gray(ImageIn)); else   Ig = single(ImageIn); end 
if TnumberOfColorChannels>1     Tg = single(rgb2gray(TemplateIn)); else   Tg = single(TemplateIn); end
    

%% Compute/Extract DENSE SIFT Features & Match
% DENSE SIFT image_features, image_descriptors 
Is = vl_imsmooth(Ig, sqrt((binSize/magnif)^2 - .25)) ;
[I_f, I_d] = vl_dsift(Is, 'size', binSize) ;
Ts = vl_imsmooth(Tg, sqrt((binSize/magnif)^2 - .25)) ;
[T_f, T_d] = vl_dsift(Ts, 'size', binSize) ;

% Randomly sample some of the features
qperm = randperm(length(I_d)); 
I_f_sample=I_f(:,qperm(1:ceil(SAMPLERATE*length(I_d))));
I_d_sample=I_d(:,qperm(1:ceil(SAMPLERATE*length(I_d))));
qperm = randperm(length(T_d)); 
T_f_sample=T_f(:,qperm(1:ceil(SAMPLERATE*length(T_d))));
T_d_sample=T_d(:,qperm(1:ceil(SAMPLERATE*length(T_d))));

%SIFT Matching
[matches, scores] = vl_ubcmatch(I_d_sample, T_d_sample, SIFT_THRESH);
[scores_sort, scores_rank] = sort(scores, 'descend') ;
matches_sort = matches(:, scores_rank(1:min([length(scores_rank) NUM_SIFT_TO_SHOW])));


%% Display SIFT Features
% feature has the format [X;Y] as all DSIFT frames have the same scale and orientation, where X,Y is the (fractional) center of the frame, S is the scale and TH is the orientation (in radians). 

% Random Set
perm = randperm(size(I_f_sample,2)) ; 
sel = perm(1:min([length(perm),NUM_SIFT_TO_SHOW]));

% Top (by match score)
sel=matches_sort(1,:);

% Plot SIFT Features
figure(10);
imshow(ImageIn); hold on;
h1 = vl_plotframe(I_f_sample(:,sel)) ; 
h2 = vl_plotframe(I_f_sample(:,sel)) ; hold off;

figure(20);
imshow(TemplateIn); hold on;
sel2=matches_sort(2,:);
h4 = vl_plotframe(T_f_sample(:,sel2)) ; 
h5 = vl_plotframe(T_f_sample(:,sel2)) ; hold off;




%% Display SIFT Matches
figure(30);
Tg_resize=imresize(Tg, [size(Ig,1) NaN]);
TgScale=size(Ig,1)/size(Tg,1);
imshow(uint8(cat(2,Ig,Tg_resize)));
% For Cleaner Display: axis image off ;

% Locate Feature Matches
I_xa = I_f_sample(1,matches_sort(1,:));
I_ya = I_f_sample(2,matches_sort(1,:));

T_xb = T_f_sample(1,matches_sort(2,:))*TgScale + size(Ig,2) ;
T_yb = T_f_sample(2,matches_sort(2,:))*TgScale;
 
hold on;
h = line([I_xa ; T_xb], [I_ya ; T_yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;
 
vl_plotframe(I_f_sample(:,matches_sort(1,:))) ;
T_f_resize=T_f_sample; T_f_resize(1,:) = T_f_sample(1,:)*TgScale + size(Ig,2);
T_f_resize(2,:) = T_f_sample(2,:)*TgScale;
vl_plotframe(T_f_resize(:,matches_sort(2,:)));
hold off;

%% Return Nothing
%ReturnValue = 0;


