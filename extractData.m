function [result,data] = extractData(img,key)
%extractData 从嵌入数据后的图像中提取数据
%   img-嵌入数据的图像，key-提取密钥，result-恢复后的图像，data-提取的数据
k1 = key(1,:);
k2 = key(2,:);
len = key(3,1);
alpha = key(3,2);
[~,cm]=size(img);
after_2=blkproc(img,[8,8],'dct2');
data = zeros(1,len);
p = zeros(1,8);
cntx = 1;
cnty = 1;
for i=1:len
    x = (cntx-1)*8;
    y = (cnty-1)*8;
    p(1)=after_2(x+1,y+8);         %将之前改变过数值的点的数值提取出来
    p(2)=after_2(x+2,y+7);
    p(3)=after_2(x+3,y+6);
    p(4)=after_2(x+4,y+5);
    p(5)=after_2(x+5,y+4);
    p(6)=after_2(x+6,y+3);
    p(7)=after_2(x+7,y+2);
    p(8)=after_2(x+8,y+1);
    if corr2(p,k1)>corr2(p,k2)  %corr2计算两个矩阵的相似度，越接近1相似度越大
        data(i)=1;              %比较提取出来的数值与随机频率k1和k2的相似度，还原水印图样
    else
        data(i)=0;
    end
    cnty = cnty+1;
    if cnty>cm/8
        cnty=1;
        cntx = cntx+1;
    end
end
%恢复图像
cntx = 1;
cnty = 1;
before = after_2;
for i=1:len
    x = (cntx-1)*8;
    y = (cnty-1)*8;
    if data(i)==1
        k=k1;
    else
        k=k2;
    end
    before(x+1,y+8)=after_2(x+1,y+8)-alpha*k(1);
    before(x+2,y+7)=after_2(x+2,y+7)-alpha*k(2);
    before(x+3,y+6)=after_2(x+3,y+6)-alpha*k(3);
    before(x+4,y+5)=after_2(x+4,y+5)-alpha*k(4);
    before(x+5,y+4)=after_2(x+5,y+4)-alpha*k(5);
    before(x+6,y+3)=after_2(x+6,y+3)-alpha*k(6);
    before(x+7,y+2)=after_2(x+7,y+2)-alpha*k(7);
    before(x+8,y+1)=after_2(x+8,y+1)-alpha*k(8);
    cnty = cnty+1;
    if cnty>cm/8
        cnty=1;
        cntx = cntx+1;
    end
end
result=blkproc(before,[8 8],'idct2');
result = uint8(result);
data = reshape(data,[len/7,7]);
end

