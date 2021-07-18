"""
DP问题的综合讨论
着重讨论 DP算法 和 贪心算法
以及采取DP算法和贪心算法的异（例二）同（例一）点
时间 2021/7/18
"""
import numpy as np
"""
例一：
已知存在数 1 3 7 11，试求用这四个数凑出100（任意第n个数）并且使得使用数字数量最少的方案
题目来源：自己出的
"""

"""
算法进阶
要求返回所使用的方法（若有多种，返回一种即可）
"""

"""
for example:
要求数字 最少数量
1 1
2 2
3 1
4 2
5 3
6 2
7 1
8 2
9 3
10 2
11 1
12 2
我的思路：
之前有讲到过，在此不多赘述
时间复杂度为o(N)

由贪心算法角度出发，想要使用数量尽可能少，需要使得使用数字尽可能大，
但如果单从这个角度出发很快会意识到问题：
例如:
已有数字1、5、11
要凑出数字 15
若用11 则需要 11+1+1+1+1 共五个数字
若用5 只需要3个5即可
因此这个地方采用动态规划==>DP算法
"""
def solve(target):
    ans = np.zeros(target)
    ans = list(ans)
    w2 = ans.copy()
    w3 = ans.copy()
    w4=  ans.copy()
    ans[0] = 1.0
    w1 = ans.copy()
    for i in range(1,target):
        if i <2:
            ans[i] = ans[i - 1] + 1
            w1[i]=w1[i-1]+1
        elif i<6:
            ans[i] = min(ans[i - 1], ans[i - 3]) + 1
            if ans[i - 1]< ans[i - 3]:
                w1[i] = w1[i - 1] + 1
                w2[i]=w2[i-1]
            else:
                w2[i]=w2[i-3]+1
                w1[i]=w1[i-3]
        elif i <10:
            ans[i] = min(ans[i - 1], ans[i - 3], ans[i - 7]) + 1
            if ans[i-1] == min(ans[i-1],ans[i-3],ans[i-7]):
                w1[i]=w1[i-1]+1
                w2[i]=w2[i-1]
                w3[i]=w3[i-1]
            elif ans[i-3] == min(ans[i-1],ans[i-3],ans[i-7]):
                w1[i]=w1[i-3]
                w2[i]=w2[i-3]+1
                w3[i]=w3[i-3]
            else:
                w1[i]=w1[i-7]
                w2[i]=w2[i-7]
                w3[i]=w3[i-7]+1
        else:
            ans[i]=min(ans[i-1],ans[i-3],ans[i-7],ans[i-11])+1
            if ans[i-1] == min(ans[i-1],ans[i-3],ans[i-7],ans[i-11]):
                w1[i]=w1[i-1]+1
                w2[i]=w2[i-1]
                w3[i]=w3[i-1]
                w4[i]=w4[i-1]
            elif ans[i-3] == min(ans[i-1],ans[i-3],ans[i-7],ans[i-11]):
                w1[i]=w1[i-3]
                w2[i]=w2[i-3]+1
                w3[i]=w3[i-3]
                w4[i]=w4[i-3]
            elif ans[i-7] == min(ans[i-1],ans[i-3],ans[i-7],ans[i-11]):
                w1[i]=w1[i-7]
                w2[i]=w2[i-7]
                w3[i]=w3[i-7]+1
                w4[i]=w4[i-7]
            else:
                w1[i]=w1[i-11]
                w2[i]=w2[i-11]
                w3[i]=w3[i-11]
                w4[i]=w4[i-11]+1
    return [int(ans[target-1]),int(w1[target-1]),int(w2[target-1]),int(w3[target-1]),int(w4[target-1])]

target = input("请输入要求的数字")
target = int(target)
[ans0,ans1,ans2,ans3,ans4]=solve(target)
print("所需要的 1 数量为%d\n所需要的 3 数量为%d\n所需要的 7 数量为%d\n 所需要的 11 数量为%d\n总共需要的数量为%d\n"%(ans1,ans2,ans3,ans4,ans0))



"""
例题二 背包问题例题：
有N件物品和一个容量为V的背包。第i件物品的重量是w[i]，价值是v[i]。
求解将哪些物品装入背包可使这些物品的重量总和不超过背包容量，且价值总和最大。
"""

"""
翻译一下
有一数组A，数组A中每个元素的位置的权重对应数组B中对应元素
先从数组A中取出元素，试求一种取法使得在取出数字数量有限的情况下取出来的数加权最大
（即A中第i个元素为a，B中第i个元素为b，则取出的数大小记为a*b）
妈的怎么感觉越翻译越糊
"""
#条件输入
T_max,num_input=map(int,input().split())
T=np.zeros(num_input)
W=np.zeros(num_input)
T=list(T)
W=list(W)
for i in range(num_input):
    T[i],W[i]=map(int,input().split())

#开始作答
"""
易错点：：：：：：：：：：：：：：：：：：：

用贪心算法的错误思路：
定义K为单位时间内能获得的价值
并将K依次取出最大值，同时判断最大值对应的时间是否小于最大时间
依次遍历即可
容易发现，该算法时间复杂度为o(N)
"""
T=np.array(T)
W=np.array(W)
K=W/T
t=0
w=0
K=list(K)
k=K.copy()
for _ in range(num_input):
    ki =max(K)
    i=k.index(ki)
    if t+T[i]<=T_max:
        w= w + W[i]
        t= t + T[i]
    K.remove(ki)
print("能赚取的最大价值为%d"%(w))
"""
此算法未运用动态规划
看似合理，其实解法有误
eg:输入
60 3
2 10
29 30
30 30
运用此算法会返回40，然而很容易发现最优解为60
在此可以注意到贪心算法和动态规划算法两者的差异
在例一中，采用的是典型的动态规划算法，每一步决策取决于上一次的最佳决策
在例二的解答一中，我们采用的是贪心算法，即每次决策选取性价比最高的解答。

但是由于在此只关注了性价比，每一步都只考虑到了局部最优，所得到的解答并不一定是整体的全局最优！！！
接下来，我们讨论动态规划算法在本题例二的实现
"""


"""
我的DP算法（算法不优，时间复杂度较大）
考虑到n个输入事件的时间
可以用这n个时间构造出N个时间节点(利用简单的高中知识(二项式定理)可以发现，N=2**n-1)==> 故时间复杂度为(2**n)
N个时间节点可以分类为：
Cn1 Cn2 Cn3 …… Cnn
接下来利用例1中的DP方法即可


由于后面有优化，这部分可看可不看
"""
import numpy as np
from itertools import combinations
T_max,num_input=map(int,input().split())
T=np.zeros(num_input)
W=np.zeros(num_input)
T=list(T)
W=list(W)
for i in range(num_input):
    T[i],W[i]=map(int,input().split())
T=np.array(T)
W=np.array(W)
TT=np.array(T)
T=list(T)
W=list(W)
T_mat=[]
max00=0
num_input=np.zeros(num_input)
for i in range(len(T)+1):
    for j in combinations(T,i):
        p=sum(j)
        T_mat.append(p)
T_mat.remove(0)
T_mat=list(T_mat)
t=T_mat.copy()#获得N个时间节点
print(t)
tmax=max(t)
Time=np.zeros(tmax)
for i in t:
    Time[i-1]=1
Time=list(Time)
Weight=np.zeros(tmax)
for i in T:
    Tid=T.index(i)
    Weight[i-1]=W[Tid]
Weight=list(Weight)
#初始化完成，开始求解
for i in range(0,tmax):
    if Time[i] ==0:
        Weight[i]=Weight[i-1]
    else:
        P=i+1-TT
        for j in range(len(TT)):
            pp=P[j]-1
            tt=TT[j]-1
            max00=max(max00,Weight[pp]+Weight[tt])
        Weight[i]=max00
        max00=0
        for i in T:
            Tid = T.index(i)
            Weight[i - 1] = W[Tid]
        Weight = list(Weight)
if T_max>tmax:
    print(Weight[-1])
else:print(Weight[T_max-1])
"""
由于以上解答涉及时间复杂度较高
参考别人的解答后我的DP算法
原先50多行的代码换个算法秒变15行，时间复杂度也降下来了


方法同例一
采用递推式求解

此算法最巧妙的位置在于 逐渐增加选取品种的数量
刚开始只选取一种
随后选取2、3、4……
利用此关系进行递推
例如 选两种的时候，存在品种A、B
在可以加B的时候，考虑这个地方是选择加减少原有的A，选择加B；还是选择不做变化
"""
import numpy as np
T_max,num=map(int,input().split())
Time=[]
Worth=[]
for i in range(num):
    x,y=map(int,input().split())
    Time.append(x)
    Worth.append(y)
dp=np.zeros(shape=[num,1+T_max]) #解释一下为什么这个地方要乘以2 ==>在后续减1过程中会出现 减1的操作，这个时候可能会出现 -1，Python中对数组索引"-"表示倒数
for i in range(num):
    for j in range(T_max):
        if j >=Time[i]-1:
            dp[i,j]=max(dp[i-1,j],dp[i-1,j-Time[i]]+Worth[i])
        else:dp[i,j]=dp[i-1,j]
print(int(dp[num-1,T_max-1]))