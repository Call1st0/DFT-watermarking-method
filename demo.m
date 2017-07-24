%% Initialize;
clc; clear; close all;

%% embedding of the watermark
[ W, decibels_max, r_optim ] = embedwmark( 'lena.bmp',200,7,160, 190, 5);


%% plotting of the images
figure;
subplot(1,2,1); imshow('lena.bmp');
title('Original Image')
subplot(1,2,2); imshow(W);
title('Watermarked image')

fprintf('Program paused. Press enter to continue.\n');
pause;

%Attacking the image with noise
W_att = imnoise(W,'gaussian',0,0.01);

%% plotting of the images
figure;
subplot(1,2,1); imshow(W);
title('Watermarked image')
subplot(1,2,2); imshow(W_att);
title('Attacked image')

fprintf('Program paused. Press enter to continue.\n');
pause;

%% calculating the covariance of the watermarked image W
[ C_m ] = wmblindcorr( W_att,200,7,170,200);


%% determining if the image is watermarked
if max(max(C_m))>=0.3
    disp(['Watermark detected. Covariance = ', num2str(max(max(C_m)))]);
else
    disp(['Watermark not detected. Covariance = ', num2str(max(max(C_m)))]);
end

%% plotting of covariance

figure;
mesh(C_m); title('Covariance');
