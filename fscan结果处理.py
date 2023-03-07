import os
import sys

print()
print("="*60)
print("fscan扫描的结果内容太多的话，可以用该脚本来显示带有[+]的信息。")
print("="*60)
print()

if len(sys.argv) < 2:
    print("请输入一个fscan结果文件！")
    print("用法：python3 fscan处理结果.py result.txt")
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