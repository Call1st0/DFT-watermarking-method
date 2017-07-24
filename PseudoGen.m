function [ R ] = PseudoGen( D,seed )
%PSEUDOGEN Marsenne twister generator of binary pseudorandom numbers
%   Generates pseudorandom vector R of lenght D, using Seed 
stream=RandStream('mt19937ar','Seed',seed);
R=round(rand(stream,1,D));
end

