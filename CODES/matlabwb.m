%WAP to find the co-ordinates of image block
clc;
clear all;
close all;

%creating video object
vid=videoinput('winvideo',1,'YUY2_640x480');

%open serial port for zigbee communication
%s = serial('COM1');
%fopen(s);

i=getsnapshot(vid); %snapshot of the video frame
figure,imshow(i); %display the snapshot
ig=rgb2gray(i); %rgb to graylevel conversion
a=ig;

[row col]=size(a); %row and column value of matrix a
T=input('Enter value of threshold:');
%thresholding function
for i=1:1:row
    for j=1:1:col
        if(ig(i,j)<T)
            a(i,j)=0;
        else
            a(i,j)=255;
        end
    end
end

figure(1),imshow(a); %display thresholded image

bw=im2bw(a,0.5); %graylevel to black&white conversion
imshow(bw); 

%removes from the previous binary image all connected components that have fewer than 100 pixel values,producing another binary image
%i.e noiseless image
bw=bwareaopen(bw,100); 
figure,imshow(bw);

[labeled,numObjects]=bwlabel(bw,8); %returns a matrix L in labeled , of the same size as BW and in numObjects, the number of connected objects found in BW
graindata=regionprops(labeled,'basic'); %measures a set of properties for each connected component in the binary image
t=graindata.Centroid;
fy=t(1);
fx=t(2);
fx1=(fx-80);
fy1=(fy);

%display(fx1);
display(fy1);

%disp('the centre point is');
rectangle('position',[fy-10 fx-90 20 20],'EdgeColor','r');% to highlight the center by rectangle
drawnow;
%max threshold value=160

%conversion of coordinates into real time distance
disty=(fy1-10);

%Passing coordinates to Zigbee
%fprintf(s,disty);

display (disty);