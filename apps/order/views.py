# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.views.generic import ListView
from django.urls import reverse
from django.shortcuts import render, redirect
from django.http import JsonResponse
from django.db import transaction
from django.conf import settings
import os

from goods.models import GoodsSKU
from user.models import Address
from order.models import OrderInfo, OrderGoods

from django_redis import get_redis_connection
from utils.mixin import LoginRequiredMixin
from datetime import datetime
# 支付宝支付SDK
from alipay import AliPay


# Create your views here.
class OrderPlaceView(LoginRequiredMixin, ListView):
    '''提交订单页面显示'''

    def post(self, request):
        '''提交订单页面显示'''

        # 获取登录用户
        user = request.user

        # 获取参数sku_ids
        sku_ids = request.POST.getlist('sku_ids')
        # 校验参数
        if not sku_ids:
            # 跳转到购物车页面
            return redirect(reverse('cart:show'))

        conn = get_redis_connection('default')
        cart_key = 'cart_%d' % user.id
        skus = []
        # 保存商品的总件数和总价格
        total_count = 0
        total_price = 0
        # 遍历sku_ids获取用户要购买的商品的信息
        for sku_id in sku_ids:
            # 根据商品的id获取商品的信息
            sku = GoodsSKU.objects.get(id=sku_id)
            # 获取用户所要购买的商品的数量
            count = conn.hget(cart_key, sku_id)
            count = int(count)
            # 计算商品的小计
            amount = sku.price * count
            # 动态增加属性,count(保存购买商品的数量),amount(保存购买商品的小计)
            sku.count = count
            sku.amount = amount
            # 追加
            skus.append(sku)
            # 累加计算商品的总件数和总价格
            total_count += count
            total_price += amount

        # 运费:实际开发的时候,属于一个子系统
        transit_price = 10

        # 实付款
        total_pay = total_price + transit_price

        # 获取用户的收件地址
        addrs = Address.objects.filter(user=user)

        sku_ids = ','.join(sku_ids)
        # 组织上下文
        context = {
            'skus': skus,
            'total_count': total_count,
            'total_price': total_price,
            'transit_price': transit_price,
            'total_pay': total_pay,
            'addrs': addrs,
            'sku_ids': sku_ids
        }
        # 使用模板
        return render(request, 'order/place_order.html', context)

# 购买商品
class OrderBuyPlaceView(LoginRequiredMixin, ListView):
    '''立即购买'''

    def post(self, request):
        '''提交订单页面显示'''

        # 获取登录用户
        user = request.user

        # 获取参数sku_id
        sku_id = request.POST.get('sku_id')

        count = request.POST.get('total_count')
        # 校验参数
        if not all([sku_id, count]):
            # 跳转到购物车页面
            return redirect(reverse('goods:index'))

        # 保存商品的总件数和总价格
        total_count = count
        total_price = 0
        # 遍历sku_ids获取用户要购买的商品的信息
        skus=[]
        # 根据商品的id获取商品的信息
        sku = GoodsSKU.objects.get(id=sku_id)
        # 获取用户所要购买的商品的数量
        # 计算商品的小计
        amount = sku.price * int(total_count)
        # 动态增加属性,count(保存购买商品的数量),amount(保存购买商品的小计)
        sku.count = total_count
        sku.amount = amount
        # 追加
        skus.append(sku)
        total_price += amount

        # 运费:实际开发的时候,属于一个子系统
        transit_price = 10

        # 实付款
        total_pay = total_price + transit_price

        # 获取用户的收件地址
        addrs = Address.objects.filter(user=user)

        sku_ids = ','.join(sku_id)
        print("sku_ids:%s" % sku_ids)
        # 组织上下文
        context = {
            'skus': skus,
            'total_count': total_count,
            'total_price': total_price,
            'transit_price': transit_price,
            'total_pay': total_pay,
            'addrs': addrs,
            'sku_ids': sku_ids
        }
        # 使用模板
        return render(request, 'order/place_order.html', context)


# 乐观锁
# 冲突比较少的时候使用乐观锁
# 乐观所重复操作的代价比较大
class OrderCommitView(ListView):
    '''订单创建'''

    @transaction.atomic
    def post(self, request):
        '''订单创建'''
        # 判断用户是否登录
        user = request.user
        if not user.is_authenticated:
            # 用户未登录
            return JsonResponse({'res': 0, 'errmsg': '用户未登录'})

        # 接收参数
        addr_id = request.POST.get('addr_id')
        pay_method = request.POST.get('pay_method')
        sku_ids = request.POST.get('sku_ids')

        # 校验参数
        if not all([addr_id, pay_method, sku_ids]):
            return JsonResponse({'res': 1, 'errmsg': '数据不完整'})

        # 校验支付方式
        if pay_method not in OrderInfo.PAY_METHODS.keys():
            return JsonResponse({'res': 2, 'errmsg': '非法的支付方式'})

        # 校验地址
        try:
            addr = Address.objects.get(id=addr_id)
        except Address.DoesNotExist:
            return JsonResponse({'res': 3, 'errmsg': '非法地址'})

        # todo: 创建订单核心业务
        # order_id total_count total_price transit_price
        # 订单id: 20200404153300+用户id
        order_id = datetime.now().strftime('%Y%m%d%H%M%S') + str(user.id)
        # 运费
        transit_price = 10
        # 总数目和总金额
        total_count = 0
        total_price = 0

        # 设置事务保存点
        save_id = transaction.savepoint()
        try:
            # todo: 向df_order_info表中添加一条记录
            order = OrderInfo.objects.create(
                order_id=order_id,
                user=user,
                addr=addr,
                pay_method=pay_method,
                total_count=total_count,
                total_price=total_price,
                transit_price=transit_price
            )
            # todo: 用户的订单中有几个商品,需要向df_order_goods表中加入几行记录
            conn = get_redis_connection('default')
            cart_key = 'cart_%d' % user.id

            sku_ids = sku_ids.split(',')
            for sku_id in sku_ids:
                for i in range(3):
                    # 获取商品的信息
                    try:
                        sku = GoodsSKU.objects.get(id=sku_id)
                    except GoodsSKU.DoesNotExist:
                        # 商品不存在
                        transaction.savepoint_rollback(save_id)
                        return JsonResponse({'res': 4, 'errmsg': '商品不存在'})
                    # 从redis中获取用户所要购买的商品的数量
                    count = conn.hget(cart_key, sku_id)
                    count = int(count)

                    # todo: 判断商品的库存
                    if count > sku.stock:
                        transaction.savepoint_rollback(save_id)
                        return JsonResponse({'res': 6, 'errmsg': '商品库存不足'})

                    # todo: 更新商品的库存和销量
                    # 更新
                    orgin_stock = sku.stock
                    new_stock = orgin_stock - count
                    new_sales = sku.sales + count

                    print('user:%d times:%d stock:%d' % (user.id, i, sku.stock))
                    # import time
                    # time.sleep(10)
                    # update df_goods_sku set stock = new_stock , sales=new_sales
                    # where id=sku_id and stock=orgin_stock
                    # 返回受影响的行数
                    res = GoodsSKU.objects.filter(id=sku_id, stock=orgin_stock).update(stock=new_stock, sales=new_sales)
                    if res == 0:
                        if i == 2:
                            # 尝试的第三次
                            transaction.savepoint_rollback(save_id)
                            return JsonResponse({'res': 7, 'errmsg': '下单失败'})
                        continue
                    # todo: 向df_order_goods表中添加记录
                    OrderGoods.objects.create(
                        order=order,
                        sku=sku,
                        count=count,
                        price=sku.price
                    )

                    # todo: 累加计算订单商品的总数量和总价格
                    amount = sku.price * count
                    total_count += count
                    total_price += amount

                    # 跳出循环
                    break

                # 更新订单信息表中的商品总数量和总价格
                order.total_count = total_count
                order.total_price = total_price
                # 更新
                order.save()
        except Exception as e:
            transaction.savepoint_rollback(save_id)
            return JsonResponse({'res': 7, 'errmsg': '下单失败'})

        # 提交事务
        transaction.savepoint_commit(save_id)
        # todo: 清除用户购物车中对应的记录
        # *[] -> 拆包
        # *[1,2] -> 1,2
        conn.hdel(cart_key, *sku_ids)
        return JsonResponse({'res': 5, 'msg': '创建订单成功'})


# 悲观锁
class OrderCommitView1(ListView):
    '''订单创建'''

    @transaction.atomic
    def post(self, request):
        '''订单创建'''
        # 判断用户是否登录
        user = request.user
        if not user.is_authenticated:
            # 用户未登录
            return JsonResponse({'res': 0, 'errmsg': '用户未登录'})

        # 接收参数
        addr_id = request.POST.get('addr_id')
        pay_method = request.POST.get('pay_method')
        sku_ids = request.POST.get('sku_ids')

        # 校验参数
        if not all([addr_id, pay_method, sku_ids]):
            return JsonResponse({'res': 1, 'errmsg': '数据不完整'})

        # 校验支付方式
        if pay_method not in OrderInfo.PAY_METHODS.keys():
            return JsonResponse({'res': 2, 'errmsg': '非法的支付方式'})

        # 校验地址
        try:
            addr = Address.objects.get(id=addr_id)
        except Address.DoesNotExist:
            return JsonResponse({'res': 3, 'errmag': '非法地址'})

        # todo: 创建订单核心业务
        # order_id total_count total_price transit_price
        # 订单id: 20200404153300+用户id
        order_id = datetime.now().strftime('%Y%m%d%H%M%S') + str(user.id)
        # 运费
        transit_price = 10
        # 总数目和总金额
        total_count = 0
        total_price = 0

        # 设置事务保存点
        save_id = transaction.savepoint()
        try:
            # todo: 向df_order_info表中添加一条记录
            order = OrderInfo.objects.create(
                order_id=order_id,
                user=user,
                addr=addr,
                pay_method=pay_method,
                total_count=total_count,
                total_price=total_price,
                transit_price=transit_price
            )
            # todo: 用户的订单中有几个商品,需要向df_order_goods表中加入几行记录
            conn = get_redis_connection('default')
            cart_key = 'cart_%d' % user.id
            sku_ids = sku_ids.split(',')
            for sku_id in sku_ids:
                # 获取商品的信息
                try:
                    # select * from df_goods_sku where id = sku_id for update;
                    sku = GoodsSKU.objects.select_for_update().get(id=sku_id)
                except GoodsSKU.DoesNotExist:
                    # 商品不存在
                    transaction.savepoint_rollback(save_id)
                    return JsonResponse({'res': 4, 'errmsg': '商品不存在'})
                # 从redis中获取用户所要购买的商品的数量
                count = conn.hget(cart_key, sku_id)
                count = int(count)

                # todo: 判断商品的库存
                if count > sku.stock:
                    transaction.savepoint_rollback(save_id)
                    return JsonResponse({'res': 6, 'errmsg': '商品库存不足'})

                # todo: 向df_order_goods表中添加记录
                OrderGoods.objects.create(
                    order=order,
                    sku=sku,
                    count=count,
                    price=sku.price
                )

                # todo: 更新商品的库存和销量
                sku.stock -= count
                sku.sales += count
                # 更新
                sku.save()

                # todo: 累加计算订单商品的总数量和总价格
                amount = sku.price * count
                total_count += count
                total_price += amount

                # 更新订单信息表中的商品总数量和总价格
                order.total_count = total_count
                order.total_price = total_price
                # 更新
                order.save()
        except Exception as e:
            transaction.savepoint_rollback(save_id)
            return JsonResponse({'res': 7, 'errmsg': '下单失败'})

        # 提交事务
        transaction.savepoint_commit(save_id)
        # todo: 清除用户购物车中对应的记录
        # *[] -> 拆包
        # *[1,2] -> 1,2
        conn.hdel(cart_key, *sku_ids)
        return JsonResponse({'res': 5, 'msg': '创建订单成功'})


class OrderPayView(ListView):
    '''订单支付'''

    def post(self, request):
        '''订单支付'''
        # 用户是否登录
        user = request.user
        if not user.is_authenticated:
            return JsonResponse({'res': 0, 'errmsg': '用户未登陆'})
        # 接收参数
        order_id = request.POST.get('order_id')

        # 校验参数
        if not order_id:
            return JsonResponse({'res': 1, 'errmsg': '无效的订单id'})

        try:
            order = OrderInfo.objects.get(
                order_id=order_id,
                user=user,
                pay_method=3,
                order_status=1
            )
        except OrderInfo.DoesNotExist:
            return JsonResponse({'res': 2, 'errmsg': '订单错误'})

        # 业务处理:使用python-sdk 调用支付宝的支付接口
        # 初始化
        # 获取公私钥字符串
        public_path = os.path.join(settings.BASE_DIR, 'apps/order/alipay_public_key.pem')
        private_path = os.path.join(settings.BASE_DIR, 'apps/order/app_private_key.pem')
        app_private_key_string = open(private_path).read()
        alipay_public_key_string = open(public_path).read()
        alipay = AliPay(
            appid="2016102300746158",  # 应用ID,没上线则为沙箱ID
            app_notify_url=None,  # 默认回调url
            app_private_key_string=app_private_key_string,  # 私钥
            alipay_public_key_string=alipay_public_key_string,  # 支付宝公钥
            sign_type="RSA2",
            debug=True,  # 上线则改为False , 沙箱True
        )
        # 调用接口(传参订单号和总价,标题)
        total_pay = order.total_price + order.transit_price  # Decimal
        order_string = alipay.api_alipay_trade_page_pay(
            out_trade_no=order_id,  # 订单id
            total_amount=str(total_pay),  # 总金额
            # subject='支付订单:%s' % order_id,
            subject='天天生鲜%s' % order_id,
            return_url=None,
            notify_url=None,  # 可选,不填则使用默认notify url
        )

        # 拼接应答地址
        pay_url = 'https://openapi.alipaydev.com/gateway.do?' + order_string

        # 返回应答
        return JsonResponse({'res': 3, 'pay_url': pay_url})


class OrderCheckView(ListView):
    '''查看订单支付的结果'''

    def post(self, request):
        '''查询支付结果'''
        # 用户是否登录
        user = request.user
        if not user.is_authenticated:
            return JsonResponse({'res': 0, 'errmsg': '用户未登陆'})
        # 接收参数
        order_id = request.POST.get('order_id')

        # 校验参数
        if not order_id:
            return JsonResponse({'res': 1, 'errmsg': '无效的订单id'})

        try:
            order = OrderInfo.objects.get(
                order_id=order_id,
                user=user,
                pay_method=3,
                order_status=1
            )
        except OrderInfo.DoesNotExist:
            return JsonResponse({'res': 2, 'errmsg': '订单错误'})

        # 业务处理:使用python-sdk 调用支付宝的支付接口
        # 初始化
        # 获取公私钥字符串
        public_path = os.path.join(settings.BASE_DIR, 'apps/order/alipay_public_key.pem')
        private_path = os.path.join(settings.BASE_DIR, 'apps/order/app_private_key.pem')
        app_private_key_string = open(private_path).read()
        alipay_public_key_string = open(public_path).read()
        alipay = AliPay(
            appid="2016102300746158",  # 应用ID,没上线则为沙箱ID
            app_notify_url=None,  # 默认回调url
            app_private_key_string=app_private_key_string,  # 私钥
            alipay_public_key_string=alipay_public_key_string,  # 支付宝公钥
            sign_type="RSA2",
            debug=True,  # 上线则改为False , 沙箱True
        )
        """
               response = {
                 "alipay_trade_query_response": {
                   "trade_no": "2017032121001004070200176844", # 支付宝交易号
                   "code": "10000",  # 状态码:借口调用是否成功
                   "invoice_amount": "20.00",
                   "open_id": "20880072506750308812798160715407",
                   "fund_bill_list": [
                     {
                       "amount": "20.00",
                       "fund_channel": "ALIPAYACCOUNT"
                     }
                   ],
                   "buyer_logon_id": "csq***@sandbox.com",
                   "send_pay_date": "2017-03-21 13:29:17",
                   "receipt_amount": "20.00",
                   "out_trade_no": "out_trade_no15",
                   "buyer_pay_amount": "20.00",
                   "buyer_user_id": "2088102169481075",
                   "msg": "Success",
                   "point_amount": "0.00",
                   "trade_status": "TRADE_SUCCESS", # 支付结果
                   "total_amount": "20.00"
                 },
                 "sign": ""
               }
               """
        import ssl
        ssl._create_default_https_context = ssl._create_unverified_context
        while True:
            response = alipay.api_alipay_trade_query(order_id)
            code = response.get('code')
            if code == '10000' and response.get('trade_status') == 'TRADE_SUCCESS':
                # 支付成功
                # 获取支付宝交易号
                trade_no = response.get('trade_no')
                # 更新订单状态
                order_trade_no = trade_no
                order.order_status = 4  # 待评价
                order.save()
                # 返回结果
                return JsonResponse({'res': 3, 'msg': '支付成功'})
            elif code == '40004' or (code == '10000' and response.get('trade_status') == 'WAIT_BUYER_PAY'):
                # 等待买家付款
                # 业务处理失败,可能一会就会成功
                import time
                time.sleep(5)
                continue
            else:
                # 支付出错
                print(code)
                return JsonResponse({'res': 4, 'errmsg': '支付失败'})


class CommentView(ListView):
    '''订单评论'''

    def get(self, request, order_id):
        '''提供评论页面'''
        user = request.user

        # 校验数据
        if not order_id:
            return redirect(reverse('user:order'))

        try:
            order = OrderInfo.objects.get(order_id=order_id, user=user)
        except OrderInfo.DoesNotExist:
            return redirect(reverse('user:order'))

        # 根据订单商品信息
        order.status_name = OrderInfo.ORDER_STATUS[order.order_status]

        # 获取订单商品信息
        order_skus = OrderGoods.objects.filter(order_id=order_id)
        for order_sku in order_skus:
            # 计算商品的小计
            amount = order_sku.count * order_sku.price
            # 动态给order_sku增加属性amount,保存商品小计
            order_sku.amount = amount

        # 动态给order增加属性order_skus,保存订单商品信息
        order.order_skus = order_skus
        # 使用模板
        return render(request, 'order/order_comment.html', {'order': order})

    def post(self, request, order_id):
        '''处理评论内容'''
        user = request.user
        # 校验数据
        if not order_id:
            return redirect(reverse('user:order'))
        try:
            order = OrderInfo.objects.get(order_id=order_id, user=user)
        except OrderInfo.DoesNotExist:
            return redirect(reverse('user:order'))

        # 获取评论条数
        total_count = request.POST.get('total_count')
        total_count = int(total_count)
        # 循环获取订单中商品的评论内容
        for i in range(1, total_count + 1):
            # 获取评论的商品的id
            sku_id = request.POST.get('sku_%d' % i)
            # 获取评论的商品的内容
            content = request.POST.get('content_%d' % i, '')
            try:
                order_goods = OrderGoods.objects.get(order=order, sku_id=sku_id)
            except OrderGoods.DoesNotExist:
                continue

            order_goods.comment = content
            order_goods.save()

        order.order_status = 5
        order.save()

        return redirect(reverse('user:order', kwargs={'page': 1}))
