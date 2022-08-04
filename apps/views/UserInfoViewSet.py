"""
list :get
create: post
put: update(整体更新，提供所有更改后的字段信息)
patch：partial_update(据不更新，仅提供需要修改的信息)     都要提供id 如 localhost:8080/api/books/2/
delete: destroy
get_id: retrieve
"""
from rest_framework import viewsets
from apps.models import Users
from rest_framework.response import Response
from apps.serializers import UserSerializer


class Login(viewsets.ModelViewSet):
    queryset = Users.objects.all()
    serializer_class = UserSerializer
    permission_classes = []  # 跳过权限的登录
    http_method_names = ['post']  # 允许的请求方法
    def create(self, request, *args, **kwargs):
        try:
            userName = request.data['userName']
            password = request.data['password']
            try:
                user = Users.objects.get(userName__exact=userName,password__exact=password)
                # print(user.userName,user.password)
                request.session['user'] = user.toDict()
                # print(request.session['user'])
                return Response({'code': '001', 'user': user.toDict(), 'msg': '登录成功'})
            except:
                return Response({'code': '004', 'msg': '用户名或密码错误'})
        except:
            return Response({'code': '500','msg': '未知错误'})

class IsRegister(viewsets.ModelViewSet):
    queryset = Users.objects.all()
    serializer_class = UserSerializer
    permission_classes = []  # 跳过权限的登录
    http_method_names = ['post']  # 允许的请求方法

    def create(self, request, *args, **kwargs):
        try:
            isName = Users.objects.filter(userName__exact=request.data['userName'])
            if isName:
                return Response({'code': "004", 'msg': '用户名已经存在，不能注册'})
            else:
                return Response({'code': '001', 'msg': '可以注册'})
        except:
            return Response({'code': '500', 'msg': '未知错误'})


class Register(viewsets.ModelViewSet):
    queryset = Users.objects.all()
    serializer_class = UserSerializer
    permission_classes = []  # 跳过权限的登录
    http_method_names = ['post']  # 允许的请求方法

    def create(self, request, *args, **kwargs):
        print(request.data)
        try:
            if Users.objects.filter(userName__exact=request.data['userName']):
                return Response({'code': "004", 'msg': '用户名已经存在，不能注册'})
            else:
                password = request.data['password']
                userPhoneNumber = request.data['userPhoneNumber']
                userInfo = Users(userName=request.data['userName'])
                userInfo.password = password
                # userInfo.userPhoneNumber = userPhoneNumber  # 用户可以加上userPhoneNumber
                userInfo.save()
                return Response({'code': "001", 'msg': '注册成功'})
        except:
            return Response({'code': '500', 'msg': '未知错误'})