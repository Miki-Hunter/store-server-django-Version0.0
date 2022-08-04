"""
list :get
create: post
put: update(整体更新，提供所有更改后的字段信息)
patch：partial_update(据不更新，仅提供需要修改的信息)     都要提供id 如 localhost:8080/api/books/2/
delete: destroy
get_id: retrieve
"""
import json
import time

from django.db.migrations import serializer
from rest_framework import viewsets, status
from apps.models import Orders, Product, ShoppingCart
from django.db.models import Q
from rest_framework.response import Response
from apps.serializers import OrdersSerializer

# 字典转换
def transFormOrders(postId,products):
    data = []
    for product in products:
        timestamp = str(int(round(time.time() * 1000))) # 毫秒级时间戳
        order_id = int(postId + timestamp)
        order_time = int(timestamp)
        item_json = {'order_id': order_id,'product_num': int(product['num']), 'product_price': int(product['price']),
                     'user_id': int(postId), 'product_id': int(product['productID']), 'order_time': order_time}
        data.append(item_json)  # 手动填写
    return data

class GetOrder(viewsets.ModelViewSet):
    queryset = Orders.objects.all()
    serializer_class = OrdersSerializer
    permission_classes = []  # 跳过权限的登录

    def create(self, request, *args, **kwargs):
        postId = str(request.data['user_id'])
        sessionId = str(request.session['user']['user_id'])
        userId = int(sessionId)
        if postId == sessionId:
            orders = Orders.objects.filter(user_id=userId).order_by('-order_time')
            if orders:
                ordersList = []
                for order in orders:
                    o = []
                    product = Product.objects.get(product_id__exact=order.product_id)
                    item_json = {'id':order.id,'order_id':order.order_id,'user_id':order.user_id,'product_id':order.product_id,'product_num':order.product_num,
                                 'order_time':order.order_time,'product_price':order.product_price,'product_name':product.product_name,'product_picture':product.product_picture,}
                    o.append(item_json)  # 手动填写
                    ordersList.append(o)
                return Response({'code': '001', 'orders': ordersList})
            else:
                return Response({'code': '002', 'msg': '该用户没有订单信息'})
        else:
            return Response({'code': '401', 'msg': '用户名没有登录，请登录后再操作'})


class AddOrder(viewsets.ModelViewSet):
    queryset = Orders.objects.all()
    serializer_class = OrdersSerializer

    permission_classes = []  # 跳过权限的登录

    def create(self, request, *args, **kwargs):
        postId = str(request.data['user_id'])
        sessionId = str(request.session['user']['user_id'])
        userId = int(sessionId)
        products = request.data['products']
        if postId == sessionId:
            print(products)
            data = transFormOrders(postId,products)
            try:
                for item in data:
                    Orders.objects.create(**item)   # 创建订单、删除购物车原有记录
                    ShoppingCart.objects.filter(user_id=userId,product_id=item['product_id']).delete()
                return Response({'code': '001', 'msg': '购买成功'})
            except:
                return Response({'code': '002', 'msg': '购买失败'})
        else:
            return Response({'code': '401', 'msg': '用户名没有登录，请登录后再操作'})