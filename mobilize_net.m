%{
编写时间：2021/5/18
程序目的：调用已训练的神经网络进行图像分类
程序作者：工程技术学院 土木二班 陈宇翔
%}
object=imread('神经网络测试/ceshi.bmp')%读取bmp格式图片
% object=imread('神经网络测试/ceshi.jpg')%读取jpg格式图片
sz =trainedNetwork_1.Layers(1).InputSize %获取网络对应的图片大小参数
object= imresize(object,sz(1:2)); %改变图片大小
figure %打开视窗
imshow(object) %显示图片
classify(trainedNetwork_1,object) %调用已训练网络对图片分类