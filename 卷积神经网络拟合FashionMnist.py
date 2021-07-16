from mxnet import nd, autograd
import d2lzh as d2l
from  mxnet.gluon import loss as gloss
from time import time
"""
时间 2021/7/15
程序作者 Cobain Chen
卷积神经网络初尝试
"""
start=time()
batch_size=100 #配置批量超参数
lr=0.5 #定义学习率超参数
num_epochs=5 #定义训练次数超参数


train_iter,test_iter=d2l.load_data_fashion_mnist(batch_size) #获取数据集
num_inputs,num_outputs,num_hiddens=784,10,50


w1=nd.random_normal(scale=0.01,shape=(num_inputs,num_hiddens))
b1=nd.zeros(shape=(num_hiddens))
w2=nd.random_normal(scale=0.1,shape=(num_hiddens,num_outputs))
b2=nd.zeros(shape=(num_outputs)) #初始化系数
parms=[w1,b1,w2,b2] #定义系数矩阵


for parm in parms:
    parm.attach_grad() #储存变量，准备求梯度


def relu(x):
    """
    定义激活函数
    ReLU(x)==max(x,0)
    :param x: x
    :return: ReLU(x)
    """
    return nd.maximum(x,0)

def net(X):
    """
    定义模型
    输入层 ==> 隐藏层 ==> 输出层
    X ==> ReLU(X*w1+b1) ==>ReLU(x*w1+b1)*w2+b2
    ReLU(x)用于将原本简单的线性关系复杂化==>转化为非线性
    """
    X=X.reshape((-1,num_inputs))
    H=relu(nd.dot(X,w1)+b1)
    # H=nd.dot(H,w2)+b2
    H=relu(nd.dot(H,w2)+b2)
    return H


loss=gloss.SoftmaxCrossEntropyLoss() # ==>定义损失函数

"""
开始训练
"""
d2l.train_ch3(net,train_iter,train_iter,loss,num_epochs,batch_size,parms,lr)
final=time()-start
print("训练用时%f秒"%(final))