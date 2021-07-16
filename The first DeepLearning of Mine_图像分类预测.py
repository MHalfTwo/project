from mxnet import nd, autograd
import d2lzh as d2l
from  mxnet.gluon import loss as gloss
from time import time
"""
时间 2021/7/15
程序作者 Cobain Chen
卷积神经网络
我的第一个深度学习初尝试
此处选用三个隐藏层
"""
start=time()
batch_size=100 #配置批量超参数
lr=0.5 #定义学习率超参数
num_epochs=5 #定义训练次数超参数


train_iter,test_iter=d2l.load_data_fashion_mnist(batch_size) #获取数据集
num_inputs,num_outputs,num_hiddens1,num_hiddens2,num_hiddens3=784,10,50,50,100


w1=nd.random_normal(scale=0.01,shape=(num_inputs,num_hiddens1))
b1=nd.zeros(shape=(num_hiddens1))
w2=nd.random_normal(scale=0.1,shape=(num_hiddens1,num_hiddens2))
b2=nd.zeros(shape=(num_hiddens2))
w3=nd.random_normal(scale=0.1,shape=(num_hiddens2,num_hiddens3))
b3=nd.zeros(num_hiddens3)
w4=nd.random_normal(scale=0.1,shape=(num_hiddens3,num_outputs))
b4=nd.zeros(num_outputs)#初始化系数


parms=[w1,b1,w2,b2,w3,b3,w4,b4] #定义系数矩阵
for parm in parms:
    parm.attach_grad() #储存变量，准备求梯度



def eva1(x):
    """
    定义激活函数
    eva1(x)==tanh(x)
    :param x: x
    :return: tanh(x)
    """
    m=nd.tanh(x)
    return m

def eva2(x):
    """
    定义激活函数
    ReLU(x)==Sigma(x)==>1/(1+(exp(-x)))
    :param x: x
    :return: Sigma(x)
    """
    m=(-x).exp()
    m=1/(1+m)
    return m

def eva3(x):
    """
    定义激活函数
    eva3(x)==>ReLU(x)==max(x,0)
    :param x: x
    :return: ReLU(x)
    """
    return nd.maximum(x,0)

def net(X):
    """
    定义模型
    输入层 ==> 隐藏层 1 ==> 隐藏层 2 ==>隐藏层 3 ==>输出层
    X ==> tanh(X*w1+b1) ==>Sigma(w2*tan(x*w1+b1)+b2) ==>ReLU(w3*(w2*Sigma(tan(w1*x+b1)+b2))+b3)
    ==>w4*ReLU(w3*(w2*Sigma(tan(w1*x+b1)+b2))+b3)+b4
    激活函数用于将原本简单的线性关系复杂化==>转化为非线性
    选用激活函数：tanh(x),Sigma(x),ReLU(x)
    """
    X=X.reshape((-1,num_inputs))
    H=eva1(nd.dot(X,w1)+b1)
    H=eva2(nd.dot(H,w2)+b2)
    H=eva3(nd.dot(H,w3)+b3)
    H=nd.dot(H,w4)+b4
    return H


loss=gloss.SoftmaxCrossEntropyLoss() # ==>定义损失函数
"""
开始训练
"""
d2l.train_ch3(net,train_iter,train_iter,loss,num_epochs,batch_size,parms,lr)
final=time()-start
print("训练用时%f秒"%(final))
