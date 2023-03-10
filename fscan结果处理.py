import os
import sys

def banner():
    print()
    print("="*60)
    print("fscan扫描的结果内容太多的话，可以用该脚本来显示带有[+]的信息。")
    print("="*60)
    print()

if len(sys.argv) < 2:
    banner()
    print("用法：python3 fscan处理结果.py result.txt [show-NetInfo]")
    exit()
elif not os.path.exists(sys.argv[1]):
    print("您输入的文件没有找到！")
    exit()

file = sys.argv[1]
if len(sys.argv) == 3 and sys.argv[2] == "show-NetInfo":
    with open(file,mode='r',encoding='utf-8') as f:
        flag = 0
        NetInfo_flag = 0
        for i in f:
            str = i.replace('\n','')
            str1 = str.lstrip()
            if str.startswith('[+] NetInfo'):
                print(str)
                NetInfo_flag = 1
            elif str.startswith('[+]') or NetInfo_flag:
                print(str)
                NetInfo_flag = 0
                flag = 1
            elif  flag and str1.startswith('[->]'):
                print(str)
            else:
                flag = 0
else:
    with open(file, mode='r', encoding='utf-8') as f:
        flag = 0
        for i in f:
            str = i.replace('\n', '')
            str1 = str.lstrip()
            if str.startswith('[+]') and (not str.startswith('[+] NetInfo')):
                print(str)
                flag = 1
            elif flag and str1.startswith('[->]'):
                print(str)
            else:
                flag = 0