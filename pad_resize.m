function [slika4, orig4] = pad_resize( slika, orig )
%PAD_RESIZE Padding of image size ORIG to size SLIKA or resize Resize of the image SLIKA to size ORIG
 
size_s=size(slika);
size_o=size(orig);
diff_v=size_s(1,1)-size_o(1,1);
diff_h=size_s(1,2)-size_o(1,2);
slika2=slika;
orig2=orig;
if diff_v~=0
switch diff_v>0
    case {1}
        %disp('diff_v>0')
        if mod(diff_v,2)==0
            orig2=padarray(orig2,[(abs(diff_v)/2),0]);
        else 
            orig2=padarray(orig2,[((abs(diff_v)-1)/2),0]);
            orig2(size_s(1,1),1)=0;
        end
        
    case {0}
        %disp('diff_v<0')
        if mod(diff_v,2)==0
            slika2=padarray(slika2,[(abs(diff_v)/2),0]);
        else 
            slika2=padarray(slika2,[((abs(diff_v)-1)/2),0]);
            slika2(size_o(1,1),1)=0;
        end
end   
    
end
orig3=orig2;
slika3=slika2;

if diff_h~=0
switch (diff_h>0)
    case {1}
        %disp('diff_h>0')
        if mod(diff_h,2)==0
            orig3=padarray(orig3,[0,(abs(diff_h)/2)]);
        else 
            orig3=padarray(orig3,[0,((abs(diff_h)-1)/2)]);
            orig3(1,size_s(1,2))=0;
        end
    case {0}
        %disp('diff_h<0')
        if mod(diff_h,2)==0
            slika3=padarray(slika3,[0,(abs(diff_h)/2)]);
        else 
            slika3=padarray(slika3,[0,((abs(diff_h)-1)/2)]);
            slika3(1,size_o(1,2))=0;
        end
end
end
orig4=orig3;
slika4=slika3;
end

