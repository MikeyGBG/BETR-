function images2phowmatch(ImageIn, TemplateIn);
% This function tries to find a template in a main image
%
% Usage:
% images2siftmatch(ImageIn, TemplateIn);
%
% Example use:
% images2siftmatch(imread('p3676a.jpg'),imadjust(imread('Dominoes_6x6.gif')));
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

%% ------------------------------------------------------------------------
%% DEFINED CONSTANTS
NUM_SIFT_TO_SHOW = 50;
SAMPLERATE = 0.10;
SIFT_THRESH = 1.5;

%% PREPROSSING
% Image size
[Irows, Icolors, InumberOfColorChannels] = size(ImageIn);
[Trows, Tcolors, TnumberOfColorChannels] = size(TemplateIn);

%Convert Images to Single (Grayscale)
if InumberOfColorChannels>1     Ig = single(rgb2gray(ImageIn)); else   Ig = single(ImageIn); end 
if TnumberOfColorChannels>1     Tg = single(rgb2gray(TemplateIn)); else   Tg = single(TemplateIn); end
    

%% Compute/Extract SIFT Features & Match
% SIFT image_features, image_descriptors 
[I_f, I_d] = vl_phow(Ig) ;
% SIFT template_features, template_descriptors 
[T_f, T_d] = vl_phow(Tg) ;


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
% feature has the format [X;Y;C;S], where X,Y is the (fractional) center of the frame, 
%C is the contrast of the descriptor, as returned by VL_DSIFT() (for colour variant, contranst is computed on the intensity channel). S is the size of the bin of the descriptor. 

% Top (by match score)
sel=matches_sort(1,:);

% Plot SIFT Features
figure(10);
imshow(ImageIn);
h1 = vl_plotframe(I_f(:,sel)) ; 
h2 = vl_plotframe(I_f(:,sel)) ; 

set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;

h3 = vl_plotsiftdescriptor(I_d(:,sel),I_f(:,sel)) ;
set(h3,'color','g') ;

figure(20);
imshow(TemplateIn);
sel2=matches_sort(2,:);
h4 = vl_plotframe(T_f(:,sel2)) ; 
h5 = vl_plotframe(T_f(:,sel2)) ; 

set(h4,'color','k','linewidth',3) ;
set(h5,'color','y','linewidth',2) ;

h6 = vl_plotsiftdescriptor(T_d(:,sel2),T_f(:,sel2)) ;
set(h6,'color','g') ;




%% Display SIFT Matches
figure(30);
Tg_resize=imresize(Tg, [size(Ig,1) NaN]);
TgScale=size(Ig,1)/size(Tg,1);
imshow(uint8(cat(2,Ig,Tg_resize)));
% For Cleaner Display: axis image off ;

% Locate Feature Matches
I_xa = I_f(1,matches_sort(1,:));
I_ya = I_f(2,matches_sort(1,:));

T_xb = T_f(1,matches_sort(2,:))*TgScale + size(Ig,2) ;
T_yb = T_f(2,matches_sort(2,:))*TgScale;
 
hold on;
gcf
h = line([I_xa ; T_xb], [I_ya ; T_yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;
 
vl_plotframe(I_f(:,matches_sort(1,:))) ;
T_f_resize=T_f; T_f_resize(1,:) = T_f(1,:)*TgScale + size(Ig,2);
T_f_resize(2,:) = T_f(2,:)*TgScale;
vl_plotframe(T_f_resize(:,matches_sort(2,:)));
hold off;

%% Return Nothing
%ReturnValue = 0;

