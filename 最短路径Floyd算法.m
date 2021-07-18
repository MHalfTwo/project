%% 最短路径的Floyd算法
clc,clear
%% 输入加权矩阵
weight=zeros(7,7);
weight(1,2)=12;weight(1,6)=16;weight(1,7)=14;
weight(2,3)=10;weight(2,6)=7;
weight(3,4)=3;weight(3,5)=5;weight(3,6)=6;
weight(4,5)=5;
weight(5,6)=2;weight(5,7)=9;
weight=weight+weight';
weight(weight==0)=inf;
[x,y]=size(weight); %获取范围
for i= 1:x
    weight(i,i)=0;
end
%% Floyd算法
Answer=weight;
for i =1:x %以第i个点为中间点
    for j=1:x %以第j个点为出发点
        for k=1:x %以第k个点为终止点
            if Answer(j,k)>=Answer(i,j)+Answer(i,k) %进行判断
                Answer(j,k)=Answer(i,j)+Answer(i,k); %若大于，则替换
            end
        end
        
    end
end