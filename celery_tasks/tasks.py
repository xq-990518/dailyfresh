# -*- coding: UTF-8 -*-
# 或者  # coding=utf-8
# 使用celery
from celery import Celery

from django.core.mail import send_mail

from dailyfresh import settings


from django.template import loader, RequestContext

# django环境的初始化
import os
import django
# 在任务处理者一端加这几句
# 指定读取配置文件
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dailyfresh.settings')
# django环境初始化
django.setup()

import sys

sys.path.append('../')

from goods.models import GoodsType, IndexGoodsBanner, IndexPromotionBanner, IndexTypeGoodsBanner

# 创建一个Celery类的实例对象
app = Celery('celery_tasks.tasks', broker='redis://:990518@127.0.0.1:6379/8')


# 定义任务函数
@app.task
def send_register_active_email(to_email, username, token):
    '''发送激活邮件'''
    # 组织邮件信息
    # 发邮件
    # 主题信息
    subject = '天天生鲜欢迎信息'
    # 邮件正文
    # message = '<h1>%s,欢迎您成为天天生鲜注册会员</h1>请点击下面链接激活您的账户<br/><a href="http:192.168.1.13:8000/user/active/%s">http:192.168.1.13:8000/user/active/%s</a>' % (username, token, token)
    message = ''
    # 发件人
    sender = settings.DEFAULT_EMAIL_FORM
    # 收件人列表
    receiver = [to_email]
    html_msg = '<h1>%s,欢迎您成为天天生鲜注册会员</h1>请点击下面链接激活您的账户<br/><a href="http:192.168.0.144/user/active/%s">http:192.168.0.144/user/active/%s</a>' % (
        username, token, token)
    send_mail(subject, message, sender, receiver, fail_silently=False, html_message=html_msg)

# 定义任务函数
@app.task
def send_update_password_email(to_email, username,token):
    '''发送激活邮件'''
    # 组织邮件信息
    # 发邮件
    # 主题信息
    subject = '天天生鲜欢迎信息'
    # 邮件正文
    # message = '<h1>%s,欢迎您成为天天生鲜注册会员</h1>请点击下面链接激活您的账户<br/><a href="http:192.168.1.13:8000/user/active/%s">http:192.168.1.13:8000/user/active/%s</a>' % (username, token, token)
    message = ''
    # 发件人
    sender = settings.DEFAULT_EMAIL_FORM
    # 收件人列表
    receiver = [to_email]
    html_msg = '<h1>%s,欢迎您</h1>请点击下面链接修改您的账户密码<br/><a href="http:192.168.0.144/user/showUpdatePage/%s">http:192.168.0.144/user/showUpdatePage/%s</a>' % (
        username, token, token)
    send_mail(subject, message, sender, receiver, fail_silently=False, html_message=html_msg)

@app.task
def generate_static_index_html():
    '''产生首页静态页面'''

    # 获取商品品的种类信息
    types = GoodsType.objects.all()

    # 获取首页轮播商品信息
    goods_banners = IndexGoodsBanner.objects.all().order_by('index')

    # 获取首页促销活动信息
    promotion_banners = IndexPromotionBanner.objects.all().order_by('index')

    # 获取首页分类商品展示信息
    for type in types:
        # 获取type种类首页分类商品的图片展示信息
        image_banners = IndexTypeGoodsBanner.objects.filter(type=type, display_type=1)
        # 获取type种类首页分类商品的文字展示信息
        title_banners = IndexTypeGoodsBanner.objects.filter(type=type, display_type=0)

        # 动态给type增加属性,分别保存首页分类商品的图片展示信息和文字展示信息
        type.image_banners = image_banners
        type.title_banners = title_banners

    # 组织模板上下文
    context = {
        'types': types,
        'goods_banners': goods_banners,
        'promotion_banners': promotion_banners
    }

    # 使用模板
    # 1.加载模板文件,返回模板对象
    temp = loader.get_template('goods/static_index.html')
    # 2.定义模板上下文,可忽略
    # context = RequestContext(request, context)
    # 3.模板渲染
    static_index_html = temp.render(context)

    # 生成首页对应的静态文件
    save_path = os.path.join(settings.BASE_DIR, 'static/index.html')
    with open(save_path, 'w') as f:
        f.write(static_index_html)
