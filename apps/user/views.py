from django.http import HttpResponse
from django.shortcuts import render, redirect
import re
from django.views.generic import View, ListView
from django.urls import reverse
from user.models import User, Address
from goods.models import GoodsSKU
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from dailyfresh import settings
from itsdangerous import SignatureExpired
from celery_tasks.tasks import send_register_active_email
from django.contrib.auth import authenticate, login, logout
from utils.mixin import LoginRequiredMixin
from django.core.mail import send_mail, EmailMultiAlternatives
from django_redis import get_redis_connection


# Create your views here.


def register(request):
    '''显示注册页面'''
    if request.method == 'GET':
        # 显示注册页面
        return render(request, 'user/register.html')
    else:
        # 进行注册处理
        return register_handle(request)


def register_handle(request):
    '''进行注册处理'''
    # 接收数据
    username = request.POST.get('user_name')
    password = request.POST.get('pwd')
    pwd = request.POST.get('cpwd')
    email = request.POST.get('email')
    allow = request.POST.get('allow')

    # 进行数据校验
    if not all([username, password, email, pwd]):
        # 数据不完整
        return render(request, 'user/register.html', {'errmsg': '数据不完整'})

    # 校验邮箱
    if not re.match(r'^[a-z0-9][\w\.\-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):
        # 邮箱不合法
        return render(request, 'user/register.html', {'errmsg': '邮箱格式不正确'})

    if password != pwd:
        return render(request, 'user/register.html', {'errmsg': '两次密码不一致'})

    if allow != 'on':
        return render(request, 'user/register.html', {'errmsg': '请同意协议'})

    # 校验用户是否重复
    try:
        user = User.objects.get(username=username)
    except User.DoesNotExist:
        # 用户名不存在
        user = None

    if user:
        # 用户名已存在
        return render(request, 'user/register.html', {'errmsg': '用户名已存在'})

    # 进行业务处理,进行用户注册
    user = User.objects.create_user(username, email, password)
    user.is_active = 0
    user.save()

    # 返回应答,跳转到首页
    return redirect(reverse('goods:index'))


class RegisterView(ListView):
    '''注册'''

    def get(self, request):
        '''显示注册页面'''
        return render(request, 'user/register.html')

    def post(self, request):
        '''进行注册处理'''
        # 接收数据
        username = request.POST.get('user_name')
        password = request.POST.get('pwd')
        pwd = request.POST.get('cpwd')
        email = request.POST.get('email')
        allow = request.POST.get('allow')

        # 进行数据校验
        if not all([username, password, email, pwd]):
            # 数据不完整
            return render(request, 'user/register.html', {'errmsg': '数据不完整'})

        # 校验邮箱
        if not re.match(r'^[a-z0-9][\w\.\-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):
            # 邮箱不合法
            return render(request, 'user/register.html', {'errmsg': '邮箱格式不正确'})

        if password != pwd:
            return render(request, 'user/register.html', {'errmsg': '两次密码不一致'})

        if allow != 'on':
            return render(request, 'user/register.html', {'errmsg': '请同意协议'})

        # 校验用户是否重复
        try:
            user = User.objects.get(username=username)
        except User.DoesNotExist:
            # 用户名不存在
            user = None

        if user:
            # 用户名已存在
            return render(request, 'user/register.html', {'errmsg': '用户名已存在'})

        # 进行业务处理,进行用户注册
        user = User.objects.create_user(username, email, password)
        user.is_active = 0
        user.save()

        # 发送激活邮件,包含激活链接: http://192.168.1.13:8000/user/active/
        # 激活链接中需要包含用户的身份信息,并且要把身份信息进行加密

        # 加密用户的身份信息,生成激活的token
        # 设置加密的SECRET_KEY,以及过期时间1小时
        serializer = Serializer(settings.SECRET_KEY, 3600)
        info = {'confirm': user.id}
        token = serializer.dumps(info)
        token = token.decode('utf8')

        # 发邮件
        send_register_active_email.delay(email, username, token)
        # 返回应答,跳转到首页
        return redirect(reverse('goods:index'))


class ActiveView(ListView):
    '''用户激活'''

    def get(self, request, token):
        '''惊醒用户激活'''
        # 获取要激活的用户信息
        serializer = Serializer(settings.SECRET_KEY, 3600)
        try:
            info = serializer.loads(token)
            # 获取待激活用户的ID
            user_id = info['confirm']
            # 根据ID获取用户信息
            user = User.objects.get(id=user_id)
            user.is_active = 1
            user.save()
            # 跳转到登录页面
            return redirect(reverse('user:login'))
        except SignatureExpired as e:
            # 激活链接已过期
            return HttpResponse("激活链接已过期")


class LoginView(ListView):
    '''登录'''

    def get(self, request):
        '''显示登录页面'''
        # 判断是否记住了用户名
        if 'username' in request.COOKIES:
            username = request.COOKIES.get('username')
            checked = 'checked'
        else:
            username = ''
            checked = ''
        return render(request, 'user/login.html', {'username': username, 'checked': checked})

    def post(self, request):
        '''登录校验'''
        # 接收数据
        username = request.POST.get('username')
        password = request.POST.get('pwd')

        # 校验数据
        if not all([username, password]):
            return render(request, 'user/login.html', {'errmsg': '数据不完整'})

        # 业务处理:登录校验
        # user = User.objects.get(username=username, password=password)
        user = authenticate(username=username, password=password)
        if user is not None:
            # 用户名密码正确
            if user.is_active:
                # 用户已激活
                # 记录用户的登录状态
                login(request, user)

                # 获取用户登陆后所要跳转到的地址
                # 默认跳转到首页
                next_url = request.GET.get('next', reverse('goods:index'))

                # 跳转到next_url
                response = redirect(next_url)

                # 判断是否需要记住用户名
                remember = request.POST.get('remember')
                if remember == 'on':
                    # 记住用户名
                    response.set_cookie('username', username, max_age=3600 * 24 * 7)
                else:
                    response.delete_cookie('username')

                # 返回response
                return response
            else:
                return render(request, 'user/login.html', {'errmsg': '账户未激活'})
        else:
            return render(request, 'user/login.html', {'errmsg': '用户名或密码错误'})
        # 返回应答


class LogoutView(LoginView):
    '''退出登录'''

    def get(self, request):
        '''退出登录'''
        logout(request)
        # 跳转到首页
        return redirect(reverse('goods:index'))


class UserInfoView(LoginRequiredMixin, ListView):
    '''用户中心-信息页面'''

    def get(self, request):
        '''显示'''
        # request.user.is_authenticated:

        # 获取用户的个人信息
        user = request.user
        address = Address.objects.get_default_site(user)

        # 获取用户的历史浏览记录
        # from redis import StrictRedis
        # sr = StrictRedis(host='127.0.0.1', port=6379, db=9)
        conn = get_redis_connection('default')

        history_key = 'history_%d' % user.id
        # 获取用户最新浏览的5个商品id
        sku_ids = conn.lrange(history_key, 0, 4)
        # redis取出的数据[b'2',b'7']...
        # 使用列表推导式转成[2,7]...
        sku_ids = [int(sku_id) for sku_id in sku_ids]
        # print("sku_ids:%s" % sku_ids)
        # 从数据库中查询用户浏览的商品的具体信息
        goods_li = GoodsSKU.objects.filter(id__in=sku_ids)
        # 遍历获取用户浏览的商品信息
        goods_res = []
        for id in sku_ids:
            for goods in goods_li:
                if goods.id == id:
                    goods_res.append(goods)

        # 组织上下文
        # print("goods_res:%s" % goods_res)
        content = {'page': 'user', 'site': address, 'goods_li': goods_res}
        return render(request, 'user/user_center_info.html', content)


class UserOrderView(LoginRequiredMixin, ListView):
    '''用户中心-订单页面'''

    def get(self, request):
        '''显示'''

        # 获取用户的订单信息

        return render(request, 'user/user_center_order.html', {'page': 'order'})


class UserSiteView(LoginRequiredMixin, ListView):
    '''用户中心-地址信息页面'''

    def get(self, request):
        '''显示'''

        # 获取用户的默认收货地址信息
        user = request.user

        # try:
        #     address = Address.objects.get(user=user, is_default=True)  # models.Manager
        # except Address.DoesNotExist:
        #     # 不存在默认收货地址
        #     address = None
        address = Address.objects.get_default_site(user)
        return render(request, 'user/user_center_site.html', {'page': 'site', 'site': address})

    def post(self, request):
        '''添加地址'''
        # 接收数据
        receiver = request.POST.get('receiver')
        site = request.POST.get('site')
        zip_code = request.POST.get('zip_code')
        phone = request.POST.get('phone')

        # 校验数据
        # 检测数据完整性
        if not all([receiver, site, phone]):
            return render(request, 'user/user_center_site.html', {'errmsg': '数据不完整!'})
        if not re.match(r'^1[3|4|5|7|8][0-9]{9}$', phone):
            return render(request, 'user/user_center_site.html', {'errmsg': '手机格式不正确!'})

        # 业务处理(添加地址)　
        # 如果用户已存在默认收货地址，添加的地址不作为默认收货地址，否则作为默认收货地址
        # 获取登录用户
        user = request.user

        # try:
        #     address = Address.objects.get(user=user, is_default=True)
        # except Address.DoesNotExist:
        #     # 不存在默认收货地址
        #     address = None

        address = Address.objects.get_default_site(user)

        if address:
            is_default = False
        else:
            is_default = True

        # 添加地址
        Address.objects.create(user=user, receiver=receiver, addr=site, zip_code=zip_code, phone=phone,
                               is_default=is_default)
        # 返回应答，刷新地址页面
        return redirect(reverse('user:site'))
