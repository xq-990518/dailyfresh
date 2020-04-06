/*
 Navicat Premium Data Transfer

 Source Server         : ubuntu_106
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : 192.168.0.106:3306
 Source Schema         : dailyfresh

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 06/04/2020 12:24:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add 用户', 6, 'add_user');
INSERT INTO `auth_permission` VALUES (22, 'Can change 用户', 6, 'change_user');
INSERT INTO `auth_permission` VALUES (23, 'Can delete 用户', 6, 'delete_user');
INSERT INTO `auth_permission` VALUES (24, 'Can view 用户', 6, 'view_user');
INSERT INTO `auth_permission` VALUES (25, 'Can add 地址', 7, 'add_address');
INSERT INTO `auth_permission` VALUES (26, 'Can change 地址', 7, 'change_address');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 地址', 7, 'delete_address');
INSERT INTO `auth_permission` VALUES (28, 'Can view 地址', 7, 'view_address');
INSERT INTO `auth_permission` VALUES (29, 'Can add 商品SPU', 8, 'add_goods');
INSERT INTO `auth_permission` VALUES (30, 'Can change 商品SPU', 8, 'change_goods');
INSERT INTO `auth_permission` VALUES (31, 'Can delete 商品SPU', 8, 'delete_goods');
INSERT INTO `auth_permission` VALUES (32, 'Can view 商品SPU', 8, 'view_goods');
INSERT INTO `auth_permission` VALUES (33, 'Can add 商品', 9, 'add_goodssku');
INSERT INTO `auth_permission` VALUES (34, 'Can change 商品', 9, 'change_goodssku');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 商品', 9, 'delete_goodssku');
INSERT INTO `auth_permission` VALUES (36, 'Can view 商品', 9, 'view_goodssku');
INSERT INTO `auth_permission` VALUES (37, 'Can add 商品种类', 10, 'add_goodstype');
INSERT INTO `auth_permission` VALUES (38, 'Can change 商品种类', 10, 'change_goodstype');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 商品种类', 10, 'delete_goodstype');
INSERT INTO `auth_permission` VALUES (40, 'Can view 商品种类', 10, 'view_goodstype');
INSERT INTO `auth_permission` VALUES (41, 'Can add 主页促销活动', 11, 'add_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES (42, 'Can change 主页促销活动', 11, 'change_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES (43, 'Can delete 主页促销活动', 11, 'delete_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES (44, 'Can view 主页促销活动', 11, 'view_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES (45, 'Can add 主页分类展示商品', 12, 'add_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES (46, 'Can change 主页分类展示商品', 12, 'change_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES (47, 'Can delete 主页分类展示商品', 12, 'delete_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES (48, 'Can view 主页分类展示商品', 12, 'view_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES (49, 'Can add 主页轮播商品', 13, 'add_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES (50, 'Can change 主页轮播商品', 13, 'change_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES (51, 'Can delete 主页轮播商品', 13, 'delete_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES (52, 'Can view 主页轮播商品', 13, 'view_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES (53, 'Can add 商品图片', 14, 'add_goodsimage');
INSERT INTO `auth_permission` VALUES (54, 'Can change 商品图片', 14, 'change_goodsimage');
INSERT INTO `auth_permission` VALUES (55, 'Can delete 商品图片', 14, 'delete_goodsimage');
INSERT INTO `auth_permission` VALUES (56, 'Can view 商品图片', 14, 'view_goodsimage');
INSERT INTO `auth_permission` VALUES (57, 'Can add 订单商品', 15, 'add_ordergoods');
INSERT INTO `auth_permission` VALUES (58, 'Can change 订单商品', 15, 'change_ordergoods');
INSERT INTO `auth_permission` VALUES (59, 'Can delete 订单商品', 15, 'delete_ordergoods');
INSERT INTO `auth_permission` VALUES (60, 'Can view 订单商品', 15, 'view_ordergoods');
INSERT INTO `auth_permission` VALUES (61, 'Can add 订单', 16, 'add_orderinfo');
INSERT INTO `auth_permission` VALUES (62, 'Can change 订单', 16, 'change_orderinfo');
INSERT INTO `auth_permission` VALUES (63, 'Can delete 订单', 16, 'delete_orderinfo');
INSERT INTO `auth_permission` VALUES (64, 'Can view 订单', 16, 'view_orderinfo');

-- ----------------------------
-- Table structure for df_address
-- ----------------------------
DROP TABLE IF EXISTS `df_address`;
CREATE TABLE `df_address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `receiver` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `addr` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `zip_code` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_address_user_id_5e6a5c8a_fk_df_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `df_address_user_id_5e6a5c8a_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_address
-- ----------------------------
INSERT INTO `df_address` VALUES (4, '2020-04-04 05:06:47.164454', '2020-04-04 05:06:47.164485', 0, '薛庆', '宿州', '234000', '17356126331', 1, 45);
INSERT INTO `df_address` VALUES (5, '2020-04-04 05:38:37.672564', '2020-04-04 05:38:37.672596', 0, '小丑', '宿州', '234000', '17356126331', 0, 45);
INSERT INTO `df_address` VALUES (6, '2020-04-04 11:34:17.925639', '2020-04-04 11:34:17.925679', 0, 'xxx', '1231', '1231', '17356126331', 1, 1);

-- ----------------------------
-- Table structure for df_goods
-- ----------------------------
DROP TABLE IF EXISTS `df_goods`;
CREATE TABLE `df_goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `detail` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_goods
-- ----------------------------
INSERT INTO `df_goods` VALUES (1, '2020-03-13 03:00:14.560133', '2020-03-13 03:13:34.159388', 0, '草莓', '<p><span style=\"color: #666666; font-family: \'Microsoft Yahei\'; font-size: 12px;\">草莓采摘园位于北京大兴区 庞各庄镇四各庄村 ，每年1月-6月面向北京以及周围城市提供新鲜草莓采摘和精品礼盒装草莓，草莓品种多样丰富，个大香甜。所有草莓均严格按照有机标准培育，不使用任何化肥和农药。草莓在采摘期间免洗可以直接食用。欢迎喜欢草莓的市民前来采摘，也欢迎各大单位选购精品有机草莓礼盒，有机草莓礼盒是亲朋馈赠、福利送礼的最佳选择。</span></p>');
INSERT INTO `df_goods` VALUES (2, '2020-03-13 03:36:00.314953', '2020-03-13 03:37:07.036521', 0, '芒果', '<p><span style=\"color: #666666; font-family: \'Microsoft Yahei\'; font-size: 12px;\">来自海南的芒果</span></p>');
INSERT INTO `df_goods` VALUES (3, '2020-03-13 03:37:52.489241', '2020-03-13 03:37:52.489270', 0, '五花肉', '<p>新鲜的五花肉</p>');
INSERT INTO `df_goods` VALUES (4, '2020-03-13 03:38:24.935708', '2020-03-13 03:38:24.935737', 0, '神户大虾', '<p>澳洲龙虾</p>');
INSERT INTO `df_goods` VALUES (5, '2020-03-31 07:34:52.402437', '2020-03-31 07:36:05.253855', 0, '苹果', '<p><span style=\"font-size: 10px;\">苹果是生活中最常见的水果之一。它不仅富含多种维生素和微量元素，而且价廉物美，味道酸甜，营养丰富，作用繁多。还有一定的药用价值。是水果一族的佳品。</span></p>');
INSERT INTO `df_goods` VALUES (6, '2020-03-31 07:35:39.584095', '2020-03-31 07:35:39.584123', 0, '猕猴桃', '<p><span style=\"font-size: 10px;\">猕猴桃含有丰富的矿物质，包括丰富的钙、磷、铁，还含有胡萝卜素和多种维生素，对保持人体健康具有重要的作用。</span></p>');
INSERT INTO `df_goods` VALUES (7, '2020-03-31 08:05:29.702708', '2020-03-31 08:05:29.702762', 0, '扇贝', '<p><span style=\"font-size: 10px;\">扇贝属于软体动物门，扇贝科，是我国重要的贝类养殖品种。扇贝可食部分的主要营养成分为蛋白质，与鱼类、虾类相似，是一种集食、药、滋补为一体的重要水产食物。</span></p>');
INSERT INTO `df_goods` VALUES (8, '2020-03-31 08:06:13.538194', '2020-03-31 08:06:13.538225', 0, '冷冻秋刀鱼', '<p><span style=\"font-size: 10px;\">秋刀鱼（Cololabis saira）又称竹刀鱼，由于其体形修长如刀，生产季节在秋天，故名秋刀鱼，英文名为Pacific Saury。秋刀鱼隶属颌针鱼亚目竹刀鱼科秋刀鱼属。</span></p>');
INSERT INTO `df_goods` VALUES (9, '2020-03-31 08:16:04.808534', '2020-03-31 08:16:04.810864', 0, '维多利亚葡萄', '<p><span style=\"font-size: 10px;\">维多利亚葡萄属欧亚种，来源于罗马尼亚，由绯红与保 尔加尔杂交选育而成的中早熟葡萄品种。</span></p>');

-- ----------------------------
-- Table structure for df_goods_image
-- ----------------------------
DROP TABLE IF EXISTS `df_goods_image`;
CREATE TABLE `df_goods_image`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_goods_image_sku_id_f8dc96ea_fk_df_goods_sku_id`(`sku_id`) USING BTREE,
  CONSTRAINT `df_goods_image_sku_id_f8dc96ea_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_goods_image
-- ----------------------------

-- ----------------------------
-- Table structure for df_goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `df_goods_sku`;
CREATE TABLE `df_goods_sku`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `unite` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `stock` int(11) NOT NULL,
  `sales` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_goods_sku_type_id_576de3b4_fk_df_goods_type_id`(`type_id`) USING BTREE,
  INDEX `df_goods_sku_goods_id_31622280_fk_df_goods_id`(`goods_id`) USING BTREE,
  CONSTRAINT `df_goods_sku_goods_id_31622280_fk_df_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `df_goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_goods_sku_type_id_576de3b4_fk_df_goods_type_id` FOREIGN KEY (`type_id`) REFERENCES `df_goods_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_goods_sku
-- ----------------------------
INSERT INTO `df_goods_sku` VALUES (1, '2020-03-13 03:12:28.684462', '2020-04-04 08:18:48.677039', 0, '大兴大棚草莓', '草莓浆果柔软多汁，味美爽口，适合速冻保鲜贮藏。草莓速冻后，可以保持原有的色、香、味，既便于贮藏，又便于外销。', 16.80, '500', 'group1/M00/00/00/wKgAal5q-hyAFOEUAADhpefAOjE5668125', 1990, 27, 1, 1, 2);
INSERT INTO `df_goods_sku` VALUES (2, '2020-03-13 03:40:09.597211', '2020-04-04 08:20:15.037648', 0, '芒果', '新鲜芒果', 15.50, '500', 'group1/M00/00/00/wKgAal5rAJmAL0LaAAAgbegSiQE3397483', 1987, 13, 1, 2, 2);
INSERT INTO `df_goods_sku` VALUES (3, '2020-03-13 03:41:28.484225', '2020-03-31 07:51:37.092493', 0, '青海大虾', '一种生活在水中的节肢动物，属节肢动物甲壳类，种类很多，包括南极红虾、青虾、河虾、草虾、对虾、明虾、龙虾等。', 38.00, '500', 'group1/M00/00/00/wKgAal6C9nOAffN0AAAk0Pq7CMk0350299', 2000, 0, 1, 3, 3);
INSERT INTO `df_goods_sku` VALUES (4, '2020-03-13 03:42:44.006679', '2020-03-13 03:42:44.006711', 0, '澳洲龙虾', '新鲜澳洲龙虾', 500.00, '500', 'group1/M00/00/00/wKgAal5rATSAdSMeAAA5OYGDqQg0287386', 1999, 1, 1, 4, 3);
INSERT INTO `df_goods_sku` VALUES (5, '2020-03-31 07:38:26.812898', '2020-03-31 07:38:26.812932', 0, '草莓', '草莓浆果柔软多汁，味美爽口，适合速冻保鲜贮藏。草莓速冻后，可以保持原有的色、香、味，既便于贮藏，又便于外销。', 20.00, '500', 'group1/M00/00/00/wKgAal6C83KAbBouAAAljKgfdmY5247283', 1992, 8, 1, 1, 2);
INSERT INTO `df_goods_sku` VALUES (6, '2020-03-31 07:39:36.818471', '2020-03-31 07:39:36.818527', 0, '苹果', '苹果是生活中最常见的水果之一。', 5.00, '500', 'group1/M00/00/00/wKgAal6C87iAK6vHAAAWn6HsRe44387261', 2000, 0, 1, 5, 2);
INSERT INTO `df_goods_sku` VALUES (7, '2020-03-31 07:40:48.059396', '2020-04-04 08:15:31.910563', 0, '猕猴桃', '奇异果含有丰富的维生素C,可强化免疫系统,促进伤口愈合和对铁质的吸收', 4.90, '500', 'group1/M00/00/00/wKgAal6EX2WAGUQWAAAeuN21vRw7262219', 1998, 2, 1, 6, 2);
INSERT INTO `df_goods_sku` VALUES (8, '2020-03-31 08:07:57.203420', '2020-03-31 08:07:57.203452', 0, '扇贝', '扇贝广泛分布于世界各海域。', 38.00, '500', 'group1/M00/00/00/wKgAal6C-l2AHmShAAAk8UJFP7A8459579', 1999, 1, 1, 7, 3);
INSERT INTO `df_goods_sku` VALUES (9, '2020-03-31 08:08:37.875834', '2020-03-31 08:08:37.875867', 0, '秋刀鱼', '是飞鱼（Exocetid）与鹤鱵科（Belonid）的近亲。', 40.00, '500', 'group1/M00/00/00/wKgAal6C-oWAZ5XFAAAkaFzzsK87236224', 2000, 0, 1, 8, 3);
INSERT INTO `df_goods_sku` VALUES (10, '2020-03-31 08:17:48.838535', '2020-03-31 08:17:48.838568', 0, '维多利亚葡萄', '果实性状编辑果穗大，圆锥形或圆柱形，平均穗重630克，果穗稍长，果粒着生中等紧密。', 38.00, '500', 'group1/M00/00/00/wKgAal6C_KyAQWuQAAAX1J67fuk7432462', 2000, 0, 1, 9, 4);

-- ----------------------------
-- Table structure for df_goods_type
-- ----------------------------
DROP TABLE IF EXISTS `df_goods_type`;
CREATE TABLE `df_goods_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `logo` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_goods_type
-- ----------------------------
INSERT INTO `df_goods_type` VALUES (2, '2020-03-12 12:53:48.364327', '2020-03-31 07:46:04.621469', 0, '新鲜水果', 'fruit', 'group1/M00/00/00/wKgAal6C9TyAFo78AAAmv11TetM4310199');
INSERT INTO `df_goods_type` VALUES (3, '2020-03-12 12:54:09.046892', '2020-03-31 07:45:55.256789', 0, '海鲜水产', 'seafood', 'group1/M00/00/00/wKgAal6C9TOAI8QHAABHr3xtKMg7609494');
INSERT INTO `df_goods_type` VALUES (4, '2020-03-12 12:52:44.442068', '2020-03-31 07:46:21.818725', 0, '猪牛羊肉', 'meet', 'group1/M00/00/00/wKgAal6C9U2ATuT9AAAy1TlGVKQ8489885');
INSERT INTO `df_goods_type` VALUES (5, '2020-03-12 12:54:26.338572', '2020-03-31 07:45:47.007949', 0, '禽类蛋品', 'egg', 'group1/M00/00/00/wKgAal6C9SuAX-rUAAAqR3YTjIE5513963');
INSERT INTO `df_goods_type` VALUES (6, '2020-03-12 12:54:43.662663', '2020-03-31 07:45:38.364347', 0, '新鲜蔬菜', 'vegetables', 'group1/M00/00/00/wKgAal6C9SKABomDAAA-0XdggAQ0068885');
INSERT INTO `df_goods_type` VALUES (7, '2020-03-12 12:55:01.330756', '2020-03-31 07:45:26.780314', 0, '速冻食品', 'ice', 'group1/M00/00/00/wKgAal6C9RaAYOxEAAA3sQJanO43127946');

-- ----------------------------
-- Table structure for df_index_banner
-- ----------------------------
DROP TABLE IF EXISTS `df_index_banner`;
CREATE TABLE `df_index_banner`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `index` smallint(6) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_index_banner_sku_id_57f2798e_fk_df_goods_sku_id`(`sku_id`) USING BTREE,
  CONSTRAINT `df_index_banner_sku_id_57f2798e_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_index_banner
-- ----------------------------
INSERT INTO `df_index_banner` VALUES (1, '2020-03-13 03:14:05.261681', '2020-03-13 03:14:05.261723', 0, 'group1/M00/00/00/wKgAal5q-n2Af1YSAACpB6F19o80640853', 0, 1);
INSERT INTO `df_index_banner` VALUES (2, '2020-03-13 03:43:27.883135', '2020-03-13 03:43:27.883170', 0, 'group1/M00/00/00/wKgAal5rAV-AewJxAAC3By0Omcw0720468', 1, 2);
INSERT INTO `df_index_banner` VALUES (3, '2020-03-13 03:43:40.450125', '2020-03-13 03:43:40.450159', 0, 'group1/M00/00/00/wKgAal5rAWyAAjBJAAETwYrDbHc6028841', 3, 3);
INSERT INTO `df_index_banner` VALUES (4, '2020-03-13 03:43:51.733672', '2020-03-13 03:43:51.733704', 0, 'group1/M00/00/00/wKgAal5rAXeAfHBpAAD0asvXLes5303042', 4, 4);

-- ----------------------------
-- Table structure for df_index_promotion
-- ----------------------------
DROP TABLE IF EXISTS `df_index_promotion`;
CREATE TABLE `df_index_promotion`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `index` smallint(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_index_promotion
-- ----------------------------
INSERT INTO `df_index_promotion` VALUES (1, '2020-03-13 03:31:28.649204', '2020-03-13 03:31:28.649235', 0, '吃货暑期趴', '#', 'group1/M00/00/00/wKgAal5q_pCAH7B0AAA2pPk7JKw4402037', 0);
INSERT INTO `df_index_promotion` VALUES (2, '2020-03-13 03:33:35.218047', '2020-03-13 03:33:35.218094', 0, '盛夏尝鲜季', '#', 'group1/M00/00/00/wKgAal5q_w-AEUNLAAA9865qtF44171083', 1);

-- ----------------------------
-- Table structure for df_index_type_goods
-- ----------------------------
DROP TABLE IF EXISTS `df_index_type_goods`;
CREATE TABLE `df_index_type_goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `display_type` smallint(6) NOT NULL,
  `index` smallint(6) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_index_type_goods_sku_id_0a8a17db_fk_df_goods_sku_id`(`sku_id`) USING BTREE,
  INDEX `df_index_type_goods_type_id_35192ffd_fk_df_goods_type_id`(`type_id`) USING BTREE,
  CONSTRAINT `df_index_type_goods_sku_id_0a8a17db_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_index_type_goods_type_id_35192ffd_fk_df_goods_type_id` FOREIGN KEY (`type_id`) REFERENCES `df_goods_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_index_type_goods
-- ----------------------------
INSERT INTO `df_index_type_goods` VALUES (1, '2020-03-31 07:31:41.581443', '2020-03-31 07:52:21.869451', 0, 1, 0, 4, 3);
INSERT INTO `df_index_type_goods` VALUES (2, '2020-03-31 07:32:17.717761', '2020-03-31 07:52:52.129869', 0, 0, 0, 4, 3);
INSERT INTO `df_index_type_goods` VALUES (3, '2020-03-31 07:41:31.415797', '2020-03-31 07:41:31.415829', 0, 1, 0, 1, 2);
INSERT INTO `df_index_type_goods` VALUES (4, '2020-03-31 07:41:37.316675', '2020-03-31 07:41:37.316709', 0, 1, 0, 2, 2);
INSERT INTO `df_index_type_goods` VALUES (5, '2020-03-31 07:41:44.014624', '2020-03-31 07:41:44.014672', 0, 1, 0, 5, 2);
INSERT INTO `df_index_type_goods` VALUES (6, '2020-03-31 07:41:50.420031', '2020-03-31 07:41:50.420064', 0, 1, 0, 6, 2);
INSERT INTO `df_index_type_goods` VALUES (7, '2020-03-31 07:42:41.027158', '2020-03-31 07:42:41.027208', 0, 0, 0, 5, 2);
INSERT INTO `df_index_type_goods` VALUES (8, '2020-03-31 07:42:50.519035', '2020-03-31 07:42:50.519075', 0, 0, 0, 6, 2);
INSERT INTO `df_index_type_goods` VALUES (9, '2020-03-31 07:42:58.335701', '2020-03-31 07:42:58.335824', 0, 0, 0, 2, 2);
INSERT INTO `df_index_type_goods` VALUES (10, '2020-03-31 07:43:06.368553', '2020-03-31 07:43:06.368585', 0, 0, 0, 1, 2);
INSERT INTO `df_index_type_goods` VALUES (11, '2020-03-31 07:49:42.159612', '2020-03-31 07:52:05.952156', 0, 1, 1, 3, 3);
INSERT INTO `df_index_type_goods` VALUES (12, '2020-03-31 08:09:10.560565', '2020-03-31 08:09:10.560597', 0, 1, 3, 8, 3);
INSERT INTO `df_index_type_goods` VALUES (13, '2020-03-31 08:09:22.876232', '2020-03-31 08:09:22.876265', 0, 1, 2, 9, 3);
INSERT INTO `df_index_type_goods` VALUES (14, '2020-03-31 08:13:42.746615', '2020-03-31 08:13:42.746650', 0, 0, 1, 9, 3);
INSERT INTO `df_index_type_goods` VALUES (15, '2020-03-31 08:18:04.186541', '2020-03-31 08:18:04.186575', 0, 1, 0, 10, 4);
INSERT INTO `df_index_type_goods` VALUES (16, '2020-03-31 08:18:13.357719', '2020-03-31 08:18:13.357753', 0, 1, 1, 10, 4);
INSERT INTO `df_index_type_goods` VALUES (17, '2020-03-31 08:18:23.343895', '2020-03-31 08:18:23.343946', 0, 1, 2, 10, 4);
INSERT INTO `df_index_type_goods` VALUES (18, '2020-03-31 08:18:30.881918', '2020-03-31 08:18:30.881948', 0, 1, 3, 10, 4);
INSERT INTO `df_index_type_goods` VALUES (19, '2020-03-31 08:18:51.475404', '2020-03-31 08:18:51.475437', 0, 1, 0, 10, 5);
INSERT INTO `df_index_type_goods` VALUES (20, '2020-03-31 08:19:02.572757', '2020-03-31 08:19:02.572788', 0, 1, 1, 10, 5);
INSERT INTO `df_index_type_goods` VALUES (21, '2020-03-31 08:19:10.722093', '2020-03-31 08:19:10.722128', 0, 1, 2, 10, 5);
INSERT INTO `df_index_type_goods` VALUES (22, '2020-03-31 08:19:17.825002', '2020-03-31 08:19:17.825032', 0, 1, 3, 10, 5);
INSERT INTO `df_index_type_goods` VALUES (23, '2020-03-31 08:19:26.915606', '2020-03-31 08:19:26.915638', 0, 1, 0, 10, 6);
INSERT INTO `df_index_type_goods` VALUES (24, '2020-03-31 08:19:35.756837', '2020-03-31 08:19:35.756867', 0, 1, 1, 10, 6);
INSERT INTO `df_index_type_goods` VALUES (25, '2020-03-31 08:19:45.419068', '2020-03-31 08:19:45.419100', 0, 1, 2, 10, 6);
INSERT INTO `df_index_type_goods` VALUES (26, '2020-03-31 08:19:55.551136', '2020-03-31 08:19:55.551174', 0, 1, 3, 10, 6);
INSERT INTO `df_index_type_goods` VALUES (27, '2020-03-31 08:20:03.060330', '2020-03-31 08:20:03.060362', 0, 1, 1, 10, 7);
INSERT INTO `df_index_type_goods` VALUES (28, '2020-03-31 08:20:12.756680', '2020-03-31 08:20:12.756712', 0, 1, 1, 10, 7);
INSERT INTO `df_index_type_goods` VALUES (29, '2020-03-31 08:20:22.134392', '2020-03-31 08:20:22.134426', 0, 1, 2, 10, 7);
INSERT INTO `df_index_type_goods` VALUES (30, '2020-03-31 08:20:28.782213', '2020-03-31 08:20:28.782245', 0, 1, 3, 10, 7);

-- ----------------------------
-- Table structure for df_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `df_order_goods`;
CREATE TABLE `df_order_goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `count` int(11) NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `comment` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `order_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_order_goods_order_id_6958ee23_fk_df_order_info_order_id`(`order_id`) USING BTREE,
  INDEX `df_order_goods_sku_id_b7d6e04e_fk_df_goods_sku_id`(`sku_id`) USING BTREE,
  CONSTRAINT `df_order_goods_order_id_6958ee23_fk_df_order_info_order_id` FOREIGN KEY (`order_id`) REFERENCES `df_order_info` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_order_goods_sku_id_b7d6e04e_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_order_goods
-- ----------------------------
INSERT INTO `df_order_goods` VALUES (1, '2020-04-05 13:22:44.823963', '2020-04-05 15:52:33.626699', 0, 1, 20.00, '非常好吃', '202004052122441', 5);
INSERT INTO `df_order_goods` VALUES (2, '2020-04-06 03:51:01.265015', '2020-04-06 03:51:01.265046', 0, 1, 15.50, '', '202004061151011', 2);

-- ----------------------------
-- Table structure for df_order_info
-- ----------------------------
DROP TABLE IF EXISTS `df_order_info`;
CREATE TABLE `df_order_info`  (
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `order_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pay_method` smallint(6) NOT NULL,
  `total_count` int(11) NOT NULL,
  `total_price` decimal(10, 2) NOT NULL,
  `transit_price` decimal(10, 2) NOT NULL,
  `order_status` smallint(6) NOT NULL,
  `trade_no` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `addr_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `df_order_info_addr_id_70c3726e_fk_df_address_id`(`addr_id`) USING BTREE,
  INDEX `df_order_info_user_id_ac1e5bf5_fk_df_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `df_order_info_addr_id_70c3726e_fk_df_address_id` FOREIGN KEY (`addr_id`) REFERENCES `df_address` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_order_info_user_id_ac1e5bf5_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_order_info
-- ----------------------------
INSERT INTO `df_order_info` VALUES ('2020-04-05 13:22:44.809639', '2020-04-05 15:52:33.640725', 0, '202004052122441', 3, 1, 20.00, 10.00, 5, '', 6, 1);
INSERT INTO `df_order_info` VALUES ('2020-04-06 03:51:01.222774', '2020-04-06 03:51:01.272387', 0, '202004061151011', 3, 1, 15.50, 10.00, 1, '', 6, 1);

-- ----------------------------
-- Table structure for df_user
-- ----------------------------
DROP TABLE IF EXISTS `df_user`;
CREATE TABLE `df_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_user
-- ----------------------------
INSERT INTO `df_user` VALUES (1, 'pbkdf2_sha256$180000$Nexc9lOR6LY3$3pDK+o1EExmBDuxkjG02qcNP7+c7AF6v1j2FWqR5ARM=', '2020-04-05 12:34:12.456396', 0, 'clown', '', '', '1141021298@qq.com', 0, 1, '2020-01-07 16:02:30.233504', '2020-01-07 16:02:30.471041', '2020-01-07 16:02:30.471055', 0);
INSERT INTO `df_user` VALUES (45, 'pbkdf2_sha256$180000$i4BbqCRGLhT9$9UYLRK4MCgIixFc35aEtnR/tQ6GSMpbQU9K4xLymfNI=', '2020-04-04 11:31:33.671922', 1, 'xq', '', '', '1141021298@qq.com', 1, 1, '2020-03-10 07:51:32.758455', '2020-03-10 07:51:32.869468', '2020-03-10 07:51:32.869482', 0);

-- ----------------------------
-- Table structure for df_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `df_user_groups`;
CREATE TABLE `df_user_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `df_user_groups_user_id_group_id_80e5ab91_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `df_user_groups_group_id_36f24e94_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `df_user_groups_group_id_36f24e94_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_user_groups_user_id_a816b098_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for df_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `df_user_user_permissions`;
CREATE TABLE `df_user_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `df_user_user_permissions_user_id_permission_id_b22997de_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `df_user_user_permiss_permission_id_40a6cb2d_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `df_user_user_permiss_permission_id_40a6cb2d_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_user_user_permissions_user_id_b5f6551b_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_df_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2020-03-10 08:52:15.507546', '1', '猪牛羊肉', 1, '[{\"added\": {}}]', 10, 45);
INSERT INTO `django_admin_log` VALUES (2, '2020-03-12 12:51:12.246135', '1', '猪牛羊肉', 3, '', 10, 45);
INSERT INTO `django_admin_log` VALUES (3, '2020-03-12 12:52:44.464383', '2', '猪牛羊肉', 1, '[{\"added\": {}}]', 10, 45);
INSERT INTO `django_admin_log` VALUES (4, '2020-03-12 12:53:48.394281', '3', '新鲜水果', 1, '[{\"added\": {}}]', 10, 45);
INSERT INTO `django_admin_log` VALUES (5, '2020-03-12 12:54:09.057929', '4', '海鲜水产', 1, '[{\"added\": {}}]', 10, 45);
INSERT INTO `django_admin_log` VALUES (6, '2020-03-12 12:54:26.353776', '5', '禽类蛋品', 1, '[{\"added\": {}}]', 10, 45);
INSERT INTO `django_admin_log` VALUES (7, '2020-03-12 12:54:43.672447', '6', '新鲜蔬菜', 1, '[{\"added\": {}}]', 10, 45);
INSERT INTO `django_admin_log` VALUES (8, '2020-03-12 12:55:01.346361', '7', '速冻食品', 1, '[{\"added\": {}}]', 10, 45);
INSERT INTO `django_admin_log` VALUES (9, '2020-03-13 03:00:14.589877', '1', 'Goods object (1)', 1, '[{\"added\": {}}]', 8, 45);
INSERT INTO `django_admin_log` VALUES (10, '2020-03-13 03:01:07.997968', '1', 'Goods object (1)', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1SPU\\u540d\\u79f0\"]}}]', 8, 45);
INSERT INTO `django_admin_log` VALUES (11, '2020-03-13 03:12:28.735746', '1', 'GoodsSKU object (1)', 1, '[{\"added\": {}}]', 9, 45);
INSERT INTO `django_admin_log` VALUES (12, '2020-03-13 03:13:17.314326', '1', 'Goods object (1)', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1SPU\\u540d\\u79f0\"]}}]', 8, 45);
INSERT INTO `django_admin_log` VALUES (13, '2020-03-13 03:13:34.162767', '1', 'Goods object (1)', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1SPU\\u540d\\u79f0\"]}}]', 8, 45);
INSERT INTO `django_admin_log` VALUES (14, '2020-03-13 03:14:05.359181', '1', 'IndexGoodsBanner object (1)', 1, '[{\"added\": {}}]', 13, 45);
INSERT INTO `django_admin_log` VALUES (15, '2020-03-13 03:31:28.755874', '1', 'IndexPromotionBanner object (1)', 1, '[{\"added\": {}}]', 11, 45);
INSERT INTO `django_admin_log` VALUES (16, '2020-03-13 03:33:35.346026', '2', 'IndexPromotionBanner object (2)', 1, '[{\"added\": {}}]', 11, 45);
INSERT INTO `django_admin_log` VALUES (17, '2020-03-13 03:36:00.318967', '2', 'Goods object (2)', 1, '[{\"added\": {}}]', 8, 45);
INSERT INTO `django_admin_log` VALUES (18, '2020-03-13 03:37:07.040928', '2', 'Goods object (2)', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1SPU\\u540d\\u79f0\", \"\\u5546\\u54c1\\u8be6\\u60c5\"]}}]', 8, 45);
INSERT INTO `django_admin_log` VALUES (19, '2020-03-13 03:37:52.491231', '3', 'Goods object (3)', 1, '[{\"added\": {}}]', 8, 45);
INSERT INTO `django_admin_log` VALUES (20, '2020-03-13 03:38:24.943396', '4', 'Goods object (4)', 1, '[{\"added\": {}}]', 8, 45);
INSERT INTO `django_admin_log` VALUES (21, '2020-03-13 03:40:09.607851', '2', 'GoodsSKU object (2)', 1, '[{\"added\": {}}]', 9, 45);
INSERT INTO `django_admin_log` VALUES (22, '2020-03-13 03:41:28.491628', '3', 'GoodsSKU object (3)', 1, '[{\"added\": {}}]', 9, 45);
INSERT INTO `django_admin_log` VALUES (23, '2020-03-13 03:42:44.013885', '4', 'GoodsSKU object (4)', 1, '[{\"added\": {}}]', 9, 45);
INSERT INTO `django_admin_log` VALUES (24, '2020-03-13 03:43:27.898391', '2', 'IndexGoodsBanner object (2)', 1, '[{\"added\": {}}]', 13, 45);
INSERT INTO `django_admin_log` VALUES (25, '2020-03-13 03:43:40.464727', '3', 'IndexGoodsBanner object (3)', 1, '[{\"added\": {}}]', 13, 45);
INSERT INTO `django_admin_log` VALUES (26, '2020-03-13 03:43:51.749609', '4', 'IndexGoodsBanner object (4)', 1, '[{\"added\": {}}]', 13, 45);
INSERT INTO `django_admin_log` VALUES (27, '2020-03-31 07:31:41.632897', '1', 'IndexTypeGoodsBanner object (1)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (28, '2020-03-31 07:32:17.780193', '2', 'IndexTypeGoodsBanner object (2)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (29, '2020-03-31 07:34:52.413885', '5', 'Goods object (5)', 1, '[{\"added\": {}}]', 8, 45);
INSERT INTO `django_admin_log` VALUES (30, '2020-03-31 07:35:39.589435', '6', 'Goods object (6)', 1, '[{\"added\": {}}]', 8, 45);
INSERT INTO `django_admin_log` VALUES (31, '2020-03-31 07:36:05.259586', '5', 'Goods object (5)', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u8be6\\u60c5\"]}}]', 8, 45);
INSERT INTO `django_admin_log` VALUES (32, '2020-03-31 07:38:26.832218', '5', 'GoodsSKU object (5)', 1, '[{\"added\": {}}]', 9, 45);
INSERT INTO `django_admin_log` VALUES (33, '2020-03-31 07:39:36.833336', '6', 'GoodsSKU object (6)', 1, '[{\"added\": {}}]', 9, 45);
INSERT INTO `django_admin_log` VALUES (34, '2020-03-31 07:40:48.070839', '7', 'GoodsSKU object (7)', 1, '[{\"added\": {}}]', 9, 45);
INSERT INTO `django_admin_log` VALUES (35, '2020-03-31 07:41:31.429539', '3', 'IndexTypeGoodsBanner object (3)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (36, '2020-03-31 07:41:37.340953', '4', 'IndexTypeGoodsBanner object (4)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (37, '2020-03-31 07:41:44.025420', '5', 'IndexTypeGoodsBanner object (5)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (38, '2020-03-31 07:41:50.438794', '6', 'IndexTypeGoodsBanner object (6)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (39, '2020-03-31 07:42:41.047201', '7', 'IndexTypeGoodsBanner object (7)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (40, '2020-03-31 07:42:50.534082', '8', 'IndexTypeGoodsBanner object (8)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (41, '2020-03-31 07:42:58.345958', '9', 'IndexTypeGoodsBanner object (9)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (42, '2020-03-31 07:43:06.381455', '10', 'IndexTypeGoodsBanner object (10)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (43, '2020-03-31 07:45:26.792694', '7', '速冻食品', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u79cd\\u7c7b\\u56fe\\u7247\"]}}]', 10, 45);
INSERT INTO `django_admin_log` VALUES (44, '2020-03-31 07:45:38.394648', '6', '新鲜蔬菜', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u79cd\\u7c7b\\u56fe\\u7247\"]}}]', 10, 45);
INSERT INTO `django_admin_log` VALUES (45, '2020-03-31 07:45:47.022423', '5', '禽类蛋品', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u79cd\\u7c7b\\u56fe\\u7247\"]}}]', 10, 45);
INSERT INTO `django_admin_log` VALUES (46, '2020-03-31 07:45:55.273831', '4', '海鲜水产', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u79cd\\u7c7b\\u56fe\\u7247\"]}}]', 10, 45);
INSERT INTO `django_admin_log` VALUES (47, '2020-03-31 07:46:04.633472', '3', '新鲜水果', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u79cd\\u7c7b\\u56fe\\u7247\"]}}]', 10, 45);
INSERT INTO `django_admin_log` VALUES (48, '2020-03-31 07:46:21.833774', '2', '猪牛羊肉', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u79cd\\u7c7b\\u56fe\\u7247\"]}}]', 10, 45);
INSERT INTO `django_admin_log` VALUES (49, '2020-03-31 07:49:42.175349', '11', 'IndexTypeGoodsBanner object (11)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (50, '2020-03-31 07:51:15.058016', '3', 'GoodsSKU object (3)', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u540d\\u79f0\", \"\\u5546\\u54c1\\u7b80\\u4ecb\", \"\\u5546\\u54c1\\u56fe\\u7247\"]}}]', 9, 45);
INSERT INTO `django_admin_log` VALUES (51, '2020-03-31 07:51:37.099627', '3', 'GoodsSKU object (3)', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u79cd\\u7c7b\"]}}]', 9, 45);
INSERT INTO `django_admin_log` VALUES (52, '2020-03-31 07:52:05.962374', '11', 'IndexTypeGoodsBanner object (11)', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u7c7b\\u578b\"]}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (53, '2020-03-31 07:52:21.880674', '1', 'IndexTypeGoodsBanner object (1)', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u7c7b\\u578b\"]}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (54, '2020-03-31 07:52:52.145550', '2', 'IndexTypeGoodsBanner object (2)', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u7c7b\\u578b\"]}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (55, '2020-03-31 08:03:54.086267', '8', '1', 3, '', 10, 45);
INSERT INTO `django_admin_log` VALUES (56, '2020-03-31 08:05:29.707310', '7', 'Goods object (7)', 1, '[{\"added\": {}}]', 8, 45);
INSERT INTO `django_admin_log` VALUES (57, '2020-03-31 08:06:13.546229', '8', 'Goods object (8)', 1, '[{\"added\": {}}]', 8, 45);
INSERT INTO `django_admin_log` VALUES (58, '2020-03-31 08:07:57.210624', '8', 'GoodsSKU object (8)', 1, '[{\"added\": {}}]', 9, 45);
INSERT INTO `django_admin_log` VALUES (59, '2020-03-31 08:08:37.889792', '9', 'GoodsSKU object (9)', 1, '[{\"added\": {}}]', 9, 45);
INSERT INTO `django_admin_log` VALUES (60, '2020-03-31 08:09:10.571163', '12', 'IndexTypeGoodsBanner object (12)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (61, '2020-03-31 08:09:22.885326', '13', 'IndexTypeGoodsBanner object (13)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (62, '2020-03-31 08:13:42.756162', '14', 'IndexTypeGoodsBanner object (14)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (63, '2020-03-31 08:16:04.813933', '9', 'Goods object (9)', 1, '[{\"added\": {}}]', 8, 45);
INSERT INTO `django_admin_log` VALUES (64, '2020-03-31 08:17:48.845813', '10', 'GoodsSKU object (10)', 1, '[{\"added\": {}}]', 9, 45);
INSERT INTO `django_admin_log` VALUES (65, '2020-03-31 08:18:04.195811', '15', 'IndexTypeGoodsBanner object (15)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (66, '2020-03-31 08:18:13.370521', '16', 'IndexTypeGoodsBanner object (16)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (67, '2020-03-31 08:18:23.353087', '17', 'IndexTypeGoodsBanner object (17)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (68, '2020-03-31 08:18:30.889459', '18', 'IndexTypeGoodsBanner object (18)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (69, '2020-03-31 08:18:51.489999', '19', 'IndexTypeGoodsBanner object (19)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (70, '2020-03-31 08:19:02.602716', '20', 'IndexTypeGoodsBanner object (20)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (71, '2020-03-31 08:19:10.730143', '21', 'IndexTypeGoodsBanner object (21)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (72, '2020-03-31 08:19:17.836271', '22', 'IndexTypeGoodsBanner object (22)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (73, '2020-03-31 08:19:26.931265', '23', 'IndexTypeGoodsBanner object (23)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (74, '2020-03-31 08:19:35.764891', '24', 'IndexTypeGoodsBanner object (24)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (75, '2020-03-31 08:19:45.431194', '25', 'IndexTypeGoodsBanner object (25)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (76, '2020-03-31 08:19:55.565604', '26', 'IndexTypeGoodsBanner object (26)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (77, '2020-03-31 08:20:03.073241', '27', 'IndexTypeGoodsBanner object (27)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (78, '2020-03-31 08:20:12.765852', '28', 'IndexTypeGoodsBanner object (28)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (79, '2020-03-31 08:20:22.144750', '29', 'IndexTypeGoodsBanner object (29)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (80, '2020-03-31 08:20:28.796990', '30', 'IndexTypeGoodsBanner object (30)', 1, '[{\"added\": {}}]', 12, 45);
INSERT INTO `django_admin_log` VALUES (81, '2020-04-01 09:31:17.223780', '7', 'GoodsSKU object (7)', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u56fe\\u7247\"]}}]', 9, 45);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (8, 'goods', 'goods');
INSERT INTO `django_content_type` VALUES (14, 'goods', 'goodsimage');
INSERT INTO `django_content_type` VALUES (9, 'goods', 'goodssku');
INSERT INTO `django_content_type` VALUES (10, 'goods', 'goodstype');
INSERT INTO `django_content_type` VALUES (13, 'goods', 'indexgoodsbanner');
INSERT INTO `django_content_type` VALUES (11, 'goods', 'indexpromotionbanner');
INSERT INTO `django_content_type` VALUES (12, 'goods', 'indextypegoodsbanner');
INSERT INTO `django_content_type` VALUES (15, 'order', 'ordergoods');
INSERT INTO `django_content_type` VALUES (16, 'order', 'orderinfo');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (7, 'user', 'address');
INSERT INTO `django_content_type` VALUES (6, 'user', 'user');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2020-01-05 13:19:11.149213');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2020-01-05 13:19:11.217628');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2020-01-05 13:19:11.296287');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2020-01-05 13:19:11.556503');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2020-01-05 13:19:11.580094');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2020-01-05 13:19:11.606128');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2020-01-05 13:19:11.625884');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2020-01-05 13:19:11.630173');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2020-01-05 13:19:11.650107');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2020-01-05 13:19:11.667722');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2020-01-05 13:19:11.685069');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0010_alter_group_name_max_length', '2020-01-05 13:19:11.757739');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0011_update_proxy_permissions', '2020-01-05 13:19:11.767982');
INSERT INTO `django_migrations` VALUES (14, 'user', '0001_initial', '2020-01-05 13:19:11.875599');
INSERT INTO `django_migrations` VALUES (15, 'admin', '0001_initial', '2020-01-05 13:19:12.110982');
INSERT INTO `django_migrations` VALUES (16, 'admin', '0002_logentry_remove_auto_add', '2020-01-05 13:19:12.210419');
INSERT INTO `django_migrations` VALUES (17, 'admin', '0003_logentry_add_action_flag_choices', '2020-01-05 13:19:12.227913');
INSERT INTO `django_migrations` VALUES (18, 'goods', '0001_initial', '2020-01-05 13:19:12.467614');
INSERT INTO `django_migrations` VALUES (19, 'goods', '0002_goodsimage', '2020-01-05 13:19:12.646881');
INSERT INTO `django_migrations` VALUES (20, 'order', '0001_initial', '2020-01-05 13:19:12.734615');
INSERT INTO `django_migrations` VALUES (21, 'order', '0002_auto_20200105_2113', '2020-01-05 13:19:12.923426');
INSERT INTO `django_migrations` VALUES (22, 'sessions', '0001_initial', '2020-01-05 13:19:12.939626');
INSERT INTO `django_migrations` VALUES (23, 'goods', '0003_auto_20200105_2122', '2020-01-05 13:22:58.698548');
INSERT INTO `django_migrations` VALUES (24, 'order', '0003_auto_20200105_2122', '2020-01-05 13:22:58.816926');
INSERT INTO `django_migrations` VALUES (25, 'user', '0002_auto_20200105_2122', '2020-01-05 13:22:58.960298');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('a8zps75cy3w7a3a3dvaw0ogzm2wn69jr', 'ZjFlNTZhNGQ1ODYxNGMyMjgxNjM0MGZkZmJmNzE2YmUyMDhiNDMzMTp7Il9hdXRoX3VzZXJfaWQiOiI0MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiM2UyZDdiZmVmM2ZhNmFmNWJhNmVlNTU5ZDQ1MGE4NDU2NjJiNTcyNyJ9', '2020-01-26 12:12:23.109455');

SET FOREIGN_KEY_CHECKS = 1;
