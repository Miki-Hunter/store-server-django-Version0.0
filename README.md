# store-server-django
## 一些说明
### 1、此为根据原 node.js + Koa框架 使用django + drf 重构的方法
此版本接口与原版一致。
内部有一些可以改动的点，比如 [原作者-后端](https://github.com/hai-27/store-server) 全部采用post方法实现，这个可以根据学习需要进行改动，当然，需要前后端同步修改。
由于本人drf属于初学，代码习惯比较差，当然可以有很高效且优雅的写法，有待继续学习改进。

### 2、购物车模块、订单模块、收藏模块  都有登录校验

### 3、使用drf时，前端写网址时最后加上一条斜杠  例如 "/api/product/getPromoProduct/"  ,否则可能无法访问 [原作者-前端](https://github.com/hai-27/vue-store) 

### 4、关于 order_time 时间戳

	如 	"order_time": 1659522650709,  使用的是毫秒级时间戳
		 "order_id": 11659522650709,  则是 user_id  +  order_time

### 5、 [完整API文档](https://github.com/Miki-Hunter/-store-server-django/blob/main/storeAPI.md)

### 6、 关于启动

1） 和一般的django项目没什么区别

2）安装依赖，也就是requirments.txt 列出的内容

3）设置数据库 ，我用的是Mysql， sql文件也准备好了，使用前自定义数据库名

4）数据库迁移

5）启动

6) 在正式对接前端前，最好进行api测试
