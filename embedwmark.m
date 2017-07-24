function [ W, decibels_max, r_optim ] = embedwmark( image,D,S,rmin, rmax, m)
%EMBEDWMARK Implementation of a PRND number of lenght D with seed S in
%picture L using the implementation factor m in sector rmin-rmax
%   [ W ] = embedwmark( slika,D,S,rmin, rmax, m)

L=imread(image);

%% Check if the picture is grayscale of full color 
broj_dim=ndims(L);
if broj_dim==3
    %separation of chromatic and luminance components (for color images)
    L_ycbcr=rgb2ycbcr(L);
    L=L_ycbcr(:,:,1);
    L_cb=L_ycbcr(:,:,2);
    L_cr=L_ycbcr(:,:,3);
end


%% Transformation in Fourier domain >> M - magnitude, P - phase 
[M2,P2] = InputProc(L);

%% Generation of PRND
R = PseudoGen(D,S);

%% initialization of dec variable
dec=inf;

%% Search for optimal radius and maximum PSNR in interval 38-42 dB
while (dec>=42) || (dec<38)
    
[ decibels_max, r_optim ] = max_psnr( L, D, S, rmin, rmax, m);

%% adaptation of the implementation factor to get a resonably degraded
% watermarked image (30 <= PSNR <= 42)
if decibels_max>=42
    m=m+(0.5*m);
elseif decibels_max<=38
    m=m-(0.5*m);
end
dec=decibels_max;
end

%% vector implementation
E2 = Embed1(M2,R,m,r_optim);

%% return to spatial domain
W = ifft2(ifftshift(E2).*exp(1i*P2));
W=uint8(W);
%image adjustment to values 0 - 255
W = imadjust(W,[single(min(min(W)))/255 ; single(max(max(W)))/255] , [single(min(min(L)))/255 ; single(max(max(L)))/255] );

%% connecting chromatic and luminance components (for color images)
if broj_dim==3
W=cat(3,W,L_cb,L_cr);
W=ycbcr2rgb(W);
end

%% file naming
ime=image;
ime(:,(max((size(ime)-3)):max(size(ime))))=[];
imwrite(W, [ime '_' num2str(S) '_' num2str(m) '_' num2str(r_optim) '_' num2str(decibels_max, '%3.0f') '.bmp']);
disp(['PSNR value is ', num2str(decibels_max)]);
disp(['Implementation radius is ',num2str(r_optim)]);
disp(['Implementation factor is ',num2str(m)]);






end