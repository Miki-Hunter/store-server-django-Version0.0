# store-server-django
## 一些说明
1、此为根据原 node.js + Koa框架 使用django + drf 重构的方法，故此版本接口与原版一致，完成此接口文档，
内部有一些可以改动的点，比如 [原作者](https://github.com/hai-27/store-server) 全部采用post方法实现，这个可以根据学习需要进行改动，当然，需要前后端同步修改。
由于本人drf属于初学，代码习惯比较差，当然可以有很高效且优雅的写法，有待继续学习改进。

2、购物车模块、订单模块、收藏模块  都有登录校验

3、使用drf时，前端写网址时最后加上一条斜杠  例如 "/api/product/getPromoProduct/"  ,否则可能无法访问

4、关于 order_time 时间戳

	如 	"order_time": 1659522650709,  使用的是毫秒级时间戳
		 "order_id": 11659522650709,  则是 user_id  +  order_time
