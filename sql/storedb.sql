/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.7.36 : Database - storedb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`storedb` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `storedb`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `adminName` char(40) NOT NULL,
  `password` char(40) NOT NULL,
  `userPhoneNumber` char(11) DEFAULT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `admin` */

insert  into `admin`(`admin_id`,`adminName`,`password`,`userPhoneNumber`) values (1,'admin','admin123','12312345678'),(2,'qqqqqq','qqqqqq',NULL);

/*Table structure for table `carousel` */

DROP TABLE IF EXISTS `carousel`;

CREATE TABLE `carousel` (
  `carousel_id` int(11) NOT NULL AUTO_INCREMENT,
  `imgPath` char(50) NOT NULL,
  PRIMARY KEY (`carousel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `carousel` */

insert  into `carousel`(`carousel_id`,`imgPath`) values (1,'public/imgs/carousel/carousel1.jpg'),(2,'public/imgs/carousel/carousel2.jpg'),(3,'public/imgs/carousel/carousel3.jpg'),(4,'public/imgs/carousel/carousel4.jpg');

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` char(20) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `category` */

insert  into `category`(`category_id`,`category_name`) values (1,'手机'),(2,'电视机'),(3,'空调'),(4,'洗衣机'),(5,'保护套'),(6,'保护膜'),(7,'充电器'),(8,'充电宝');

/*Table structure for table `collect` */

DROP TABLE IF EXISTS `collect`;

CREATE TABLE `collect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `collect_time` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_collect_user_id` (`user_id`),
  KEY `FK_collect_id` (`product_id`),
  CONSTRAINT `FK_collect_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `FK_collect_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `collect` */

insert  into `collect`(`id`,`user_id`,`product_id`,`collect_time`) values (1,1,3,1658572365228),(2,1,5,1658572685508),(3,1,36,1658745562209);

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_content_type` */

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (1,'contenttypes','0001_initial','2022-08-02 01:26:54.060746');

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_num` int(11) NOT NULL,
  `product_price` double NOT NULL,
  `order_time` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_order_user_id` (`user_id`),
  KEY `FK_order_id` (`product_id`),
  CONSTRAINT `FK_order_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `FK_order_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `orders` */

insert  into `orders`(`id`,`order_id`,`user_id`,`product_id`,`product_num`,`product_price`,`order_time`) values (1,11658572661365,1,2,1,2599,1658572661365),(2,11658738170433,1,5,1,699,1658738170433);

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` char(100) NOT NULL,
  `category_id` int(11) NOT NULL,
  `product_title` char(30) NOT NULL,
  `product_intro` text NOT NULL,
  `product_picture` char(200) DEFAULT NULL,
  `product_price` double NOT NULL,
  `product_selling_price` double NOT NULL,
  `product_num` int(11) NOT NULL,
  `product_sales` int(11) NOT NULL,
  PRIMARY KEY (`product_id`),
  KEY `FK_product_category` (`category_id`),
  CONSTRAINT `FK_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

/*Data for the table `product` */

insert  into `product`(`product_id`,`product_name`,`category_id`,`product_title`,`product_intro`,`product_picture`,`product_price`,`product_selling_price`,`product_num`,`product_sales`) values (1,'Redmi K30',1,'120Hz流速屏，全速热爱','120Hz高帧率流速屏/ 索尼6400万前后六摄 / 6.67\'小孔径全面屏 / 最高可选8GB+256GB大存储 / 高通骁龙730G处理器 / 3D四曲面玻璃机身 / 4500mAh+27W快充 / 多功能NFC','public/imgs/phone/Redmi-k30.png',2000,1599,10,0),(2,'Redmi K30 5G',1,'双模5G,120Hz流速屏','双模5G / 三路并发 / 高通骁龙765G / 7nm 5G低功耗处理器 / 120Hz高帧率流速屏 / 6.67\'小孔径全面屏 / 索尼6400万前后六摄 / 最高可选8GB+256GB大存储 / 4500mAh+30W快充 / 3D四曲面玻璃机身 / 多功能NFC','public/imgs/phone/Redmi-k30-5G.png',2599,2599,10,0),(3,'小米CC9 Pro',1,'1亿像素,五摄四闪','1亿像素主摄 / 全场景五摄像头 / 四闪光灯 / 3200万自拍 / 10 倍混合光学变焦，50倍数字变焦 / 5260mAh ⼤电量 / 标配 30W疾速快充 / ⼩米⾸款超薄屏下指纹 / 德国莱茵低蓝光认证 / 多功能NFC / 红外万能遥控 / 1216超线性扬声器','public/imgs/phone/Mi-CC9.png',2799,2599,20,0),(4,'Redmi 8',1,'5000mAh超长续航','5000mAh超长续航 / 高通骁龙439八核处理器 / 4GB+64GB','public/imgs/phone/Redmi-8.png',799,699,20,0),(5,'Redmi 8A',1,'5000mAh超长续航','5000mAh超长续航 / 高通骁龙439八核处理器 / 4GB+64GB / 1200万AI后置相机','public/imgs/phone/Redmi-8A.png',599,699,20,0),(6,'Redmi Note8 Pro',1,'6400万全场景四摄','6400万四摄小金刚拍照新旗舰超强解析力，超震撼','public/imgs/phone/Redmi-Note8-pro.png',1399,1199,20,0),(7,'Redmi Note8',1,'千元4800万四摄','千元4800万四摄 | 高通骁龙665 | 小金刚品质保证','public/imgs/phone/Redmi-Note8.png',999,999,20,0),(8,'Redmi 7A',1,'小巧大电量 持久流畅','小巧大电量，持久又流畅骁龙8核高性能处理器 | 4000mAh超长续航 | AI人脸解锁 | 整机防泼溅','public/imgs/phone/Redmi-7A.png',599,539,20,0),(9,'小米电视4A 32英寸',2,'人工智能系统，高清液晶屏','小米电视4A 32英寸 | 64位四核处理器 | 1GB+4GB大内存 | 人工智能系统','public/imgs/appliance/MiTv-4A-32.png',799,799,10,0),(10,'小米全面屏电视E55A',2,'全面屏设计，人工智能语音','全面屏设计 | 内置小爱同学 | 4K + HDR | 杜比DTS | PatchWall | 海量内容 | 2GB + 8GB大存储 | 64位四核处理器','public/imgs/appliance/MiTv-E55A.png',2099,1899,10,0),(11,'小米全面屏电视E65A',2,'全面屏设计，人工智能语音','人工智能语音系统 | 海量影视内容 | 4K 超高清屏 | 杜比音效 | 64位四核处理器 | 2GB + 8GB大存储','public/imgs/appliance/MiTv-E65A.png',3999,2799,10,0),(12,'小米电视4X 43英寸',2,'FHD全高清屏，人工智能语音','人工智能语音系统 | FHD全高清屏 | 64位四核处理器 | 海量片源 | 1GB+8GB大内存 | 钢琴烤漆','public/imgs/appliance/MiTv-4X-43.png',1499,1299,10,0),(13,'小米电视4C 55英寸',2,'4K HDR，人工智能系统','人工智能 | 大内存 | 杜比音效 | 超窄边 | 4K HDR | 海量片源 | 纤薄机身| 钢琴烤漆','public/imgs/appliance/MiTv-4C-55.png',1999,1799,10,0),(14,'小米电视4A 65英寸',2,'4K HDR，人工智能系统','人工智能 | 大内存 | 杜比音效 | 超窄边 | 4K HDR | 海量片源 | 纤薄机身| 钢琴烤漆','public/imgs/appliance/MiTv-4A-65.png',2999,2799,10,0),(15,'小米壁画电视 65英寸',2,'壁画外观，全面屏，远场语音','纯平背板 | 通体13.9mm | 远场语音 | 4K+HDR | 杜比+DTS | 画框模式 | 内置小爱同学 | PatchWall | SoundBar+低音炮 | 四核处理器+大存储','public/imgs/appliance/MiTv-ArtTv-65.png',6999,6999,10,0),(16,'米家互联网空调C1（一级能效）',3,'变频节能省电，自清洁','一级能效 | 1.5匹 | 全直流变频 | 高效制冷/热 | 静音设计 | 自清洁 | 全屋互联','public/imgs/appliance/AirCondition-V1C1.png',2699,2599,20,10),(17,'米家空调',3,'出众静音，快速制冷热','大1匹 | 三级能效 | 静音 | 快速制冷热 | 广角送风 | 除湿功能 | 高密度过滤网 | 典雅外观','public/imgs/appliance/AirCondition-F3W1.png',1799,1699,20,8),(18,'米家互联网洗烘一体机 Pro 10kg',4,'智能洗烘，省心省力','国标双A+级洗烘能力 / 22种洗烘模式 / 智能投放洗涤剂 / 支持小爱同学语音遥控 / 支持OTA在线智能升级 / 智能空气洗 / 除菌率达99.9%+','public/imgs/appliance/Washer-Pro-10.png',2999,2999,20,7),(19,'Redmi K20/ K20 Pro 怪力魔王保护壳',5,'怪力魔王专属定制','优选PC材料，强韧张力，经久耐用 / 精选开孔，全面贴合机身 / 手感轻薄细腻，舒适无负担 / 三款颜色可选，彰显个性，与众不同','public/imgs/accessory/protectingShell-RedMi-K20&pro.png',39,39,20,10),(20,'小米9 ARE U OK保护壳',5,'一个与众不同的保护壳','彰显独特个性 / 轻薄无负担 / 优选PC材料 / 贴合机身 / 潮流五色','public/imgs/accessory/protectingShell-Mi-9.png',49,39,20,10),(21,'小米CC9&小米CC9美图定制版 标准高透贴膜',6,'高清透亮，耐磨性强','耐磨性强，防护更出众 / 疏油疏水，有效抗水抗脏污 / 高清透亮，保留了原生屏幕的亮丽颜色和清晰度 / 操作灵敏，智能吸附 / 进口高端PET材质，裸机般手感','public/imgs/accessory/protectingMen-Mi-CC9.png',19,19,20,9),(22,'小米CC9e 标准高透贴膜',6,'高清透亮，耐磨性强','耐磨性强，防护更出众 / 疏油疏水，有效抗水抗脏污 / 高清透亮，保留了原生屏幕的亮丽颜色和清晰度 / 操作灵敏，智能吸附 / 进口高端PET材质，裸机般手感','public/imgs/accessory/protectingMen-Mi-CC9e.png',19,19,20,9),(23,'小米USB充电器30W快充版（1A1C）',7,'多一种接口，多一种选择','双口输出 / 30W 输出 / 可折叠插脚 / 小巧便携','public/imgs/accessory/charger-30w.png',59,59,20,8),(24,'小米USB充电器快充版（18W）',7,'安卓、苹果设备均可使用','支持QC3.0设备充电 / 支持iOS设备充电/ 美观耐用','public/imgs/accessory/charger-18w.png',29,29,20,8),(25,'小米USB充电器60W快充版（6口）',7,'6口输出，USB-C输出接口','6口输出 / USB-C输出接口 / 支持QC3.0快充协议 / 总输出功率60W','public/imgs/accessory/charger-60w.png',129,129,20,0),(26,'小米USB充电器36W快充版（2口）',7,'6多重安全保护，小巧便携','双USB输出接口 / 支持QC3.0快充协议 / 多重安全保护 / 小巧便携','public/imgs/accessory/charger-36w.png',59,59,20,0),(27,'小米车载充电器快充版',7,'让爱车成为移动充电站','QC3.0 双口输出 / 智能温度控制 / 5重安全保护 / 兼容iOS&Android设备','public/imgs/accessory/charger-car.png',69,69,20,0),(28,'小米车载充电器快充版(37W)',7,'双口快充，车载充电更安全','单口27W 快充 / 双口输出 / 多重安全保护','public/imgs/accessory/charger-car-37w.png',49,49,20,0),(29,'小米二合一移动电源（充电器）',7,'一个设备多种用途','5000mAh充沛电量 / 多协议快充 / USB 口输出','public/imgs/accessory/charger-tio.png',99,99,20,0),(30,'小米无线充电宝青春版10000mAh',8,'能量满满，无线有线都能充','10000mAh大容量 / 支持边充边放 / 有线无线都能充 / 双向快充','public/imgs/accessory/charger-10000mAh.png',129,129,20,8),(31,'小米CC9 Pro/尊享版 撞色飘带保护壳',5,'全面贴合，无感更舒适','优选环保PC材质，强韧张力，全面贴合，无感更舒适','public/imgs/accessory/protectingShell-Mi-CC9Pro.png',69,69,20,0),(32,'Redmi K20系列 幻境之心保护壳',5,'柔软坚韧,全面贴合','优质环保材质，柔软坚韧 / 全面贴合，有效抵抗灰尘 / 鲜亮三种颜色可选，为爱机随时换装','public/imgs/accessory/protectingShell-RedMi-K20.png',39,39,20,0),(33,'小米9 SE 街头风保护壳黑色',5,'个性时尚,细节出众','个性时尚 / 细节出众 / 纤薄轻巧 / 多彩时尚','public/imgs/accessory/protectingShell-Mi-9SE.png',49,49,20,0),(34,'小米9 街头风保护壳 红色',5,'个性时尚,细节出众','时尚多彩 / 细节出众 / 纤薄轻巧 / 是腕带也是支架','public/imgs/accessory/protectingShell-Mi-9-red.png',49,49,20,0),(35,'小米MIX 3 极简保护壳蓝色',5,'时尚简约设计，手感细腻顺滑','时尚简约设计，手感细腻顺滑 / 优质环保PC原材料，强韧张力，经久耐用 / 超薄 0.8MM厚度','public/imgs/accessory/protectingShell-Mix-3.png',49,12.9,20,0),(36,'Redmi K30',1,'120Hz流速屏，全速热爱','120Hz高帧率流速屏/ 索尼6400万前后六摄 / 6.67\'小孔径全面屏 / 最高可选8GB+256GB大存储 / 高通骁龙730G处理器 / 3D四曲面玻璃机身 / 4500mAh+27W快充 / 多功能NFC','public/imgs/phone/Redmi-k30.png',2000,1599,10,0),(37,'Redmi K30 5G',1,'双模5G,120Hz流速屏','双模5G / 三路并发 / 高通骁龙765G / 7nm 5G低功耗处理器 / 120Hz高帧率流速屏 / 6.67\'小孔径全面屏 / 索尼6400万前后六摄 / 最高可选8GB+256GB大存储 / 4500mAh+30W快充 / 3D四曲面玻璃机身 / 多功能NFC','public/imgs/phone/Redmi-k30-5G.png',2599,2599,10,0),(38,'小米CC9 Pro',1,'1亿像素,五摄四闪','1亿像素主摄 / 全场景五摄像头 / 四闪光灯 / 3200万自拍 / 10 倍混合光学变焦，50倍数字变焦 / 5260mAh ⼤电量 / 标配 30W疾速快充 / ⼩米⾸款超薄屏下指纹 / 德国莱茵低蓝光认证 / 多功能NFC / 红外万能遥控 / 1216超线性扬声器','public/imgs/phone/Mi-CC9.png',2799,2599,20,0),(39,'Redmi 8',1,'5000mAh超长续航','5000mAh超长续航 / 高通骁龙439八核处理器 / 4GB+64GB','public/imgs/phone/Redmi-8.png',799,699,20,0),(40,'Redmi 8A',1,'5000mAh超长续航','5000mAh超长续航 / 高通骁龙439八核处理器 / 4GB+64GB / 1200万AI后置相机','public/imgs/phone/Redmi-8A.png',599,699,20,0),(41,'Redmi Note8 Pro',1,'6400万全场景四摄','6400万四摄小金刚拍照新旗舰超强解析力，超震撼','public/imgs/phone/Redmi-Note8-pro.png',1399,1199,20,0),(42,'Redmi Note8',1,'千元4800万四摄','千元4800万四摄 | 高通骁龙665 | 小金刚品质保证','public/imgs/phone/Redmi-Note8.png',999,999,20,0),(43,'Redmi 7A',1,'小巧大电量 持久流畅','小巧大电量，持久又流畅骁龙8核高性能处理器 | 4000mAh超长续航 | AI人脸解锁 | 整机防泼溅','public/imgs/phone/Redmi-7A.png',599,539,20,0),(44,'小米电视4A 32英寸',2,'人工智能系统，高清液晶屏','小米电视4A 32英寸 | 64位四核处理器 | 1GB+4GB大内存 | 人工智能系统','public/imgs/appliance/MiTv-4A-32.png',799,799,10,0),(45,'小米全面屏电视E55A',2,'全面屏设计，人工智能语音','全面屏设计 | 内置小爱同学 | 4K + HDR | 杜比DTS | PatchWall | 海量内容 | 2GB + 8GB大存储 | 64位四核处理器','public/imgs/appliance/MiTv-E55A.png',2099,1899,10,0),(46,'小米全面屏电视E65A',2,'全面屏设计，人工智能语音','人工智能语音系统 | 海量影视内容 | 4K 超高清屏 | 杜比音效 | 64位四核处理器 | 2GB + 8GB大存储','public/imgs/appliance/MiTv-E65A.png',3999,2799,10,0),(47,'小米电视4X 43英寸',2,'FHD全高清屏，人工智能语音','人工智能语音系统 | FHD全高清屏 | 64位四核处理器 | 海量片源 | 1GB+8GB大内存 | 钢琴烤漆','public/imgs/appliance/MiTv-4X-43.png',1499,1299,10,0),(48,'小米电视4C 55英寸',2,'4K HDR，人工智能系统','人工智能 | 大内存 | 杜比音效 | 超窄边 | 4K HDR | 海量片源 | 纤薄机身| 钢琴烤漆','public/imgs/appliance/MiTv-4C-55.png',1999,1799,10,0),(49,'小米电视4A 65英寸',2,'4K HDR，人工智能系统','人工智能 | 大内存 | 杜比音效 | 超窄边 | 4K HDR | 海量片源 | 纤薄机身| 钢琴烤漆','public/imgs/appliance/MiTv-4A-65.png',2999,2799,10,0),(50,'小米壁画电视 65英寸',2,'壁画外观，全面屏，远场语音','纯平背板 | 通体13.9mm | 远场语音 | 4K+HDR | 杜比+DTS | 画框模式 | 内置小爱同学 | PatchWall | SoundBar+低音炮 | 四核处理器+大存储','public/imgs/appliance/MiTv-ArtTv-65.png',6999,6999,10,0),(51,'米家互联网空调C1（一级能效）',3,'变频节能省电，自清洁','一级能效 | 1.5匹 | 全直流变频 | 高效制冷/热 | 静音设计 | 自清洁 | 全屋互联','public/imgs/appliance/AirCondition-V1C1.png',2699,2599,20,10),(52,'米家空调',3,'出众静音，快速制冷热','大1匹 | 三级能效 | 静音 | 快速制冷热 | 广角送风 | 除湿功能 | 高密度过滤网 | 典雅外观','public/imgs/appliance/AirCondition-F3W1.png',1799,1699,20,8),(53,'米家互联网洗烘一体机 Pro 10kg',4,'智能洗烘，省心省力','国标双A+级洗烘能力 / 22种洗烘模式 / 智能投放洗涤剂 / 支持小爱同学语音遥控 / 支持OTA在线智能升级 / 智能空气洗 / 除菌率达99.9%+','public/imgs/appliance/Washer-Pro-10.png',2999,2999,20,7),(54,'Redmi K20/ K20 Pro 怪力魔王保护壳',5,'怪力魔王专属定制','优选PC材料，强韧张力，经久耐用 / 精选开孔，全面贴合机身 / 手感轻薄细腻，舒适无负担 / 三款颜色可选，彰显个性，与众不同','public/imgs/accessory/protectingShell-RedMi-K20&pro.png',39,39,20,10),(55,'小米9 ARE U OK保护壳',5,'一个与众不同的保护壳','彰显独特个性 / 轻薄无负担 / 优选PC材料 / 贴合机身 / 潮流五色','public/imgs/accessory/protectingShell-Mi-9.png',49,39,20,10),(56,'小米CC9&小米CC9美图定制版 标准高透贴膜',6,'高清透亮，耐磨性强','耐磨性强，防护更出众 / 疏油疏水，有效抗水抗脏污 / 高清透亮，保留了原生屏幕的亮丽颜色和清晰度 / 操作灵敏，智能吸附 / 进口高端PET材质，裸机般手感','public/imgs/accessory/protectingMen-Mi-CC9.png',19,19,20,9),(57,'小米CC9e 标准高透贴膜',6,'高清透亮，耐磨性强','耐磨性强，防护更出众 / 疏油疏水，有效抗水抗脏污 / 高清透亮，保留了原生屏幕的亮丽颜色和清晰度 / 操作灵敏，智能吸附 / 进口高端PET材质，裸机般手感','public/imgs/accessory/protectingMen-Mi-CC9e.png',19,19,20,9),(58,'小米USB充电器30W快充版（1A1C）',7,'多一种接口，多一种选择','双口输出 / 30W 输出 / 可折叠插脚 / 小巧便携','public/imgs/accessory/charger-30w.png',59,59,20,8),(59,'小米USB充电器快充版（18W）',7,'安卓、苹果设备均可使用','支持QC3.0设备充电 / 支持iOS设备充电/ 美观耐用','public/imgs/accessory/charger-18w.png',29,29,20,8),(60,'小米USB充电器60W快充版（6口）',7,'6口输出，USB-C输出接口','6口输出 / USB-C输出接口 / 支持QC3.0快充协议 / 总输出功率60W','public/imgs/accessory/charger-60w.png',129,129,20,0),(61,'小米USB充电器36W快充版（2口）',7,'6多重安全保护，小巧便携','双USB输出接口 / 支持QC3.0快充协议 / 多重安全保护 / 小巧便携','public/imgs/accessory/charger-36w.png',59,59,20,0),(62,'小米车载充电器快充版',7,'让爱车成为移动充电站','QC3.0 双口输出 / 智能温度控制 / 5重安全保护 / 兼容iOS&Android设备','public/imgs/accessory/charger-car.png',69,69,20,0),(63,'小米车载充电器快充版(37W)',7,'双口快充，车载充电更安全','单口27W 快充 / 双口输出 / 多重安全保护','public/imgs/accessory/charger-car-37w.png',49,49,20,0),(64,'小米二合一移动电源（充电器）',7,'一个设备多种用途','5000mAh充沛电量 / 多协议快充 / USB 口输出','public/imgs/accessory/charger-tio.png',99,99,20,0),(65,'小米无线充电宝青春版10000mAh',8,'能量满满，无线有线都能充','10000mAh大容量 / 支持边充边放 / 有线无线都能充 / 双向快充','public/imgs/accessory/charger-10000mAh.png',129,129,20,8),(66,'小米CC9 Pro/尊享版 撞色飘带保护壳',5,'全面贴合，无感更舒适','优选环保PC材质，强韧张力，全面贴合，无感更舒适','public/imgs/accessory/protectingShell-Mi-CC9Pro.png',69,69,20,0),(67,'Redmi K20系列 幻境之心保护壳',5,'柔软坚韧,全面贴合','优质环保材质，柔软坚韧 / 全面贴合，有效抵抗灰尘 / 鲜亮三种颜色可选，为爱机随时换装','public/imgs/accessory/protectingShell-RedMi-K20.png',39,39,20,0),(68,'小米9 SE 街头风保护壳黑色',5,'个性时尚,细节出众','个性时尚 / 细节出众 / 纤薄轻巧 / 多彩时尚','public/imgs/accessory/protectingShell-Mi-9SE.png',49,49,20,0),(69,'小米9 街头风保护壳 红色',5,'个性时尚,细节出众','时尚多彩 / 细节出众 / 纤薄轻巧 / 是腕带也是支架','public/imgs/accessory/protectingShell-Mi-9-red.png',49,49,20,0),(70,'小米MIX 3 极简保护壳蓝色',5,'时尚简约设计，手感细腻顺滑','时尚简约设计，手感细腻顺滑 / 优质环保PC原材料，强韧张力，经久耐用 / 超薄 0.8MM厚度','public/imgs/accessory/protectingShell-Mix-3.png',49,12.9,20,0);

/*Table structure for table `product_picture` */

DROP TABLE IF EXISTS `product_picture`;

CREATE TABLE `product_picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `product_picture` char(200) DEFAULT NULL,
  `intro` text,
  PRIMARY KEY (`id`),
  KEY `FK_product_id` (`product_id`),
  CONSTRAINT `FK_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8;

/*Data for the table `product_picture` */

insert  into `product_picture`(`id`,`product_id`,`product_picture`,`intro`) values (1,1,'public/imgs/phone/picture/Redmi-k30-1.png',NULL),(2,1,'public/imgs/phone/picture/Redmi-k30-2.png',NULL),(3,1,'public/imgs/phone/picture/Redmi-k30-3.png',NULL),(4,1,'public/imgs/phone/picture/Redmi-k30-4.png',NULL),(5,1,'public/imgs/phone/picture/Redmi-k30-5.png',NULL),(6,2,'public/imgs/phone/picture/Redmi K30 5G-1.jpg',NULL),(7,2,'public/imgs/phone/picture/Redmi K30 5G-2.jpg',NULL),(8,2,'public/imgs/phone/picture/Redmi K30 5G-3.jpg',NULL),(9,2,'public/imgs/phone/picture/Redmi K30 5G-4.jpg',NULL),(10,2,'public/imgs/phone/picture/Redmi K30 5G-5.jpg',NULL),(11,3,'public/imgs/phone/picture/MI CC9 Pro-1.jpg',NULL),(12,3,'public/imgs/phone/picture/MI CC9 Pro-2.jpg',NULL),(13,3,'public/imgs/phone/picture/MI CC9 Pro-3.jpg',NULL),(14,3,'public/imgs/phone/picture/MI CC9 Pro-4.jpg',NULL),(15,3,'public/imgs/phone/picture/MI CC9 Pro-5.jpg',NULL),(16,3,'public/imgs/phone/picture/MI CC9 Pro-6.jpg',NULL),(17,4,'public/imgs/phone/picture/Redmi 8-1.jpg',NULL),(18,4,'public/imgs/phone/picture/Redmi 8-2.jpg',NULL),(19,4,'public/imgs/phone/picture/Redmi 8-3.jpg',NULL),(20,4,'public/imgs/phone/picture/Redmi 8-4.jpg',NULL),(21,4,'public/imgs/phone/picture/Redmi 8-5.jpg',NULL),(22,5,'public/imgs/phone/picture/Redmi 8A-1.jpg',NULL),(23,6,'public/imgs/phone/picture/Redmi Note8 Pro-1.png',NULL),(24,6,'public/imgs/phone/picture/Redmi Note8 Pro-2.png',NULL),(25,6,'public/imgs/phone/picture/Redmi Note8 Pro-3.png',NULL),(26,6,'public/imgs/phone/picture/Redmi Note8 Pro-4.png',NULL),(27,6,'public/imgs/phone/picture/Redmi Note8 Pro-5.png',NULL),(28,7,'public/imgs/phone/picture/Redmi Note8-1.jpg',NULL),(29,7,'public/imgs/phone/picture/Redmi Note8-2.jpg',NULL),(30,7,'public/imgs/phone/picture/Redmi Note8-3.jpg',NULL),(31,7,'public/imgs/phone/picture/Redmi Note8-4.jpg',NULL),(32,7,'public/imgs/phone/picture/Redmi Note8-5.jpg',NULL),(33,8,'public/imgs/phone/picture/Redmi 7A-1.jpg',NULL),(34,8,'public/imgs/phone/picture/Redmi 7A-2.jpg',NULL),(35,8,'public/imgs/phone/picture/Redmi 7A-3.jpg',NULL),(36,8,'public/imgs/phone/picture/Redmi 7A-4.jpg',NULL),(37,8,'public/imgs/phone/picture/Redmi 7A-5.jpg',NULL),(38,9,'public/imgs/phone/picture/MiTv-4A-32-1.jpg',NULL),(39,9,'public/imgs/phone/picture/MiTv-4A-32-2.jpg',NULL),(40,9,'public/imgs/phone/picture/MiTv-4A-32-3.jpg',NULL),(41,9,'public/imgs/phone/picture/MiTv-4A-32-4.jpg',NULL),(42,10,'public/imgs/phone/picture/MiTv-E55A-1.jpg',NULL),(43,10,'public/imgs/phone/picture/MiTv-E55A-2.jpg',NULL),(44,10,'public/imgs/phone/picture/MiTv-E55A-3.jpg',NULL),(45,10,'public/imgs/phone/picture/MiTv-E55A-4.jpg',NULL),(46,11,'public/imgs/phone/picture/MiTv-E65A-1.jpg',NULL),(47,11,'public/imgs/phone/picture/MiTv-E65A-2.jpg',NULL),(48,11,'public/imgs/phone/picture/MiTv-E65A-3.jpg',NULL),(49,11,'public/imgs/phone/picture/MiTv-E65A-4.jpg',NULL),(50,12,'public/imgs/phone/picture/MiTv-4X 43-1.jpg',NULL),(51,12,'public/imgs/phone/picture/MiTv-4X 43-2.jpg',NULL),(52,12,'public/imgs/phone/picture/MiTv-4X 43-3.jpg',NULL),(53,13,'public/imgs/phone/picture/MiTv-4C 55-1.jpg',NULL),(54,13,'public/imgs/phone/picture/MiTv-4C 55-2.jpg',NULL),(55,13,'public/imgs/phone/picture/MiTv-4C 55-3.jpg',NULL),(56,14,'public/imgs/phone/picture/MiTv-4A 65-1.jpg',NULL),(57,15,'public/imgs/phone/picture/MiTv-ArtTv-65-1.jpg',NULL),(58,16,'public/imgs/phone/picture/AirCondition-V1C1-1.jpg',NULL),(59,17,'public/imgs/phone/picture/AirCondition-F3W1-1.jpg',NULL),(60,18,'public/imgs/phone/picture/Washer-Pro-10-1.jpg',NULL),(61,18,'public/imgs/phone/picture/Washer-Pro-10-2.jpg',NULL),(62,18,'public/imgs/phone/picture/Washer-Pro-10-3.jpg',NULL),(63,18,'public/imgs/phone/picture/Washer-Pro-10-4.jpg',NULL),(64,19,'public/imgs/phone/picture/protectingShell-RedMi-K20&pro-1.jpg',NULL),(65,20,'public/imgs/phone/picture/protectingShell-Mi-9-1.jpg',NULL),(66,20,'public/imgs/phone/picture/protectingShell-Mi-9-2.jpg',NULL),(67,21,'public/imgs/phone/picture/protectingMen-Mi-CC9-1.jpg',NULL),(68,22,'public/imgs/phone/picture/protectingMen-Mi-CC9e-1.jpg',NULL),(69,23,'public/imgs/phone/picture/charger-30w-1.jpg',NULL),(70,23,'public/imgs/phone/picture/charger-30w-2.jpg',NULL),(71,23,'public/imgs/phone/picture/charger-30w-3.jpg',NULL),(72,23,'public/imgs/phone/picture/charger-30w-4.jpg',NULL),(73,24,'public/imgs/phone/picture/charger-18w-1.jpg',NULL),(74,24,'public/imgs/phone/picture/charger-18w-2.jpg',NULL),(75,24,'public/imgs/phone/picture/charger-18w-3.jpg',NULL),(76,25,'public/imgs/phone/picture/charger-60w-1.jpg',NULL),(77,25,'public/imgs/phone/picture/charger-60w-2.jpg',NULL),(78,25,'public/imgs/phone/picture/charger-60w-3.jpg',NULL),(79,25,'public/imgs/phone/picture/charger-60w-4.jpg',NULL),(80,26,'public/imgs/phone/picture/charger-36w-1.jpg',NULL),(81,26,'public/imgs/phone/picture/charger-36w-2.jpg',NULL),(82,26,'public/imgs/phone/picture/charger-36w-3.jpg',NULL),(83,26,'public/imgs/phone/picture/charger-36w-4.jpg',NULL),(84,26,'public/imgs/phone/picture/charger-36w-5.jpg',NULL),(85,27,'public/imgs/phone/picture/charger-car-1.jpg',NULL),(86,27,'public/imgs/phone/picture/charger-car-2.jpg',NULL),(87,27,'public/imgs/phone/picture/charger-car-3.jpg',NULL),(88,27,'public/imgs/phone/picture/charger-car-4.jpg',NULL),(89,27,'public/imgs/phone/picture/charger-car-5.jpg',NULL),(90,27,'public/imgs/phone/picture/charger-car-6.jpg',NULL),(91,28,'public/imgs/phone/picture/charger-car-37w-1.jpg',NULL),(92,28,'public/imgs/phone/picture/charger-car-37w-2.jpg',NULL),(93,28,'public/imgs/phone/picture/charger-car-37w-3.jpg',NULL),(94,28,'public/imgs/phone/picture/charger-car-37w-4.jpg',NULL),(95,28,'public/imgs/phone/picture/charger-car-37w-5.jpg',NULL),(96,29,'public/imgs/phone/picture/charger-tio-1.jpg',NULL),(97,29,'public/imgs/phone/picture/charger-tio-2.jpg',NULL),(98,29,'public/imgs/phone/picture/charger-tio-3.jpg',NULL),(99,29,'public/imgs/phone/picture/charger-tio-4.jpg',NULL),(100,29,'public/imgs/phone/picture/charger-tio-5.jpg',NULL),(101,30,'public/imgs/phone/picture/charger-10000mAh-1.jpg',NULL),(102,30,'public/imgs/phone/picture/charger-10000mAh-2.jpg',NULL),(103,30,'public/imgs/phone/picture/charger-10000mAh-3.jpg',NULL),(104,30,'public/imgs/phone/picture/charger-10000mAh-4.jpg',NULL),(105,30,'public/imgs/phone/picture/charger-10000mAh-5.jpg',NULL),(106,31,'public/imgs/phone/picture/protectingShell-Mi-CC9Pro-1.jpg',NULL),(107,32,'public/imgs/phone/picture/protectingShell-RedMi-K20-1.jpg',NULL),(108,33,'public/imgs/phone/picture/protectingShell-Mi-9SE-1.jpg',NULL),(109,34,'public/imgs/phone/picture/protectingShell-Mi-9-red-1.jpg',NULL),(110,35,'public/imgs/phone/picture/protectingShell-Mix-3-1.jpg',NULL),(111,1,'public/imgs/phone/picture/Redmi-k30-1.png',NULL),(112,1,'public/imgs/phone/picture/Redmi-k30-2.png',NULL),(113,1,'public/imgs/phone/picture/Redmi-k30-3.png',NULL),(114,1,'public/imgs/phone/picture/Redmi-k30-4.png',NULL),(115,1,'public/imgs/phone/picture/Redmi-k30-5.png',NULL),(116,2,'public/imgs/phone/picture/Redmi K30 5G-1.jpg',NULL),(117,2,'public/imgs/phone/picture/Redmi K30 5G-2.jpg',NULL),(118,2,'public/imgs/phone/picture/Redmi K30 5G-3.jpg',NULL),(119,2,'public/imgs/phone/picture/Redmi K30 5G-4.jpg',NULL),(120,2,'public/imgs/phone/picture/Redmi K30 5G-5.jpg',NULL),(121,3,'public/imgs/phone/picture/MI CC9 Pro-1.jpg',NULL),(122,3,'public/imgs/phone/picture/MI CC9 Pro-2.jpg',NULL),(123,3,'public/imgs/phone/picture/MI CC9 Pro-3.jpg',NULL),(124,3,'public/imgs/phone/picture/MI CC9 Pro-4.jpg',NULL),(125,3,'public/imgs/phone/picture/MI CC9 Pro-5.jpg',NULL),(126,3,'public/imgs/phone/picture/MI CC9 Pro-6.jpg',NULL),(127,4,'public/imgs/phone/picture/Redmi 8-1.jpg',NULL),(128,4,'public/imgs/phone/picture/Redmi 8-2.jpg',NULL),(129,4,'public/imgs/phone/picture/Redmi 8-3.jpg',NULL),(130,4,'public/imgs/phone/picture/Redmi 8-4.jpg',NULL),(131,4,'public/imgs/phone/picture/Redmi 8-5.jpg',NULL),(132,5,'public/imgs/phone/picture/Redmi 8A-1.jpg',NULL),(133,6,'public/imgs/phone/picture/Redmi Note8 Pro-1.png',NULL),(134,6,'public/imgs/phone/picture/Redmi Note8 Pro-2.png',NULL),(135,6,'public/imgs/phone/picture/Redmi Note8 Pro-3.png',NULL),(136,6,'public/imgs/phone/picture/Redmi Note8 Pro-4.png',NULL),(137,6,'public/imgs/phone/picture/Redmi Note8 Pro-5.png',NULL),(138,7,'public/imgs/phone/picture/Redmi Note8-1.jpg',NULL),(139,7,'public/imgs/phone/picture/Redmi Note8-2.jpg',NULL),(140,7,'public/imgs/phone/picture/Redmi Note8-3.jpg',NULL),(141,7,'public/imgs/phone/picture/Redmi Note8-4.jpg',NULL),(142,7,'public/imgs/phone/picture/Redmi Note8-5.jpg',NULL),(143,8,'public/imgs/phone/picture/Redmi 7A-1.jpg',NULL),(144,8,'public/imgs/phone/picture/Redmi 7A-2.jpg',NULL),(145,8,'public/imgs/phone/picture/Redmi 7A-3.jpg',NULL),(146,8,'public/imgs/phone/picture/Redmi 7A-4.jpg',NULL),(147,8,'public/imgs/phone/picture/Redmi 7A-5.jpg',NULL),(148,9,'public/imgs/phone/picture/MiTv-4A-32-1.jpg',NULL),(149,9,'public/imgs/phone/picture/MiTv-4A-32-2.jpg',NULL),(150,9,'public/imgs/phone/picture/MiTv-4A-32-3.jpg',NULL),(151,9,'public/imgs/phone/picture/MiTv-4A-32-4.jpg',NULL),(152,10,'public/imgs/phone/picture/MiTv-E55A-1.jpg',NULL),(153,10,'public/imgs/phone/picture/MiTv-E55A-2.jpg',NULL),(154,10,'public/imgs/phone/picture/MiTv-E55A-3.jpg',NULL),(155,10,'public/imgs/phone/picture/MiTv-E55A-4.jpg',NULL),(156,11,'public/imgs/phone/picture/MiTv-E65A-1.jpg',NULL),(157,11,'public/imgs/phone/picture/MiTv-E65A-2.jpg',NULL),(158,11,'public/imgs/phone/picture/MiTv-E65A-3.jpg',NULL),(159,11,'public/imgs/phone/picture/MiTv-E65A-4.jpg',NULL),(160,12,'public/imgs/phone/picture/MiTv-4X 43-1.jpg',NULL),(161,12,'public/imgs/phone/picture/MiTv-4X 43-2.jpg',NULL),(162,12,'public/imgs/phone/picture/MiTv-4X 43-3.jpg',NULL),(163,13,'public/imgs/phone/picture/MiTv-4C 55-1.jpg',NULL),(164,13,'public/imgs/phone/picture/MiTv-4C 55-2.jpg',NULL),(165,13,'public/imgs/phone/picture/MiTv-4C 55-3.jpg',NULL),(166,14,'public/imgs/phone/picture/MiTv-4A 65-1.jpg',NULL),(167,15,'public/imgs/phone/picture/MiTv-ArtTv-65-1.jpg',NULL),(168,16,'public/imgs/phone/picture/AirCondition-V1C1-1.jpg',NULL),(169,17,'public/imgs/phone/picture/AirCondition-F3W1-1.jpg',NULL),(170,18,'public/imgs/phone/picture/Washer-Pro-10-1.jpg',NULL),(171,18,'public/imgs/phone/picture/Washer-Pro-10-2.jpg',NULL),(172,18,'public/imgs/phone/picture/Washer-Pro-10-3.jpg',NULL),(173,18,'public/imgs/phone/picture/Washer-Pro-10-4.jpg',NULL),(174,19,'public/imgs/phone/picture/protectingShell-RedMi-K20&pro-1.jpg',NULL),(175,20,'public/imgs/phone/picture/protectingShell-Mi-9-1.jpg',NULL),(176,20,'public/imgs/phone/picture/protectingShell-Mi-9-2.jpg',NULL),(177,21,'public/imgs/phone/picture/protectingMen-Mi-CC9-1.jpg',NULL),(178,22,'public/imgs/phone/picture/protectingMen-Mi-CC9e-1.jpg',NULL),(179,23,'public/imgs/phone/picture/charger-30w-1.jpg',NULL),(180,23,'public/imgs/phone/picture/charger-30w-2.jpg',NULL),(181,23,'public/imgs/phone/picture/charger-30w-3.jpg',NULL),(182,23,'public/imgs/phone/picture/charger-30w-4.jpg',NULL),(183,24,'public/imgs/phone/picture/charger-18w-1.jpg',NULL),(184,24,'public/imgs/phone/picture/charger-18w-2.jpg',NULL),(185,24,'public/imgs/phone/picture/charger-18w-3.jpg',NULL),(186,25,'public/imgs/phone/picture/charger-60w-1.jpg',NULL),(187,25,'public/imgs/phone/picture/charger-60w-2.jpg',NULL),(188,25,'public/imgs/phone/picture/charger-60w-3.jpg',NULL),(189,25,'public/imgs/phone/picture/charger-60w-4.jpg',NULL),(190,26,'public/imgs/phone/picture/charger-36w-1.jpg',NULL),(191,26,'public/imgs/phone/picture/charger-36w-2.jpg',NULL),(192,26,'public/imgs/phone/picture/charger-36w-3.jpg',NULL),(193,26,'public/imgs/phone/picture/charger-36w-4.jpg',NULL),(194,26,'public/imgs/phone/picture/charger-36w-5.jpg',NULL),(195,27,'public/imgs/phone/picture/charger-car-1.jpg',NULL),(196,27,'public/imgs/phone/picture/charger-car-2.jpg',NULL),(197,27,'public/imgs/phone/picture/charger-car-3.jpg',NULL),(198,27,'public/imgs/phone/picture/charger-car-4.jpg',NULL),(199,27,'public/imgs/phone/picture/charger-car-5.jpg',NULL),(200,27,'public/imgs/phone/picture/charger-car-6.jpg',NULL),(201,28,'public/imgs/phone/picture/charger-car-37w-1.jpg',NULL),(202,28,'public/imgs/phone/picture/charger-car-37w-2.jpg',NULL),(203,28,'public/imgs/phone/picture/charger-car-37w-3.jpg',NULL),(204,28,'public/imgs/phone/picture/charger-car-37w-4.jpg',NULL),(205,28,'public/imgs/phone/picture/charger-car-37w-5.jpg',NULL),(206,29,'public/imgs/phone/picture/charger-tio-1.jpg',NULL),(207,29,'public/imgs/phone/picture/charger-tio-2.jpg',NULL),(208,29,'public/imgs/phone/picture/charger-tio-3.jpg',NULL),(209,29,'public/imgs/phone/picture/charger-tio-4.jpg',NULL),(210,29,'public/imgs/phone/picture/charger-tio-5.jpg',NULL),(211,30,'public/imgs/phone/picture/charger-10000mAh-1.jpg',NULL),(212,30,'public/imgs/phone/picture/charger-10000mAh-2.jpg',NULL),(213,30,'public/imgs/phone/picture/charger-10000mAh-3.jpg',NULL),(214,30,'public/imgs/phone/picture/charger-10000mAh-4.jpg',NULL),(215,30,'public/imgs/phone/picture/charger-10000mAh-5.jpg',NULL),(216,31,'public/imgs/phone/picture/protectingShell-Mi-CC9Pro-1.jpg',NULL),(217,32,'public/imgs/phone/picture/protectingShell-RedMi-K20-1.jpg',NULL),(218,33,'public/imgs/phone/picture/protectingShell-Mi-9SE-1.jpg',NULL),(219,34,'public/imgs/phone/picture/protectingShell-Mi-9-red-1.jpg',NULL),(220,35,'public/imgs/phone/picture/protectingShell-Mix-3-1.jpg',NULL);

/*Table structure for table `shoppingcart` */

DROP TABLE IF EXISTS `shoppingcart`;

CREATE TABLE `shoppingcart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `num` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_id` (`user_id`),
  KEY `FK_shoppingCart_id` (`product_id`),
  CONSTRAINT `FK_shoppingCart_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `FK_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `shoppingcart` */

insert  into `shoppingcart`(`id`,`user_id`,`product_id`,`num`) values (4,1,36,1);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` char(40) NOT NULL,
  `password` char(40) NOT NULL,
  `userPhoneNumber` char(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `userName` (`userName`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `users` */

insert  into `users`(`user_id`,`userName`,`password`,`userPhoneNumber`) values (1,'admin','admin123','12312345678'),(2,'qqqqq','qqqqqqqq',NULL),(3,'aaaaaa','aaaaaa',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
