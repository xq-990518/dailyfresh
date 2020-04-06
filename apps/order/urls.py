from django.conf.urls import url
from order.views import OrderPlaceView, OrderCommitView, OrderPayView, OrderCheckView, CommentView, OrderBuyPlaceView

urlpatterns = [
    url(r'^place$', OrderPlaceView.as_view(), name='place'),  # 提交订单页面显示
    url(r'^commit$', OrderCommitView.as_view(), name='commit'),  # 提交订单页面显示
    url(r'^pay$', OrderPayView.as_view(), name='pay'),  # 订单支付
    url(r'^check$', OrderCheckView.as_view(), name='check'),  # 获取支付结果
    url(r'^comment/(?P<order_id>.+)$', CommentView.as_view(), name='comment'),  # 订单评论
    url(r'^buy$', OrderBuyPlaceView.as_view(), name='buy'),  # 立即购买
]
