function [ C_m ] = wmcorr2( S,slika,t,D,seed,rmin,rmax)
%WMCORR2 extraction of the vector RN from vector R and determination of the correlation of R and RS 
%   [ C ] = wmcorr2( S,slika,t,D,seed)


brojac=0;
dulj=ceil(rmax*pi);

%generiranje pseudoslucajnog vektora
[ R ] = PseudoGen( D,seed );

for r=rmin:rmax
    brojac=brojac+1;
    
%extraction of the vector H
[ H ]= wmextract(S,slika,t,r);

%adaptation of vector lenght
H=imresize(H, [1 dulj],'nearest');
R_m=imresize(R, [1 dulj],'nearest');


%calculation of the covariance
C_m(brojac,:)=xcov(R_m,double(H));
end

%plot of the covariance
mesh(C_m);

end

