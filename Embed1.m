function  [E] = Embed1(F,t,m,r)
%EMBED1 Implementation of 1D pseudorandom vector t as a circular patern in
%sector S1/r using the implementation factor m
%
W=zeros(size(F));
[s1,s2]=size(F);
k=max(size(t));

%Frequency is determined with radius r
L=zeros(3);
H=zeros(3);

%vector implementation
for l=1:k
    x1=(s1/2+1)+round((r)*cos(((l-1)*(pi)/k)));
    y1=(s2/2+1)+round((r)*sin(((l-1)*(pi)/k)));
    x2=(s1/2+1)+round((r)*cos(((l-1)*(pi)/k)+(pi)));
    y2=(s2/2+1)+round((r)*sin(((l-1)*(pi)/k)+(pi)));
    for g=1:3
        for h=1:3
            L(g,h)=F((x1-2+g),(y1-2+h));
            H(g,h)=F((x2-2+g),(y2-2+h));
        end
    end
    W(x1,y1)=t(1,l)*(mean2(L));
    W(x2,y2)=t(1,l)*(mean2(H));
end
    E=F+m*W;    
end