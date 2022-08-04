# API 接口文档

## 一些说明
1、此为根据原 node.js + Koa框架 使用django + drf 重构的方法，故此版本接口与原版一致，完成此接口文档，
内部有一些可以改动的点，比如 [原作者](https://github.com/hai-27/store-server) 全部采用post方法实现，这个可以根据学习需要进行改动，当然，需要前后端同步修改。
由于本人drf属于初学，代码习惯比较差，当然可以有很高效且优雅的写法，有待继续学习改进。

2、购物车模块、订单模块、收藏模块  都有登录校验

3、使用drf时，前端写网址时最后加上一条斜杠  例如 "/api/product/getPromoProduct/"  ,否则可能无法访问

4、关于 order_time 时间戳

	如 	"order_time": 1659522650709,  使用的是毫秒级时间戳
		 "order_id": 11659522650709,  则是 user_id  +  order_time


​	

## 一、用户模块

### 1.1 登录

**请求URL：**

```
/users/login
```

**请求方式：**

```
Post
```

**参数说明：**

| 参数 | 是否必选 | 类型 | 说明 |
| :-: | :-: | :-: | :-: |
| userName | 是 | string | 用户名 |
|  password  | 是 | string | 密码 |

**返回示例：**

```javascript
{
  "code": "001",
    "user": {
    "user_id": 1,
    "userName": "admin"
  },
  "msg": "登录成功"
}

{'code': '004', 'msg': '用户名或密码错误'}
```



### 1.2 查找用户名是否存在

**请求URL：**

```
/users/findUserName
```

**请求方式：**

```
Post
```

**参数说明：**

|   参数   | 是否必选 |  类型  |  说明  |
| :------: | :------: | :----: | :----: |
| userName |    是    | string | 用户名 |

**返回示例：**

```javascript
{
  "code": "001",
  "msg": "用户名不存在，可以注册"
}

{'code': "004", 'msg': '用户名已经存在，不能注册'}
```



### 1.3 注册

**请求URL：**

```
/users/register
```

**请求方式：**

```
Post
```

**参数说明：**

|   参数   | 是否必选 |  类型  |  说明  |
| :------: | :------: | :----: | :----: |
| userName |    是    | string | 用户名 |
| password |    是    | string |  密码  |

**返回示例：**

```javascript
{
  code: '001',
  msg: '注册成功'
}

{'code': "004", 'msg': '用户名已经存在，不能注册'}
```

## 二、购物车模块

### 2.1 获取购物车信息

**请求URL：**

```
/user/shoppingCart/getShoppingCart/
```

**请求方式：**

```
Post
```

**参数说明：**

|   参数   | 是否必选 |  类型  |  说明  |
| :------: | :------: | :----: | :----: |
| user_id |    是    | int | 用户id |

**返回示例：**

```javascript
{
	"code": "001",
	"shoppingCartData": [
		{
			"id": 4,
			"productID": 36,
			"productName": "Redmi K30",
			"productImg": "public/imgs/phone/Redmi-k30.png",
			"price": 1599,
			"num": 1,
			"maxNum": 5,
			"check": false
		},
        ......
	]
}
        
        
可能购物车为空，即返回:
{
	"code": "001",
	"shoppingCartData": []
}
```

### 2.2 添加购物车

**请求URL：**

```
/user/shoppingCart/addShoppingCart
```

**请求方式：**

```
Post
```

**参数说明：**

|   参数   | 是否必选 |  类型  |  说明  |
| :------: | :------: | :----: | :----: |
| user_id |    是    | int | 用户id |
| product_id |    是    | int |  商品id  |

**返回示例：**

```javascript
{
	"code": "002",
	"msg": "商品已在购物车,数量+1"
}

{
	"code": "003",
	"msg": "商品已达到购物限额"
}

{
	"code": "001",
	"msg": "添加购物车成功!",
	"shoppingCartData": [
		{
			"id": 7,
			"productID": 14,
			"productName": "小米电视4A 65英寸",
			"productImg": "public/imgs/appliance/MiTv-4A-65.png",
			"price": 2799,
			"num": 1,
			"maxNum": 5,
			"check": false
		}
	]
}
```



### 2.3  删除购物车

**请求URL：**

```
/user/shoppingCart/deleteShoppingCart
```

**请求方式：**

```
Post
```

**参数说明：**

|   参数   | 是否必选 |  类型  |  说明  |
| :------: | :------: | :----: | :----: |
| user_id |    是    | int | 用户id |
| product_id |    是    | int |  商品id  |

**返回示例：**

```javascript
{
	"code": "001",
	"msg": "删除购物车成功"
}

{
	"code": "002",
	"msg": "该商品不在购物车"
}
```

### 2.4  更新购物车数量

**请求URL：**

```
user/shoppingCart/updateShoppingCart/
```

**请求方式：**

```
Post
```

**参数说明：**

|   参数   | 是否必选 |  类型  |  说明  |
| :------: | :------: | :----: | :----: |
| user_id |    是    | int | 用户id |
| product_id |    是    | int |  商品id  |
| num |    是    | int |  数量  |
**返回示例：**

```javascript
{"code": "001", "msg": "修改购物车数量成功"}

{'code': '002', 'msg': '该商品不在购物车'}

{'code': '003', 'msg': '数量没有发生变化'}

{"code": "004", "msg": "数量不合法"}

{"code": "004", "msg": "商品已达到购物限额"}
```

## 三、轮播图模块

### 3.1  轮播图管理

**请求URL：**

```
/resources/carousel/
```

**请求方式：**

```
Post
```

(无参数的post请求，可考虑改为get方式)
**参数说明：**

无参数

**返回示例：**

```javascript
{
	"code": "001",
	"carousel": [
		{
			"carousel_id": 1,
			"imgPath": "public/imgs/carousel/carousel1.jpg"
		},
		{
			"carousel_id": 2,
			"imgPath": "public/imgs/carousel/carousel2.jpg"
		},
		{
			"carousel_id": 3,
			"imgPath": "public/imgs/carousel/carousel3.jpg"
		},
		{
			"carousel_id": 4,
			"imgPath": "public/imgs/carousel/carousel4.jpg"
		}
	]
}
```

## 四、商品模块

### 4.1  首页展示同一类别前7个商品
注: 可根据需要自定义数量

**请求URL：**

```
/product/getPromoProduct
```

**请求方式：**

```
Post
```

**参数说明：**

|   参数   | 是否必选 |  类型  |  说明  |
| :------: | :------: | :----: | :----: |
| categoryName |    是    | string | 类别名称 |

注: 可考虑 传入 categoryID

**返回示例：**

```javascript
{
	"code": "001",
	"Product": [
		{
			"product_id": 30,
			"product_name": "小米无线充电宝青春版10000mAh",
			"category_id": 8,
			"product_title": "能量满满，无线有线都能充",
			"product_intro": "10000mAh大容量 / 支持边充边放 / 有线无线都能充 / 双向快充",
			"product_picture": "public/imgs/accessory/charger-10000mAh.png",
			"product_price": 129,
			"product_selling_price": 129,
			"product_num": 20,
			"product_sales": 8
		},
        ......
	]
}
```

### 4.2  单个商品详情

**请求URL：**

```
/product/getDetails
```

**请求方式：**

```
Post
```

**参数说明：**

|   参数   | 是否必选 |  类型  |  说明  |
| :------: | :------: | :----: | :----: |
| productID |    是    | int | 商品ID |

**返回示例：**

```javascript
{
	"code": "001",
	"Product": [
		{
			"product_id": 30,
			"product_name": "小米无线充电宝青春版10000mAh",
			"category_id": 8,
			"product_title": "能量满满，无线有线都能充",
			"product_intro": "10000mAh大容量 / 支持边充边放 / 有线无线都能充 / 双向快充",
			"product_picture": "public/imgs/accessory/charger-10000mAh.png",
			"product_price": 129,
			"product_selling_price": 129,
			"product_num": 20,
			"product_sales": 8
		}
	]
}
```

### 4.3  获取指定商品的全部图片

**请求URL：**

```
/product/getDetailsPicture/
```

**请求方式：**

```
Post
```

**参数说明：**

|   参数   | 是否必选 |  类型  |  说明  |
| :------: | :------: | :----: | :----: |
| productID |    是    | int | 商品ID |

**返回示例：**

```javascript
{
	"code": "001",
	"ProductPicture": [
		{
			"id": 6,
			"product_id": 2,
			"product_picture": "public/imgs/phone/picture/Redmi K30 5G-1.jpg",
			"intro": null
		},
	]
}
```

### 4.4  获取分类列表

**请求URL：**

```
/product/getCategory/
```

**请求方式：**

```
Post
```

**参数说明：**

无参数

**返回示例：**

```javascript
{
	"code": "001",
	"category": [
		{
			"category_id": 1,
			"category_name": "手机"
		},
		{
			"category_id": 2,
			"category_name": "电视机"
		},
		{
			"category_id": 3,
			"category_name": "空调"
		},
		{
			"category_id": 4,
			"category_name": "洗衣机"
		},
		{
			"category_id": 5,
			"category_name": "保护套"
		},
		{
			"category_id": 6,
			"category_name": "保护膜"
		},
		{
			"category_id": 7,
			"category_name": "充电器"
		},
		{
			"category_id": 8,
			"category_name": "充电宝"
		}
	]
}
```

### 4.5  获取全部商品

**请求URL：**

```
/product/getAllProduct/
```

**请求方式：**

```
Post
```

**参数说明：**

|   参数   | 是否必选 |  类型  |  说明  |
| :------: | :------: | :----: | :----: |
| categoryID |    非    | int | 类别ID |
| pageSize |    是    | int | 页码大小 |
| currentPage |    是    | int | 当前页(设置1为首页即可) |

注: 	categoryID 是分类查询的时候才携带  ( 4.6 获取指定类别商品 ), 

​		categoryID 为空执行的是全部数据查询
**返回示例：**

```javascript
{
	"code": "001",
	"Product": [
		{
			"product_id": 16,
			"category_id": 3,
			"product_name": "米家互联网空调C1（一级能效）",
			"product_title": "变频节能省电，自清洁",
			"product_intro": "一级能效 | 1.5匹 | 全直流变频 | 高效制冷/热 | 静音设计 | 自清洁 | 全屋互联",
			"product_picture": "public/imgs/appliance/AirCondition-V1C1.png",
			"product_price": 2699,
			"product_selling_price": 2599,
			"product_num": 20,
			"product_sales": 10
		},
        .......(有多少条取决于pageSize)
		
	],
	"total": 70		(数据总数)
}
```



### 4.6  获取指定类别商品

**请求URL：**

```
/product/getProductByCategory/
```

**请求方式：**

```
Post
```

**参数说明：**

|    参数     | 是否必选 | 类型 |          说明           |
| :---------: | :------: | :--: | :---------------------: |
| categoryID  |    是    |  []  |         类别ID          |
|  pageSize   |    是    | int  |        页码大小         |
| currentPage |    是    | int  | 当前页(设置1为首页即可) |

categoryID : [2]

注：此为单类别的查询，本来传入的 categoryID 可以改为 一个int，此处是与 (4.5 获取全部商品) 的复用一个函数,

​	同时方便前端书写。

**返回示例：**

```javascript
{
	"code": "001",
	"Product": [
		{
			"product_id": 18,
			"product_name": "米家互联网洗烘一体机 Pro 10kg",
			"category_id": 4,
			"product_title": "智能洗烘，省心省力",
			"product_intro": "国标双A+级洗烘能力 / 22种洗烘模式 / 智能投放洗涤剂 / 支持小爱同学语音遥控 / 支持OTA在线智能升级 / 智能空气洗 / 除菌率达99.9%+",
			"product_picture": "public/imgs/appliance/Washer-Pro-10.png",
			"product_price": 2999,
			"product_selling_price": 2999,
			"product_num": 20,
			"product_sales": 7
		},
		{
			"product_id": 53,
			"product_name": "米家互联网洗烘一体机 Pro 10kg",
			"category_id": 4,
			"product_title": "智能洗烘，省心省力",
			"product_intro": "国标双A+级洗烘能力 / 22种洗烘模式 / 智能投放洗涤剂 / 支持小爱同学语音遥控 / 支持OTA在线智能升级 / 智能空气洗 / 除菌率达99.9%+",
			"product_picture": "public/imgs/appliance/Washer-Pro-10.png",
			"product_price": 2999,
			"product_selling_price": 2999,
			"product_num": 20,
			"product_sales": 7
		}
	],
	"total": 2
}
```

###



### 4.7  由商品分类获取热门商品信息-----(多类)

注 :  多类别自定义

**请求URL：**

```
/product/getHotProduct/
```

**请求方式：**

```
Post
```

**参数说明：**

|   参数   | 是否必选 |  类型  |  说明  |
| :------: | :------: | :----: | :----: |
| categoryName |    是    | [] | 类别名称 |

可考虑直接使用categoryID, 如果后续制作后台管理，名称可修改

categoryName  :  ["保护套", "保护膜", "充电器", "充电宝"]

这里就是从上述4类里面按照销量顺序从高到低返回7条数据，视为热门商品

**返回示例：**

```javascript
{
    'code': '001', 
     'Product': [
         {'product_id': 19,
          'category_id': 5,
          'product_name': 
          'Redmi K20/ K20 Pro 怪力魔王保护壳',
          'product_title': '怪力魔王专属定制',
          'product_intro': '优选PC材料，强韧张力，经久耐用 / 精选开孔，全面贴合机身 / 手感轻薄细腻，舒适无负担 / 三款颜色可选，彰显个性，与众不同',
          'product_picture': 'public/imgs/accessory/protectingShell-RedMi-K20&pro.png', 
          'product_price': 39.0, 
          'product_selling_price': 39.0,
          'product_num': 20, 
          'product_sales': 10}
        ........(默认返回7条数据)
         ]
}
```

### 4.8  搜索商品

**请求URL：**

```
/product/getProductBySearch/
```

**请求方式：**

```
Post
```

**参数说明：**

|   参数   | 是否必选 |  类型  |  说明  |
| :------: | :------: | :----: | :----: |
| search |    是    | str | 搜索内容 |
| pageSize | 是 | int | 页码大小 |
| currentPage | 是 | int | 当前页(设置1为首页即可) |

**返回示例：**

1、 搜索条件为某个分类名称 (完全匹配) ,返回该分类的全部商品信息

seach : 充电宝

```javascript
{
	"code": "001",
	"Product": [
		{
			"product_id": 30,
			"category_id": 8,
			"product_name": "小米无线充电宝青春版10000mAh",
			"product_title": "能量满满，无线有线都能充",
			"product_intro": "10000mAh大容量 / 支持边充边放 / 有线无线都能充 / 双向快充",
			"product_picture": "public/imgs/accessory/charger-10000mAh.png",
			"product_price": 129,
			"product_selling_price": 129,
			"product_num": 20,
			"product_sales": 8
		},
		{
			"product_id": 65,
			"category_id": 8,
			"product_name": "小米无线充电宝青春版10000mAh",
			"product_title": "能量满满，无线有线都能充",
			"product_intro": "10000mAh大容量 / 支持边充边放 / 有线无线都能充 / 双向快充",
			"product_picture": "public/imgs/accessory/charger-10000mAh.png",
			"product_price": 129,
			"product_selling_price": 129,
			"product_num": 20,
			"product_sales": 8
		}
	],
	"total": 2
}
```

2、返回根据查询条件模糊查询的商品分页结果

search :  8A

```javascript
{
	"code": "001",
	"Product": [
		{
			"product_id": 5,
			"category_id": 1,
			"product_name": "Redmi 8A",
			"product_title": "5000mAh超长续航",
			"product_intro": "5000mAh超长续航 / 高通骁龙439八核处理器 / 4GB+64GB / 1200万AI后置相机",
			"product_picture": "public/imgs/phone/Redmi-8A.png",
			"product_price": 599,
			"product_selling_price": 699,
			"product_num": 20,
			"product_sales": 0
		},
		{
			"product_id": 40,
			"category_id": 1,
			"product_name": "Redmi 8A",
			"product_title": "5000mAh超长续航",
			"product_intro": "5000mAh超长续航 / 高通骁龙439八核处理器 / 4GB+64GB / 1200万AI后置相机",
			"product_picture": "public/imgs/phone/Redmi-8A.png",
			"product_price": 599,
			"product_selling_price": 699,
			"product_num": 20,
			"product_sales": 0
		}
	],
	"total": 2
}
```



## 五、 订单模块

### 5.1  添加订单

(products来着 2.1节 获取购物车信息的返回)
**请求URL：**

```
/user/order/addOrder/
```

**请求方式：**

```
Post
```

**参数说明：**

|   参数   | 是否必选 |  类型  |  说明  |
| :------: | :------: | :----: | :----: |
| user_id |    是    | int | 用户ID |
| products |    是    | [{…}, {…}] |  结算的全部商品  |

	products结构  (用到的部分)
	{
	  productID: "", // 商品id
	  price: "", // 商品价格
	  num: "", // 商品数量
	}
	[{ productID: 1,  price: 1599, num: 1}]


​	
​	购物车信息的返回：
​	{
​	    "id": 4,
​	    "productID": 36,
​	    "productName": "Redmi K30",
​	    "productImg": "public/imgs/phone/Redmi-k30.png",
​	    "price": 1599,
​	    "num": 1,
​	    "maxNum": 5,
​	    "check": false
​	},

**返回示例：**

```javascript
{'code': '001', 'msg': '购买成功'}
{'code': '002', 'msg': '购买失败'}
```

### 5.2  获取已有订单

**请求URL：**

```
/user/order/getOrder/
```

**请求方式：**

```
Post
```

**参数说明：**

|  参数   | 是否必选 | 类型 |  说明  |
| :-----: | :------: | :--: | :----: |
| user_id |    是    | int  | 用户ID |

**返回示例：**

```javascript
{
	"code": "001",
	"orders": [
		[
			{
				"id": 4,
				"order_id": 11659522650709,
				"user_id": 1,
				"product_id": 1,
				"product_num": 1,
				"order_time": 1659522650709,
				"product_price": 1599,
				"product_name": "Redmi K30",
				"product_picture": "public/imgs/phone/Redmi-k30.png"
			}
		],
	]
}

{'code': '002', 'msg': '该用户没有订单信息'}
```

##  六、收藏模块

### 6.1  查看收藏

**请求URL：**

```
/user/collect/getCollect
```

**请求方式：**

```
Post
```

**参数说明：**

|   参数   | 是否必选 |  类型  |  说明  |
| :------: | :------: | :----: | :----: |
| user_id |    是    | int | 用户ID |


**返回示例：**

```javascript
{
	"code": "001",
	"collectList": [
		{
			"product_id": 3,
			"category_id": 1,
			"product_name": "小米CC9 Pro",
			"product_title": "1亿像素,五摄四闪",
			"product_intro": "1亿像素主摄 / 全场景五摄像头 / 四闪光灯 / 3200万自拍 / 10 倍混合光学变焦，50倍数字变焦 / 5260mAh ⼤电量 / 标配 30W疾速快充 / ⼩米⾸款超薄屏下指纹 / 德国莱茵低蓝光认证 / 多功能NFC / 红外万能遥控 / 1216超线性扬声器",
			"product_picture": "public/imgs/phone/Mi-CC9.png",
			"product_price": 2799,
			"product_selling_price": 2599,
			"product_num": 20,
			"product_sales": 0
		},
		......
	]
}

        
{	'code': '002',
	 'msg': '该用户没有收藏的商品'
}
```

### 6.2  添加收藏

**请求URL：**

```
/user/order/getOrder/
```

**请求方式：**

```
Post
```

**参数说明：**

|  参数   | 是否必选 | 类型 |  说明  |
| :-----: | :------: | :--: | :----: |
| user_id |    是    | int  | 用户ID |
| product_id |    是    | int  | 商品ID |

**返回示例：**

```javascript
{
	"code": "001",
	"msg": "添加收藏成功"
}
{
	"code": "003",
	"msg": "该商品已经添加收藏，请到我的收藏查看"
}
```


### 6.3  删除收藏

(由于前端界面采用卡片式布局，删除选择了逐一删除，可考虑改为多选)
**请求URL：**

```
/user/collect/deleteCollect/
```

**请求方式：**

```
Post
```

**参数说明：**

|   参数   | 是否必选 |  类型  |  说明  |
| :------: | :------: | :----: | :----: |
| user_id |    是    | int | 用户ID |
| product_id |    是    | int  | 商品ID |


**返回示例：**

```javascript
{
	"code": "001",
	"msg": "删除收藏成功"
}

{
	"code": "002",
	"msg": "该商品不在收藏列表"
}
```

