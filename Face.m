%Name : Urvish Tank
%Roll No : 201501107
%Date : 11/04/18
%Q1: Face Recognition:

clear all;
close all;
clc;
%size of Image
m=320;
n=243;

%N=166;
%avg = zeros(m*n,1);

%initialization of Matrix
A=[];
%Sample Images Read
files = dir(fullfile('C:\Users\Dell\Desktop\dip\DIP_Jan2018\yalefaces\', 'subje*')); %change path with your relavent image directory path
%Counting Total Sample Images
L = length(files);

x = cell(L,1);
for i=1:L 
    file=files(i).name;
    filepath = fullfile( 'C:\Users\Dell\Desktop\dip\DIP_Jan2018\yalefaces\', file );
    x{i}=imread(filepath);
   imshow(x{i});
%    if(size(x,3)==1)
 %       M=double(x);
  %  else
   %     M=double(rgb2gray(x));
   % end
end

 A=zeros(m*n,L);
for i=1:L
    A(:,i)=x{i}(:);
end

%Compute the SVD
[U,S,V] = svd(A,'econ');
%Test image
u=imread('C:\Users\Dell\Desktop\dip\DIP_Jan2018\yalefaces\subject04.rightlight'); %change path with your relavent image directory path
figure(1);

r=rank(A);
U=U(:,1:r);
subplot(1,2,1);
imshow(u),title('Input image');

Final=zeros(L,r);
for i=1:L
%    fc(:,i)=f.*U(:,i);
    f=A(:,i);
    for j=1:r
       Final(i,j)= sum(f.*U(:,j));
    end
end
%grayscaleValues
u_new=double(u(:));

test=zeros(1,r);
for i=1:r
    test(1,i)=sum(u_new.*U(:,i));
end

dist=zeros(L,1);

for i=1:L
    dist(i)=immse(test,Final(i,:));
end

result=find(dist==min(dist));
figure
imshow(x{result(1)}),title('Output Image');

%%u_r=reshape(u_new,m*n,1) - avg;
%u_v = u_r' * phi(:,1:3);
