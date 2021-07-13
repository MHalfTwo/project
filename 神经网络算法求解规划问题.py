import numpy as np
from mxnet import autograd,nd
from time import time
from matplotlib import pyplot as plt
import random
"""
程序用于应用神经网络算法求解线性规划问题
程序作者：Cobain Chen
时间：2021/7/12
"""

start=time() #计时
def loss(w,x,b,y_true):
    """
    用于定义与计算损失函数的数值
    :param w:参数
    :param x:自变量
    :param b:参数
    :return:损失函数的数值
    """

    def pre(w, x, b):
        """
        函数内函数
        用于根据已有参数计算预测值
        :param w:
        :param x:
        :param b:
        :return:
        """
        a = w[0] * x[:, 0] + w[1] * x[:, 1] + b[0]
        return a

    c=((y_true-pre(w,x,b))**2)*0.5
    return c


num_inputs=2
num_examples=1000
true_w=[2,-3.4] #标准参数
true_b=4.2

lr=0.0001 #定义学习率
num_epoch=100 #定义循环次数


"""
下面这段代码用于创建数据集和对应标签
"""
features=nd.random.normal(scale=1,shape=(num_examples,num_inputs))
labels=true_w[0]*features[:,0]+true_w[1]*features[:,1]+true_b
labels +=nd.random.normal(scale=0.01,shape=labels.shape)
# print(labels) #画图
# plt.scatter(features[:,1].asnumpy(),labels.asnumpy())



w=nd.ones((2,1));b=nd.ones((1,1)) #初始化参数

for i in range(num_epoch):
    """
    开始循环
    """
    w.attach_grad()
    b.attach_grad()
    with autograd.record():
        los = loss(w, features, b, labels)
    los.backward()
    w =w- w.grad * lr
    b =b- b.grad * lr

w1=w.asnumpy()[0][0]
w2=w.asnumpy()[1]
b0=b.asnumpy()[0][0]
usetime=time()-start
print("\n对应的表达式为 f(x1,x2) = %f x1 + %f x2 + %f\n训练次数为%d次,学习率为%f"%(w1,w2,b0,num_epoch,lr))
print("所用时间为%f秒"%(usetime))