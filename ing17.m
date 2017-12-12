f=imread('17.jpg');
f=rgb2gray(f);
figure;subplot(1,3,1);imshow(f,[]);title('原始图像');

fp=spfilt(f,'chmean',3,3,1.5);
fs=spfilt(fp,'chmean',3,3,-1.5);
subplot(1,3,2);imshow(fs,[]);title('反调和滤波');
% PQ=paddedsize(size(fs));
% D0=0.02*PQ(1);
% HBW=hpfilter('btw',PQ(1),PQ(2),D0,2);
% H=0.9+2*HBW;

%gbw=dftfilt(fs,HBW);
%gbw=gscale(gbw);
%ghf=dftfilt(fs,H);
ghf=gscale(fs);
ghe=histeq(ghf,256);
subplot(1,3,3);imshow(ghe,[]);title('直方图均衡化');







