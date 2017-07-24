function [ decibels_max, r_optim] = max_psnr( K, D, S, rmin, rmax, m)
%MAX_PSNR calculation of PSNR and search for optimal radius from rmin-rmax
%   K - image; D - vector lenght; S - seed, m - implementation factor

F=K;

%%Transformation in Fourier domain >> M - magnitude, P - phase 
[M,P] = InputProc(K);

%Generation of PRND
R = PseudoGen(D,S);

%initialization 
decibels_max=0;
r_optim=0;

%main loop for radius
for r=rmax:-1:rmin
    
%vector embedding 
[E_mark] = Embed1(M,R,m,r);

%return to spatial domain 
W_i = ifft2(ifftshift(E_mark).*exp(1i*P));

%image adjastment of max and min values with the original 
W_i = uint8(W_i);
W_i = imadjust(W_i,[single(min(min(W_i)))/255 ; single(max(max(W_i)))/255] , [single(min(min(F)))/255 ; single(max(max(F)))/255] );

%Determing PSNR
error_diff1 = single(F) - single(W_i);
decibels = 20*log10(255/(sqrt(mean2(error_diff1.^2))));
if (decibels<=inf) && (decibels>decibels_max) 
    decibels_max=decibels;
    r_optim=r; 
    
end
end
end

