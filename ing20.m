I= imread('20.jpg');
I=rgb2gray(I);
J=fft2(I);
figure;subplot(2,2,1);imshow(I);title('Ô­Í¼Ïñ');

N=fftshift(J);
subplot(2,2,2);imshow(log(abs(N)),[]);title('ÆµÆ×Í¼');

 win=ones(300);
for ii=1:300
    for jj=1:300
        if (   (ii-(300+1)/2)^2>20^2    &&(jj-(300+1)/2)^2<15^2)
            win(ii,jj)=0;
        end
    end
end
%N(abs(N)<5000)=0;
N=N.*win;
subplot(2,2,3);imshow(log(abs(N)+eps),[]);title('´¦ÀíÆµÆ×Í¼');

M=ifftshift(N);
K=ifft2(M);
subplot(2,2,4);imshow(K,[0 255]);title('È¥ÔëÍ¼');
