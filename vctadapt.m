function [ V ] = vctadapt( R, H )
%VCTADAPT adaptation of the lenght of the vector R to the lenght of the vector H

d=max(size(H));
V=imresize(R, [1 d],'nearest');

end

