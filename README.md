# dailyfresh
天天生鲜项目

如果IP地址改变，请更改setting中ip,以及redis,fastDFS的 storage-trackered 以及client的ip和 celery的ip,mysql的ip
修改ip
settings 
redis
storage
tracker
client
celery
mysql


1.修改配置文件settings
 * redis
 * databases
 * 注册使用的邮件服务配置
 * nginx配置
 
2.添加shell脚本
* 基础脚本:可和temp.sh结合使用
* celery脚本存放于项目目录下

3.支付SDK

商家账号lbdfii0246@sandbox.com
商户UID2088102180788261
登录密码111111
账户余额
2371.64充值取现

买家信息
买家账号kuitru5667@sandbox.com
登录密码111111
支付密码111111
用户名称沙箱环境
证件类型身份证(IDENTITY_CARD)
证件号码659573199403081964
账户余额
99972.20充值取现

4.uwsgi的启动和停止
* 启动：uwsgi --ini 配置文件路径
* 停止：uwsgi --stop uwsgi.pid路径

5. FASTDFS解决问题
* 海量储存，存储容量扩展方便
*　文件内容可重复　
*　结合nginx提高网站访问图片的效率

6. 悲观锁　乐观锁
冲突比较少的时候，使用乐观锁
冲突比较多的时候，使用悲观锁

7. mysql 隔离级别
Read Uncommitted(读取未提交内容)
Read Committed(读取提交内容)
Repeatable Read(可重读)(默认事务隔离级别)
Serializable(可串行化)

设置隔离级别：
在配置文件中加：
transaction-isolocation = READ-COMMITTED
Django2.0之后会默认更改
