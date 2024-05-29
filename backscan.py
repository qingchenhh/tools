exts = ['.zip','.rar','.7z','.gz','.tar','.tar.gz','.tar.bz2','.bz2','.sql','.sql.tar.gz','.sql.gz','.sql.bz2']
file_name = ['www','temp','wwwroot','web','1','2022','2023','2024','0','root','data','database','back','backup','backups','admin','webapps','backupdata']
paths = ['/','/admin/','/backup/','/data/','/db/','/back/']
count = 0
for path in paths:
    for ext in exts:
        for name in file_name:
            filename = path + name + ext
            count += 1
            print(filename)
print(count)
# for ext in exts:
#     for name in file_name:
#         filename = 'D:\\phpstudy_pro\\WWW\\back\\' + name + ext
#         with open(filename,mode='w',encoding='utf-8') as f:
#             f.write('')
#         # print(filename)
