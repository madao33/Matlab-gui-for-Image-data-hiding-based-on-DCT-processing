function [result,key,flag] = insertData(img,str,alpha)
%insertData 嵌入数据
%   img-嵌入数据载体图像矩阵，str-嵌入字符串
%   result-嵌入数据后的图像，key-提取数据密钥
flag = true;
k1=randn(1,8);  %产生两个不同的随机序列
k2=randn(1,8);
data = de2bi(unicode2native(str));
before = blkproc(img,[8 8], 'dct2');
after=before;   %初始化载入水印的结果矩阵
[rm,cm] = size(img);
[sd,cd] = size(data);
data = reshape(data,[1,sd*cd]);
len=sd*cd;
cntx = 1;
cnty = 1;
for i = 1:len
    if data(i) == 1
        k=k1;
    else
        k=k2;
    end
    x = (cntx-1)*8;
    y = (cnty-1)*8;
    after(x+1,y+8)=before(x+1,y+8)+alpha*k(1);
    after(x+2,y+7)=before(x+2,y+7)+alpha*k(2);
    after(x+3,y+6)=before(x+3,y+6)+alpha*k(3);
    after(x+4,y+5)=before(x+4,y+5)+alpha*k(4);
    after(x+5,y+4)=before(x+5,y+4)+alpha*k(5);
    after(x+6,y+3)=before(x+6,y+3)+alpha*k(6);
    after(x+7,y+2)=before(x+7,y+2)+alpha*k(7);
    after(x+8,y+1)=before(x+8,y+1)+alpha*k(8);
    cnty = cnty+1;
    if cnty>cm/8
        cnty=1;
        cntx = cntx+1;
    end
    if cntx>rm/8
        flag = false;
        break;
    end
end
result=blkproc(after,[8 8],'idct2');
result = uint8(result);
key = [k1;k2];
key(3,1)=len;
key(3,2)= alpha;
end

