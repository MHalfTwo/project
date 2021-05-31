function [g,h] = feixingpanduan(x)
%UNTITLED11 此处显示有关此函数的摘要
%   此处显示详细说明
date=[150,140,243;
    85,85,236;
    150,155,220.5;
    145,50,159;
    130,150,230;
    0,0,52];
a=[];b=[];c=[];d=[];
sb=zeros(6,2);
sb=sym(sb);
sb1=[x(1),x(2),x(3),x(4),x(5),x(6)]';
sb(:,3)=sb1;
date=date+sb;

for i=1:5
    a(i,1)=(4*800^2)*sin((date(i,3)-date(i+1,3))*pi/(2*180))
    b(i,1)=2*800*((date(i,1)-date(i+1,1))*(cos(date(i,3)*pi/180)-cos(date(i+1,3)*pi/180))+((date(i,2))-(date(i+1,2)))*((sin(date(i,3))*pi/180)-(sin(date(i+1,3))*pi/180)))
    c(i,1)=(date(i,1)-date(i+1,1))^2+(date(i,2)-date(i+1,2))^2-64
end
for i=1:5
    d(i,1)=b(i,1)^2-4*a(i,1)*c(i,1);
end
g=d;
h=[];
end

