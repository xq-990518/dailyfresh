from django.conf.urls import url
from user import views
from user.views import RegisterView, ActiveView, LoginView, UserInfoView, UserOrderView, UserSiteView, LogoutView
from django.contrib.auth.decorators import login_required

urlpatterns = [
    # url(r'^register$', views.register, name='register'), # 用户注册页面以及用户注册
    # url(r'^register_handle$', views.register_handle, name='register_handle'),
    url(r'^register$', RegisterView.as_view(), name='register'),
    url(r'^active/(?P<token>.*)$', ActiveView.as_view(), name='active'),  # 用户激活
    url(r'^login$', LoginView.as_view(), name='login'),  # 登录
    # url(r'^$', login_required(UserInfoView.as_view()), name='user'),  # 用户信息页面
    # url(r'^order$', login_required(UserOrderView.as_view()), name='order'),  # 用户订单页面
    # url(r'^site$', login_required(UserSiteView.as_view()), name='site'),  # 用户地址页面
    url(r'^$', UserInfoView.as_view(), name='user'),  # 用户信息页面
    url(r'^order/(?P<page>\d+)$', UserOrderView.as_view(), name='order'),  # 用户订单页面
    url(r'^site$', UserSiteView.as_view(), name='site'),  # 用户地址页面
    url(r'^logout$', LogoutView.as_view(), name='logout'),  # 退出登录
]
