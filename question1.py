"""
程序目的：统计中文词频，并生成列表
程序编写：陈宇翔
时间2021/5/20/15：39
"""
import re
import collections
import jieba
import csv
import xlrd
"""
关于本程序的想法

需要实现功能如下：
读取excel文件获取所有各个景点名称，如"a01"、"a02" ==> 此处可通过列表去重函数实现 ==》即读取excel文件第一列，去除第一个元素后，去重即可
依次将各个景点/酒店的评论整理，并统计词频 PS：注意到此处景点和酒店的评论位置均位于第三列，此处可通过for循环实现
对每个景点生成对应的csv文件

"""

def creat_ciping(file):
    """

    :param file: txt文本名称
    :return:
    """
    fn = open('%s.txt'%(file),encoding='utf-8')  # 打开文件
    string_data = fn.read()  # 读出整个文件
    fn.close()  # 关闭文件
    # 文本预处理
    pattern = re.compile(u'\t|\n|\.|-|:|;|\)|\(|\?|"')  # 定义正则表达式匹配模式
    string_data = re.sub(pattern, '', string_data)  # 将符合模式的字符去除

    # 文本分词
    seg_list_exact = jieba.cut(string_data, cut_all=False)  # 精确模式分词
    object_list = []
    remove_words = [u'的', u'，', u'是', u'对', u'等', u'能', u'都', u'。', u' ', u'、', u'中', u'在', u'了',
                    u'！', u'*', u'小', u'元', u'5', u'说', u'…']  # 自定义去除词库

    for word in seg_list_exact:  # 循环读出每个分词
        if word not in remove_words:  # 如果不在去除词库中
            object_list.append(word)  # 分词追加到列表
    # 词频统计
    word_counts = collections.Counter(object_list)  # 对分词做词频统计
    word_counts_top100 = word_counts.most_common(100)  # 获取前100最高频的词
    # print (word_counts_top100) # 输出检查

    f = open('%s.csv'%(file), 'w', encoding='utf-8')
    csv_writer = csv.writer(f)
    csv_writer.writerow(['词语', '热度'])
    n = 0
    for i in word_counts_top100:
        i = list(i)
        if len(i[0]) >= 2:
            csv_writer.writerow(i)
            n = n + 1
            if n == 20:
                break

excel_file = xlrd.open_workbook('景区评论.xls')             # 打开Excel文件
table = excel_file.sheets()[0]
names=[]
word=str(table[1][2])
for i in table:
    i=i[0]
    i=str(i)
    i=i[-4:-1]
    names.append(i)
names=set(names)
names=list(names)
print(names)

for i in names:
    for line in table:
        title=str(line[0])
        title=title[-4:-1]
        words=str(line[2])
        words=words[6:]
        if title==i:
            with open('%s.txt'%(i),'a',encoding='utf-8') as www:
                www.write(words)

for i in range(1,10):
    namess='A0%s'%(i)
    creat_ciping(namess)

for i in range(10,51):
    namess='A%s'%(i)
    creat_ciping(namess)



