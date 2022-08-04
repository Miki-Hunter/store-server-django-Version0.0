from django.urls import path, include
from rest_framework import routers
from apps.views import ProductInfoViewSet, OrdersInfoViewSet,\
    ShoppingCartInfoViewSet, UserInfoViewSet, CarouselInfoViewSet, CollectInfoViewSet

router_users = routers.DefaultRouter()
router_users.register('login', UserInfoViewSet.Login)
router_users.register('findUserName', UserInfoViewSet.IsRegister)
router_users.register('register', UserInfoViewSet.Register)

router_shoppingCart = routers.DefaultRouter()
router_shoppingCart.register('getShoppingCart', ShoppingCartInfoViewSet.GetShoppingCart)
router_shoppingCart.register('addShoppingCart', ShoppingCartInfoViewSet.AddShoppingCart)
router_shoppingCart.register('deleteShoppingCart', ShoppingCartInfoViewSet.DeleteShoppingCart)
router_shoppingCart.register('updateShoppingCart', ShoppingCartInfoViewSet.UpdateShoppingCart)

router_resources = routers.DefaultRouter()
router_resources.register('carousel', CarouselInfoViewSet.CarouselInfo)

router_product = routers.DefaultRouter()
router_product.register('getPromoProduct', ProductInfoViewSet.GetPromoProduct) #
router_product.register('getDetails', ProductInfoViewSet.GetDetails)       #
router_product.register('getDetailsPicture', ProductInfoViewSet.GetDetailsPicture)
router_product.register('getCategory', ProductInfoViewSet.GetCategory)
router_product.register('getAllProduct', ProductInfoViewSet.GetAllProduct)
router_product.register('getHotProduct', ProductInfoViewSet.GetHotProduct)
router_product.register('getProductByCategory', ProductInfoViewSet.GetProductByCategory)
router_product.register('getProductBySearch', ProductInfoViewSet.GetProductBySearch)
# 缺4

router_order = routers.DefaultRouter()
router_order.register('getOrder', OrdersInfoViewSet.GetOrder)
router_order.register('addOrder', OrdersInfoViewSet.AddOrder)

router_collect = routers.DefaultRouter()
router_collect.register('addCollect', CollectInfoViewSet.AddCollect)
router_collect.register('getCollect', CollectInfoViewSet.GetCollect)
router_collect.register('deleteCollect', CollectInfoViewSet.DeleteCollect)

urlpatterns = [
    path('users/', include(router_users.urls)),
    path('resources/', include(router_resources.urls)),
    path('user/shoppingCart/', include(router_shoppingCart.urls)),
    path('user/collect/', include(router_collect.urls)),
    path('user/order/', include(router_order.urls)),
    path('product/', include(router_product.urls)),

]
