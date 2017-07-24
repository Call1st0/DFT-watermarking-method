function [ M,P ] = InputProc(S)
%INPUTPROC, furrier transform and coefficient shift: M - Magnitude, P-Phase

F=fft2(single(S));
M=fftshift(abs(F));
P=angle(F); 