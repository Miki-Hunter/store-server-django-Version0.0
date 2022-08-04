"""
list :get
create: post
put: update(整体更新，提供所有更改后的字段信息)
patch：partial_update(据不更新，仅提供需要修改的信息)     都要提供id 如 localhost:8080/api/books/2/
delete: destroy
get_id: retrieve
"""
from rest_framework import viewsets, status
from apps.models import ShoppingCart, Product
from django.db.models import Q
from rest_framework.response import Response
from apps.serializers import ShoppingCartSerializer

def getDetailsOfShoppingCart(goods_list):
    json_list = []
    for goods in goods_list:
        product_id = goods.product_id
        product = Product.objects.get(product_id__exact=product_id)
        json_item = {"id": goods.id, "productID": product_id, "productName": product.product_name,
                     "productImg": product.product_picture, "price": product.product_selling_price, "num": goods.num,
                     "maxNum": product.product_num // 2, "check": False}
        json_list.append(json_item)         # 此为手动填写
    return json_list


class GetShoppingCart(viewsets.ModelViewSet):
    queryset = ShoppingCart.objects.all()
    serializer_class = ShoppingCartSerializer
    permission_classes = []  # 跳过权限的登录

    def create(self, request, *args, **kwargs):
        postId = int(request.data['user_id'])
        sessionId = int(request.session['user']['user_id'])
        userId = int(sessionId)
        if postId == sessionId:
            goods_list = ShoppingCart.objects.filter(user_id__exact=userId)
            json_list = getDetailsOfShoppingCart(goods_list)  # 获取详细信息
            return Response({'code': '001', 'shoppingCartData': json_list})
        else:
            return Response({'code': '401', 'msg': '用户名没有登录，请登录后再操作'})

class AddShoppingCart(viewsets.ModelViewSet):
    queryset = ShoppingCart.objects.all()
    serializer_class = ShoppingCartSerializer
    permission_classes = []  # 跳过权限的登录

    def create(self, request, *args, **kwargs):
        postId = int(request.data['user_id'])
        sessionId = int(request.session['user']['user_id'])
        product_id = int(request.data['product_id'])
        userId = int(sessionId)
        if postId == sessionId:
            isAlready = ShoppingCart.objects.filter(user_id__exact=userId,product_id__exact=product_id)
            if isAlready:       # 该商品已经在购物车里面了，直接数量加一即可
                nowNum = isAlready[0].num + 1
                product = Product.objects.get(product_id__exact=product_id)
                maxNum = product.product_num // 2
                if nowNum > maxNum:
                    return Response({'code': '003', 'msg': '已经达到限购数量%d' %maxNum})
                try:
                    tem = ShoppingCart.objects.get(user_id__exact=userId,product_id__exact=product_id)
                    tem.num = nowNum
                    tem.save()
                    return Response({'code': '002', 'msg': '商品已在购物车,数量+1'})
                except:
                    return Response({'code': '500', 'msg': '未知错误1'})
            else:
                try:
                    tem = ShoppingCart(user_id=userId,product_id=product_id,num=1)
                    tem.save()
                    goods_list = ShoppingCart.objects.filter(user_id__exact=userId,product_id__exact=product_id)
                    json_list = getDetailsOfShoppingCart(goods_list)
                    return Response({'code': '001', 'msg': '添加购物车成功!','shoppingCartData':json_list})
                except:
                    return Response({'code': '500', 'msg': '未知错误2'})
        else:
            return Response({'code': '401', 'msg': '用户名没有登录，请登录后再操作'})


class DeleteShoppingCart(viewsets.ModelViewSet):
    queryset = ShoppingCart.objects.all()
    serializer_class = ShoppingCartSerializer
    permission_classes = []  # 跳过权限的登录

    def create(self, request, *args, **kwargs):
        postId = str(request.data['user_id'])
        sessionId = str(request.session['user']['user_id'])
        product_id = int(request.data['product_id'])
        userId = int(sessionId)
        if postId == sessionId:
            tems = ShoppingCart.objects.filter(user_id__exact=userId,product_id__exact=product_id)
            if tems:
                try:
                    tem = ShoppingCart.objects.get(user_id__exact=userId,product_id__exact=product_id)
                    tem.delete()
                    return Response({'code': '001', 'msg': '删除购物车成功!'})
                except:
                    return Response({'code': '500', 'msg': '未知错误3'})
            else:
                return Response({'code': '002', 'msg': '该商品不存在购物车'})
        else:
            return Response({'code': '401', 'msg': '用户名没有登录，请登录后再操作'})

class UpdateShoppingCart(viewsets.ModelViewSet):
    queryset = ShoppingCart.objects.all()
    serializer_class = ShoppingCartSerializer
    permission_classes = []  # 跳过权限的登录

    def create(self, request, *args, **kwargs):
        postId = int(request.data['user_id'])
        userId = int(request.session['user']['user_id'])
        product_id = int(request.data['product_id'])
        num = int(request.data['num'])
        if postId == userId:
            if num < 1:
                return Response({'code': '004', 'msg': '数量不合法'})
            tempShoppingCarts = ShoppingCart.objects.filter(user_id__exact=userId,product_id__exact=product_id)
            if tempShoppingCarts:
                tem = ShoppingCart.objects.get(user_id__exact=userId,product_id__exact=product_id)
                if tem.num == num:
                    return Response({'code': '003', 'msg': '数量没有发生变化'})
                product = Product.objects.get(product_id__exact=product_id)
                maxNum = product.product_num // 2
                if maxNum < num:
                    return Response({'code': '004', 'msg': '已达到限购数量%d' %maxNum})
                try:
                    tem.num = num
                    tem.save()
                    return Response({'code': '001', 'msg': '修改购物车数量成功'})
                except:
                    return Response({'code': '500', 'msg': '未知错误4'})
            else:
                return Response({'code': '002', 'msg': '该商品不在购物车'})
        else:
            return Response({'code': '401', 'msg': '用户名没有登录，请登录后再操作'})



