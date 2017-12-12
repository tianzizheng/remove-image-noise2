clear;
clc;
I=imread('19.jpg');%��ȡͼ��
I=rgb2gray(I);
subplot(2,1,1);
imshow(I);           
title('ԭʼͼ');                      %��ʾԭͼ

I_fft=fft2(I);                     %��ͼ����и���Ҷ�任
I_shift=fftshift(I_fft);    %�Ա任��ͼ����ж����仯������������ƽ�ƣ�ʹ�����Ļ�
% sw=1;                       %BLPF
 sw=2; %GLPF
%% Butterworth LPF ��ͨ�˲���
if sw==1
    [M,N]=size(I_shift);
    nn=2;           % ���װ�����˹(Butterworth)��ͨ�˲���
    d0=25;         % �޸��ܹ�������ֹƵ��
    m=fix(M/2); n=fix(N/2);
    for i=1:M
           for j=1:N
               d=sqrt((i-m)^2+(j-n)^2);
               h1=1/(1+(d/d0)^(2*nn));  % �����ͨ�˲������ݺ���
               result1(i,j)=h1*I_shift(i,j);
           end
    end
    % ���������ƶ�������λ�ã���ЧΪresult1(x,y)=result1(x,y)*(-1)^(x+y);
    result1=ifftshift(result1); 
    J2=ifft2(result1);
    J3=uint8(real(J2));
    subplot(2,1,2);
    imshow(J3);
    title('BLPF�˲�ͼ');        % ��ʾ�˲�������ͼ��
    ghf=gscale(J3);
ghe=histeq(ghf,256);
figure;imshow(ghe);
end

%% Gaussian LPF ��ͨ�˲���
if sw==2
    [M,N]=size(I_shift);
    d0=14;                                   % �޸��ܹ�������ֹƵ��
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
    title('GLPF�˲�ͼ');                      % ��ʾ�˲�������ͼ��
%     ghf=gscale(J3);
% ghe=histeq(ghf,256);
% figure;imshow(ghe);
end






