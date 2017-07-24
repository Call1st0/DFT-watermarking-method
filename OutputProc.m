function [ S ] = OutputProc(P,M)
%OUTPUTPROC Return to spatial domain
S = ifft2(ifftshift(M).*exp(1i*P));