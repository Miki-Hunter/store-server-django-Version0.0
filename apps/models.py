from django.db import models
from django.contrib.auth.models import AbstractUser
from django.contrib.auth.models import UserManager

from rest_framework.filters import SearchFilter
import uuid

class Product(models.Model):
    product_id = models.IntegerField(verbose_name='商品id',primary_key=True)
    category_id = models.IntegerField(verbose_name='类别id')
    product_name = models.CharField(max_length=100, verbose_name='商品名称')
    product_title = models.CharField(max_length=30,verbose_name='产品标题')
    product_intro = models.TextField(verbose_name='商品简介',)
    product_picture = models.CharField(max_length=200,verbose_name='商品图片')
    product_price = models.FloatField(verbose_name='商品价格')
    product_selling_price = models.FloatField(verbose_name='商品实际价格')
    product_num = models.IntegerField(verbose_name='商品数量')
    product_sales = models.IntegerField(verbose_name='商品销量')

    class Meta:
        db_table='product'

class Carousel(models.Model):
    carousel_id = models.IntegerField(verbose_name='轮播图id',primary_key=True)
    imgPath = models.CharField(max_length=50,verbose_name='轮播图路径')
    # describes = models.CharField(max_length=50,verbose_name='轮播图描述',default='暂无描述')

    class Meta:
        db_table='carousel'

class Category(models.Model):
    category_id = models.IntegerField(verbose_name='分类id',primary_key=True)
    category_name = models.CharField(max_length=20,verbose_name='分类名称')

    class Meta:
        db_table='category'
class Orders(models.Model):
    id = models.IntegerField(verbose_name='订单id',primary_key=True)
    user_id = models.IntegerField(verbose_name='用户id')
    product_num = models.IntegerField(verbose_name='商品数量')
    order_id = models.BigIntegerField(verbose_name='订单编号')
    product_id = models.IntegerField(verbose_name='商品id')
    product_price = models.FloatField(verbose_name='商品价格')
    order_time = models.BigIntegerField(verbose_name='下单时间')
    class Meta:
        db_table='orders'
class ProductPicture(models.Model):
    id = models.IntegerField(verbose_name='商品图片id',primary_key=True)
    product_id = models.IntegerField(verbose_name='商品id')
    product_picture = models.CharField(max_length=50,verbose_name='商品图片路径')
    intro = models.TextField(verbose_name='商品描述')

    class Meta:
        db_table='product_picture'

class ShoppingCart(models.Model):
    id = models.IntegerField(verbose_name='购物车id',primary_key=True)
    user_id = models.IntegerField(verbose_name='用户id')
    product_id = models.IntegerField(verbose_name='商品id')
    num = models.IntegerField(verbose_name='商品数量')
    class Meta:
        db_table='shoppingcart'

class Users(models.Model):
    user_id = models.IntegerField(verbose_name='用户id',primary_key=True)
    userName = models.CharField(max_length=20,verbose_name='用户名')
    password = models.CharField(max_length=40,verbose_name='密码')
    userPhoneNumber = models.CharField(max_length=11,verbose_name='用户手机号')

    def toDict(self):
        return {'user_id':self.user_id,'userName':self.userName,'userPhoneNumber':self.userPhoneNumber}
    class Meta:
        db_table='users'

class Collect(models.Model):
    id = models.IntegerField(verbose_name='收藏id',primary_key=True)
    user_id = models.IntegerField(verbose_name='用户id')
    product_id = models.IntegerField(verbose_name='商品id')
    collect_time = models.BigIntegerField(verbose_name='收藏时间')

    class Meta:
        db_table='collect'