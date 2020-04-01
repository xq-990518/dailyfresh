from django.conf.urls import url
from goods.views import IndexView, DetailView, GoodsListView

urlpatterns = [
    url(r'^index$', IndexView.as_view(), name='index'),  # 首页
    url(r'^goods/(?P<goods_id>\d+)$', DetailView.as_view(), name='detail'),  # 详情
    url(r'^list/(?P<type_id>\d+)/(?P<page>\d+)$', GoodsListView.as_view(), name='list'),  # 列表页

]
