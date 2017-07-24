function [ H ] = wmblindextract(S,r)
%wmextract extraction of pixels from image S using the radius r
%NOTE image S has to be of the size 512*512: otherwise adjust
    
 
    %% determination of the step according to radius
    kut=2*asin((1/(2*r)));
    k=pi/kut;
    R1=zeros(1,ceil(k));
    
    L=zeros(3);
    
    %% extraction of the vector R1. Elements of the vector are determined as
    % the maximum value of the 3x3 neighborhood
    for l=1:ceil(k)
    x1=(257)+round((r)*cos(((l-1)*(pi)/k)));
    y1=(257)+round((r)*sin(((l-1)*(pi)/k)));
    
    for g=1:3
        for h=1:3
            L(g,h)=S((round(x1)-2+g),(round(y1)-2+h));
        end
    end
    R1(1,l)=max(max(L));
    end
    
    H=R1;
    
    
    end
    