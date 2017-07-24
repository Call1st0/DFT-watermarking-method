function [ C ] = wmcorr( S,slika,t,D,seed,r)
%WMCORR extraction of the vector RN from vector R and determination of the correlation of R and RS 
%   [ C ] = wmcorr( S,slika,t,D,seed)

%extraction of the vector H
[ H ]= wmextract(S,slika,t,r);

%generation of the pseudorandom vector
[ R ] = PseudoGen( D,seed );

%vectoradaptation
[ V ] = vctadapt( R, H );

%calculation of the covariance
C=xcov(V,double(H));

%plot of the covariance
x=1:max(size(C));
plot(x,C);

end

