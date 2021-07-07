%% D'Hondt法/Q值判断法
clc,clear;
%% 输入题目条件
all_num=1000;
people=[2525 3343 4132];
all_people=sum(people);
%% 获取部门数量，并且预分配内存
[m,n]=size(people);
answer_DH=zeros(m,n); %每部门分配的名额
%% 将每一部门的数量依次除以N (DH方法)
D_H=zeros(n,all_num);
for i=1:all_num
    D_H(:,i)=people'/i;
end
%% 根据排名通过循环语句获取名额分配方案（DH方法）
for i = 1:all_num
    [max_D,x]=(max(D_H));
    [max_DD,y]=max(max_D);
    x=x(y);
    D_H(x,y)=0;
    answer_DH(x)=answer_DH(x)+1;
end
%% Q值判断法
Q=people*(all_num/all_people);
for i = 1:n
    Q(i)=fix(Q(i));
end
answer_Q=Q;
w=zeros(m,n);
for i = 1:n
    w(i)=people(i)^2/((Q(i))*(Q(i)+1));
end
[x,y]=max(w);
answer_Q(i)=answer_Q(i)+1;