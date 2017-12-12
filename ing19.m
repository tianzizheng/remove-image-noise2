clear;
clc;
I=imread('19.jpg');%读取图像
I=rgb2gray(I);
subplot(2,1,1);
imshow(I);           
title('原始图');                      %显示原图

I_fft=fft2(I);                     %对图像进行傅立叶变换
I_shift=fftshift(I_fft);    %对变换后图像进行队数变化，并对其坐标平移，使其中心化
% sw=1;                       %BLPF
 sw=2; %GLPF
%% Butterworth LPF 低通滤波器
if sw==1
    [M,N]=size(I_shift);
    nn=2;           % 二阶巴特沃斯(Butterworth)低通滤波器
    d0=25;         % 修改能够调整截止频率
    m=fix(M/2); n=fix(N/2);
    for i=1:M
           for j=1:N
               d=sqrt((i-m)^2+(j-n)^2);
               h1=1/(1+(d/d0)^(2*nn));  % 计算低通滤波器传递函数
               result1(i,j)=h1*I_shift(i,j);
           end
    end
    % 将计算结果移动到中心位置，等效为result1(x,y)=result1(x,y)*(-1)^(x+y);
    result1=ifftshift(result1); 
    J2=ifft2(result1);
    J3=uint8(real(J2));
    subplot(2,1,2);
    imshow(J3);
    title('BLPF滤波图');        % 显示滤波处理后的图像
    ghf=gscale(J3);
ghe=histeq(ghf,256);
figure;imshow(ghe);
end

%% Gaussian LPF 低通滤波器
if sw==2
    [M,N]=size(I_shift);
    d0=14;                                   % 修改能够调整截止频率
    m=fix(M/2); n=fix(N/2);
    for i=1:M
        for j=1:N
            d=(i-m)^2+(j-n)^2;
            temp=d/(2*(d0^2));
            h1=exp(-temp);
            result1(i,j)=h1*I_shift(i,j);
        end
    end
    result1=ifftshift(result1);
    J2=ifft2(result1);
    J3=uint8(real(J2));
    subplot(2,1,2);
    imshow(J3);
    title('GLPF滤波图');                      % 显示滤波处理后的图像
%     ghf=gscale(J3);
% ghe=histeq(ghf,256);
% figure;imshow(ghe);
end






