"""
list :get
create: post
put: update(整体更新，提供所有更改后的字段信息)
patch：partial_update(据不更新，仅提供需要修改的信息)     都要提供id 如 localhost:8080/api/books/2/
delete: destroy
get_id: retrieve
"""
import time

from django.forms import model_to_dict
from rest_framework import viewsets, status
from apps.models import Collect, Product
from django.db.models import Q
from rest_framework.response import Response
from apps.serializers import CollectSerializer

def transFormCollect(collects):
    data = []
    for _ in collects:
        product = Product.objects.get(product_id=_.product_id)
        # item_json = {'product_id': product.product_id, 'product_name': product.product_name, 'product_title': product.product_title,
        #              'product_intro': product.product_intro, 'product_picture': product.product_picture,
        #              'product_price': product.product_price, 'product_selling_price': product.product_selling_price,
        #              'product_num': product.product_num, 'product_sales': product.product_sales,
        #              'category_id': product.category_id,}
        # data.append(item_json)
        test = model_to_dict(product)       # 将模型转换为字典，由于数据没有改变，可以直接使用
        data.append(test)

    return data

class AddCollect(viewsets.ModelViewSet):
    queryset = Collect.objects.all()
    serializer_class = CollectSerializer
    permission_classes = []  # 跳过权限的登录

    def create(self, request, *args, **kwargs):
        postId = str(request.data['user_id'])
        sessionId = str(request.session['user']['user_id'])
        product_id = request.data['product_id']
        user_id = int(sessionId)
        if postId == sessionId:
            product = Collect.objects.filter(user_id=user_id,product_id=product_id)
            if not product:
                try:
                    aNewCollect = Collect(user_id=user_id)
                    aNewCollect.product_id = product_id
                    timestamp = int(round(time.time() * 1000))  # 毫秒级时间戳
                    aNewCollect.collect_time = timestamp
                    aNewCollect.save()
                    return Response({'code': '001', 'msg': '添加收藏成功'})
                except:
                    return Response({'code': '002', 'msg': '添加收藏失败'})
            else:
                return Response({'code': '001', 'msg': '该商品已添加收藏，请到我的收藏查看'})

        else:
            return Response({'code': '401', 'msg': '用户名没有登录，请登录后再操作'})

class GetCollect(viewsets.ModelViewSet):
    queryset = Collect.objects.all()
    serializer_class = CollectSerializer
    permission_classes = []  # 跳过权限的登录

    def create(self, request, *args, **kwargs):
        postId = str(request.data['user_id'])
        sessionId = str(request.session['user']['user_id'])
        user_id = int(sessionId)
        if postId == sessionId:
            collects = Collect.objects.filter(user_id=user_id).order_by('-collect_time')
            if collects:
                data = transFormCollect(collects)
                return Response({'code': '001', 'collectList': data})
            else:
                return Response({'code': '002', 'msg': '该用户没有收藏的商品'})
        else:
            return Response({'code': '401', 'msg': '用户名没有登录，请登录后再操作'})


class DeleteCollect(viewsets.ModelViewSet):
    queryset = Collect.objects.all()
    serializer_class = CollectSerializer
    permission_classes = []  # 跳过权限的登录

    def create(self, request, *args, **kwargs):
        postId = str(request.data['user_id'])
        sessionId = str(request.session['user']['user_id'])
        product_id = request.data['product_id']
        user_id = int(sessionId)
        if postId == sessionId:
            collects = Collect.objects.filter(user_id=user_id,product_id=product_id)
            if collects:
                for _ in collects:
                    _.delete()
                return Response({'code': '001', 'msg': '删除收藏成功'})
            else:
                return Response({'code': '002', 'msg': '该商品不在收藏列表'})
        else:
            return Response({'code': '401', 'msg': '用户名没有登录，请登录后再操作'})

