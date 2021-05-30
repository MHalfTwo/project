import requests
from bs4 import BeautifulSoup
import jieba
import collections
from pyecharts import Map
import csv
"""
程序目的：获取各个省份名人数量分布，并输出名人对应信息csv文件
程序作者：Cobain_Chen
"""
diqu=['河北','山西','辽宁','吉林','黑龙江','江苏','浙江','安徽','福建','江西','山东','河南','湖北','湖南','广东','海南','四川','贵州','云南','陕西','甘肃','青海','台湾','内蒙古','广西','西藏','宁夏','新疆','北京','天津','上海','重庆']
#受模块限制，暂不包含中国香港和中国澳门
wangzhi=[]
renwudiqu=[]
yinshe={}
diquduiying={}


url0=['http://www.gerenjianli.com/Mingren/Tags/166/','http://www.gerenjianli.com/Mingren/Tags/5943/','http://www.gerenjianli.com/Mingren/Tags/320/','http://www.gerenjianli.com/Mingren/Tags/6574/','http://www.gerenjianli.com/Mingren/Tags/148/','http://www.gerenjianli.com/Mingren/Tags/461/','http://www.gerenjianli.com/Mingren/Tags/6219/','http://www.gerenjianli.com/Mingren/Tags/144/','http://www.gerenjianli.com/Mingren/Tags/5966/','http://www.gerenjianli.com/Mingren/Tags/693/','http://www.gerenjianli.com/Mingren/Tags/6328/','http://www.gerenjianli.com/Mingren/Tags/6540/','http://www.gerenjianli.com/Mingren/Tags/309/','http://www.gerenjianli.com/Mingren/Tags/153/','http://www.gerenjianli.com/Mingren/Tags/5934/','http://www.gerenjianli.com/Mingren/Tags/5933/','http://www.gerenjianli.com/Mingren/Tags/150/']
def creat_wangzhi(url):
    """
    该函数用于创建所有名人对于网站的url的列表
    :param url:网站地址
    :return:
    """
    r = requests.get(url)
    r.encoding = 'gbk'
    connet = r.text
    bf = BeautifulSoup(connet, features="html.parser")
    texts = bf.find_all('div', class_="title")
    for i in range(100):
        a_bf = BeautifulSoup(str(texts[i]), features="html.parser")
        a = a_bf.find_all('a')
        wangzhi.append(str(a)[10:63])
        yinshe[str(a)[81:-5]]=str(a)[10:63]

def tongjimingrerndiqu(yinshe):
    for i in yinshe:
        url=yinshe[i]
        r = requests.get(url)
        r.encoding = 'gbk'
        connet = r.text
        bf = BeautifulSoup(connet, features="html.parser")
        texts = bf.find_all('p')  # 提取人物背景
        texts = list(texts)
        texts = str(texts)
        texts = texts.replace('<p>', '\n')
        texts = texts.replace('</p>,', '')
        texts = texts.replace('[', '')
        texts = texts.replace(']', '')
        jianli = texts.split("\n")[2:3]  # 提取人物简历
        for each_area in diqu:
            if each_area in str(jianli):
                diquduiying[i]=each_area

def panduandiqu(url):
    """
    该函数用于将各个类型的名人出生地汇总，并对数量统计
    :param url:网站地址
    :return:
    """
    r = requests.get(url)
    r.encoding = 'gbk'
    connet=r.text
    bf=BeautifulSoup(connet,features="html.parser")
    texts = bf.find_all('p') #提取人物背景
    texts=list(texts)
    texts=str(texts)
    texts=texts.replace('<p>','\n')
    texts=texts.replace('</p>,','')
    texts=texts.replace('[','')
    texts=texts.replace(']','')
    jianli=texts.split("\n")[2:3] #提取人物简历
    for i in diqu:
        if i in str(jianli):
            renwudiqu.append(i)

for i in url0:
    creat_wangzhi(i)

for i in wangzhi:
    panduandiqu(i)

tongjimingrerndiqu(yinshe)
f = open('名人对应地区.csv','w',encoding='utf-8')
csv_writer = csv.writer(f)
csv_writer.writerow(['人物','地区'])
for i in diquduiying :
    csv_writer.writerow([i,diquduiying[i]])
print('csv文件生成完毕，正在生成对应地图')
province_distribution=collections.Counter(renwudiqu)
province = list(province_distribution.keys())
num = list(province_distribution.values())
chinaMap = Map(width=1200, height=600)
chinaMap.add(name="名人分布数量",
             attr=province,
             value=num,
             visual_range=[0, 239],
             maptype='china',
             is_visualmap=True)
chinaMap.render(path="中国地图.html")
print('对应的地图生成完毕')