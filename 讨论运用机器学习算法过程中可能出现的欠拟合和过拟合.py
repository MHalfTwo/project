import tensorflow as tf
"""
关于多项式拟合问题的讨论：
    选用函数 y = 3.5*x**3 + 2.4*x**2 -4.3*x-3.52
    讨论运用机器学习算法过程中可能出现的欠拟合和过拟合，
    以及可能出现极大极小的局部最优解
    并讨论学习率与其关系
"""
all_inputs,all_out,num_inputs,num_outs=100,100,75,75
lr=0.00001 #通过增大学习率可以增大极大极小的局部最优解出现概率 ==>即减小学习率并增多训练训练次数可以规避极大极小解的出现


#生成测试集和训练集
x=tf.random.normal(shape=[all_inputs,1])
y=3.5*x**3 + 2.4*x**2 -4.3*x-3.52
noise=tf.random.normal(shape=[all_inputs,1],stddev=0.1)
y +=noise

#初始化参数
# w1=w2=w3=tf.constant(0.1)
# b=tf.constant(0.0)
"""
运用三次函数拟合
"""
def sanci():
    w1 = w2 = w3 = tf.constant(0.1)
    b = tf.constant(0.0)
    for _ in range(400):
        for __ in range(20):
            with tf.GradientTape() as sigma:
                sigma.watch([w1,w2,w3,b])
                f=(w1*(x**3)+w2*(x**2)+w3*x+b-y)**2
            # dw1=f[__]*x[__]**3
            # dw2=f[__]*x[__]**2
            # dw3=f[__]*x[__]
            # db=f[__]
            # w1 = w1 - dw1*lr
            # w2 =w2 -dw2*lr
            # w3 =w3-dw3*lr
            # b =b- db*lr
            df=sigma.gradient(f,[w1,w2,w3,b])
            w1 = w1-df[0]*lr
            w2 =w2- df[1]*lr
            w3 =w3- df[2]*lr
            b =b- df[3]*lr
    fx=w1 * (x ** 3) + w2 * (x ** 2) + w3 * x + b
    p1=0;p2=0
    for i in range(10):
        p1=p1+fx[i]
        p2=p2+y[i]
    # print(w1)
    # print(w2)
    # print(w3)
    # print(b)
    ac=1-abs((p1-p2)/p2)
    print("三次拟合准确率为%f%%"%(100*ac))

"""
运用二次函数拟合
"""
def erci():
    w1 = w2 = w3 = tf.constant(0.1)
    b = tf.constant(0.0)
    for _ in range(400):
        for __ in range(20):
            with tf.GradientTape() as sigma:
                sigma.watch([w1,w2,w3,b])
                f=(w2*(x**2)+w3*x+b-y)**2
            # dw1=f[__]*x[__]**3
            # dw2=f[__]*x[__]**2
            # dw3=f[__]*x[__]
            # db=f[__]
            # w1 = w1 - dw1*lr
            # w2 =w2 -dw2*lr
            # w3 =w3-dw3*lr
            # b =b- db*lr
            df=sigma.gradient(f,[w2,w3,b])
            w2 =w2- df[0]*lr
            w3 =w3- df[1]*lr
            b =b- df[2]*lr
    fx = w2 * (x ** 2) + w3 * x + b
    p1 = 0;p2 = 0
    for i in range(10):
        p1 = p1 + fx[i]
        p2 = p2 + y[i]
    ac = 1 - abs((p1 - p2) / p2)
    print("二次拟合准确率为%f%%" % (100*ac))
sanci()
erci()