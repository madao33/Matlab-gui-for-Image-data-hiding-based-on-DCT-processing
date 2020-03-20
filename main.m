clc;
clear;
%% 读入图像
I = imread('lena.bmp');
% mark = imread('mark.bmp');
% mark = imbinarize(rgb2gray(mark));


str = 'Life is like a box of chocolate, you never know what you gonna get.-<Forrest.Gump>';
alpha = 30;
[result,key,flag] = insertData(I,str,alpha);
disp(key);
disp(flag);

[result1,data] = extractData(result,key);
disp('提取的数据：');
char = char(bi2de(data));
[len,~] = size(char);
str = reshape(char,[1,len]);
disp(str);
figure(1)
subplot(121),imshow(I);
subplot(122),imshow(result1);


