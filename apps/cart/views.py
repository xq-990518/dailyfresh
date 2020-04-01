from django.shortcuts import render
from django.views.generic import ListView
from django.http import JsonResponse
from goods.models import GoodsSKU
from django_redis import get_redis_connection
from utils.mixin import LoginRequiredMixin


# Create your views here.

class CartAddView(ListView):
    '''购物车记录添加'''

    def post(self, requst):
        '''购物车记录添加'''
        # 接收数据
        user = requst.user
        if not user.is_authenticated:
            # 用户未登陆
            return JsonResponse({'res': 0, 'errmsg': '请先登录'})
        sku_id = requst.POST.get('sku_id')
        count = requst.POST.get('count')
        # 数据校验
        if not all([sku_id, count]):
            return JsonResponse({'res': 1, 'errmsg': '数据不完整'})
            # return JsonResponse({'code': 400, 'msg': '数据不完整', 'data': [], 'success': False})
        # 校验添加的商品数量
        try:
            count = int(count)
        except Exception as e:
            # 数目出错
            return JsonResponse({'res': 2, 'errmsg': '商品数目出错'})
            # return JsonResponse({'code': 400, 'msg': '商品数目出错', 'data': [], 'success': False})
        # 校验商品是否存在
        try:
            sku = GoodsSKU.objects.get(id=sku_id)
        except GoodsSKU.DoesNotExist:
            # 商品不存在
            return JsonResponse({'res': 3, 'errmsg': '商品不存在'})
            # return JsonResponse({'code': 500, 'msg': '商品不存在', 'data': [], 'success': False})
        # 业务处理:添加购物车记录
        conn = get_redis_connection('default')
        cart_key = 'cart_%d' % user.id
        # 先尝试获取sku_id的值 -> hget cart_key 属性
        # 如果sku_id在hash中不存在,hget返回None
        cart_count = conn.hget(cart_key, sku_id)
        if cart_count:
            # 累加购物车中商品的数目
            count += int(cart_count)
        if count > sku.stock:
            # 库存不足
            return JsonResponse({'res': 4, 'errmsg': '商品库存不足'})
        # 设置hash中sku_id对应的值
        # hset -> 如果sku_id已经存在,更新数据,如果sku_id不存在,添加数据
        conn.hset(cart_key, sku_id, count)
        # 计算用户购物车商品的条目数
        total_count = conn.hlen(cart_key)
        # 返回应答
        return JsonResponse({'res': 5, 'total_count': total_count, 'message': '添加成功'})


class CartInfoView(LoginRequiredMixin, ListView):
    '''购物车页面显示'''

    def get(self, request, *args, **kwargs):
        '''显示购物车'''
        # 获取登录用户
        user = request.user
        # 获取用户购物车中商品的信息
        conn = get_redis_connection('default')
        cart_key = 'cart_%d' % user.id
        # {'商品id':商品数量}
        cart_dict = conn.hgetall(cart_key)

        skus = []
        # 保存用户购物车中商品的总数目和总价格
        total_count = 0
        total_price = 0
        for sku_id, count in cart_dict.items():
            # 根据商品的id获取商品的信息
            sku = GoodsSKU.objects.get(id=sku_id)
            # 计算商品的小计
            amount = sku.price * int(count)
            # 动态给sku对象增加属性,amount保存商品小计
            sku.amount = amount
            # 动态给sku对象增加属性,count保存购物车中商品数量
            sku.count = int(count)
            skus.append(sku)
            # 累加计算商品的总数目和总价格
            total_count += int(count)
            total_price += amount
        # 组织上下文
        context = {
            'total_count': total_count,
            'total_price': total_price,
            'skus': skus
        }

        return render(request, 'cart/cart.html',context)
