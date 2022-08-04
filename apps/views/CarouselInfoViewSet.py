"""
list :get
create: post
put: update(整体更新，提供所有更改后的字段信息)
patch：partial_update(据不更新，仅提供需要修改的信息)     都要提供id 如 localhost:8080/api/books/2/
delete: destroy
get_id: retrieve
"""
from django.http import JsonResponse
from rest_framework import viewsets, status
from rest_framework.response import Response

from apps.models import Carousel
from apps.serializers import CarouselSerializer

class CarouselInfo(viewsets.ModelViewSet):
    queryset = Carousel.objects.all()
    serializer_class = CarouselSerializer
    permission_classes = []  # 跳过权限的登录

    def create(self, request, *args, **kwargs):
        alist = Carousel.objects.filter()
        carousel = []
        for _ in alist:
            item = {'carousel_id':_.carousel_id, 'imgPath':_.imgPath}
            carousel.append(item)
        return Response({"code":'001','carousel':carousel})



