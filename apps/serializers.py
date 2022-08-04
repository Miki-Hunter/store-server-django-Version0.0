from rest_framework import serializers

from apps.models import Product, Category, Orders, ProductPicture, ShoppingCart, Users, Carousel, Collect


class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'

class OrdersSerializer(serializers.ModelSerializer):
    class Meta:
        model = Orders
        fields = '__all__'

class ProductPictureSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductPicture
        fields = '__all__'

class ShoppingCartSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShoppingCart
        fields = '__all__'

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = Users
        fields = '__all__'

class CarouselSerializer(serializers.ModelSerializer):
    class Meta:
        model = Carousel
        fields = '__all__'

class CollectSerializer(serializers.ModelSerializer):
    class Meta:
        model = Collect
        fields = '__all__'