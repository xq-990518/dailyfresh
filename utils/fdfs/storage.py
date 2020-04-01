from django.core.files.storage import Storage
from fdfs_client.client import Fdfs_client,get_tracker_conf
from dailyfresh import settings

class FDFSStorage(Storage):
    '''fdfs文件存储类'''

    def __init__(self, client_conf=None, base_url=None):
        if client_conf == None:
            '''初始化'''
            client_conf = settings.CUSTOM_STORAGE_OPTIONS['CLIENT_CONF']
        self.client_conf = client_conf

        if base_url == None:
            '''初始化'''
            base_url = settings.CUSTOM_STORAGE_OPTIONS['BASE_URL']
        self.base_url = base_url

    def _open(self,name,mode='rb'):
        '''打开文件时使用'''
        pass

    def _save(self,name,content):
        '''保存文件时使用'''
         # name: 你选择的上传文件的名字
         # content: 包含你上传文件内容的file对象

         # 创建一个Fdfs_client对象
        client_conf_obj=get_tracker_conf(self.client_conf)
        print(client_conf_obj)
        client = Fdfs_client(client_conf_obj)

        # 上传文件到fastdfs系统中
        ret = client.upload_by_buffer(content.read())

        # dict
        # {
        #     'Group name': group_name,
        #     'Remote file_id': remote_file_id,
        #     'Status': 'Upload successed.',
        #     'Local file name': '',
        #     'Uploaded size': upload_size,
        #     'Storage IP': storage_ip
        # }
        if ret.get('Status')!='Upload successed.':
            # 上传失败
            raise Exception('上传文件到fastdfs失败')
        # 获取返回的文件ID
        filename=ret.get('Remote file_id')

        return filename.decode()

    def exists(self, name):
        '''Django判断文件名是否可用'''
        return False

    def url(self, name):
        '''返回 访问文件name 所需的url路径'''
        # django调用url方法时，所传递的 name参数：数据库 表中所存的 文件名字符串(即是，fastdfs中存储文件时 使用的文件名)
        return self.base_url + name