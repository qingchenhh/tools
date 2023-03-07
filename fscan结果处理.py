import os
import sys

if len(sys.argv) < 2:
    print("请输入一个fscan结果文件！")
    exit()
elif not os.path.exists(sys.argv[1]):
    print("您输入的文件没有找到！")
    exit()

file = sys.argv[1]

with open(file,mode='r',encoding='utf-8') as f:
    flag = 0
    for i in f:
        str = i.replace('\n','')
        str1 = str.lstrip()
        if str.startswith('[+]'):
            print(str)
            flag = 1
        elif  flag and str1.startswith('[->]'):
            print(str)
        else:
            flag = 0
