function [ C_m ] = wmblindcorr( S,D,seed,rmin,rmax)
%WMCORR extraction of vector RN from vector R and determination of correlation with the vector RS 
%   [ C ] = wmblindcorr( S,D,seed,rmin,rmax)
% 

%% initialization
brojac=0;
thresholdSet=0.3;

%% determination of lenght of the vector extracted using radius rmax 
dulj=ceil(rmax*pi);
r_dulj=rmax-rmin;
C_m=zeros(r_dulj,((2*dulj)-1));

%% Resize image to 512*512 pixel
if size(S)~= 512 
    S=imresize(S,[512 512],'bilinear');
end

%% Check if the picture is grayscale of full color 
broj_dim=ndims(S);
if broj_dim==3
    %separation of chromatic and luminance components (for color images)
    S_ycbcr=rgb2ycbcr(S);
    S=S_ycbcr(:,:,1);
end


    
%% transformation to fourier domain with shift
S=fft2(single(S));
S=fftshift(abs(S));


%% Generation of pseudorandom vector
[ R ] = PseudoGen( D,seed );

%% lenght adaptation of vector R to lenght DULJ
R_m=imresize(R, [1 dulj],'bilinear');

%% Loop for generating covariance matrix
for r=rmin:rmax
    brojac=brojac+1;
    
% extraction of vector H from image
[ H ]= wmblindextract(S,r);

% lenght adaptation of vector H  to lenght DULJ
H=imresize(H, [1 dulj],'bilinear');

% covariance for vector R_m i vectora H
% Different rows of C_m will corespond to different radii 
C_m(brojac,:)=xcov(R_m,H,'coeff');
end
end

