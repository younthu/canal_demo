# canal_demo
这是一个淘宝开源项目canal的演示，用docker-compose搭建一个集群, 包含mysql, canal, canal-admin, zookeeper,kafka, zookeeper ui, elasticsearch.

演示的功能为通过canal对mysql的数据变动增量同步到elasticsearch里面去。

实验做完以后没有及时整理笔记，下面的步骤细节上有确实的地方，如果有问题，可以联系我，或者发pr, 我尽量不定期更新教程。

## 运行
可以通过下面的命令把整个集群运行起来。
1. `docker-compose up -d`
1. 然后进入命令行输入命令`mysql -h localhost -u root -p --protocol=tcp` 来进入mysql，密码为: pass
1. 手动启动es adapter
1. 查看kafka的topic: kafka/kafka_2.11-2.3.1/bin/kafka-topics.sh --list --zookeeper localhost:2181
2. 查看kafka的topic消费情况: kafka/kafka_2.11-2.3.1/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --from-beginning --topic example
3. elkx首次运行需要创建几个账号和密码
4. 手动为es创建索引
5. 查看索引内容
6. 插入数据到mysql
7. 查看es索引变化
8. 修改mysql数据
9. 查看es索引变化
10. 删除mysql数据
11. 查看es索引变化
12. 


数据流动如下: 

mysql数据更新 -> binlog -> canal -> kafka -> canal-es adapter -> ES.

## 快速跑起来

1. 拉新代码
2. docker-compose up -d
3. 进入elkx，初始化用户密码: `$ES_HOME/bin/x-pack/setup-passwords interactive`

# 杂记
## docker


~~~shell
docker run -d -it -h 192.168.0.101 -e canal.auto.scan=false -e canal.destinations=test -e canal.instance.master.address=127.0.0.1:3306 -e canal.instance.dbUsername=canal -e canal.instance.dbPassword=canal -e canal.instance.connectionCharset=UTF-8 -e canal.instance.tsdb.enable=true -e canal.instance.gtidon=false --name=canal-server -p 11110:11110 -p 11111:11111 -p 11112:11112 -p 9100:9100 -m 4096m canal/canal-server
~~~

## canal admin

`docker run -d -it -h 192.168.0.101 -e server.port=8089 -e canal.adminUser=admin -e canal.adminPasswd=admin --name=canal-admin -p 8089:8089 -m 1024m canal/canal-admin:v1.1.4`
# mysql

1. 从命令行启动一个mysql: `docker run --name test_mysql -p 3306:3306 -v $PWD/docker/mysql/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d -v $PWD/docker/mysql/my.cnf:/etc/my.cnf -v $PWD/data/mysql:/var/lib/mysql -d -e MYSQL_ROOT_PASSWORD=123456  mysql:5.7`
2. tcp 登录mysql: `mysql -h localhost -u root -p --protocol=tcp`
3. 跑指定的service: `docker-compose up -d db`
4. 如果遇到mysql container无法写入任何文件的问题，可以测试群里docker volume: `docker volume prune`, `docker volume ls`可以查看有哪些volumes


# zookeeper

1. 启动zookeeper: `docker run --name my_zookeeper -d zookeeper:latest`
2. 使用 ZK 命令行客户端连接 ZK: `docker run -it --rm --link my_zookeeper:zookeeper zookeeper zkCli.sh -server zookeeper`
    1.  `ls /`
    2.  `stat /`
3.  错误: `stat is not executed because it is not in the whitelist.`.  解决办法: https://www.liumapp.com/articles/2019/07/08/1562568246195.html
4.  

# references

1. [zookeeper docker集群](https://juejin.im/post/5d1c5e5a518825597909bd73)
<<<<<<< 658fc0c4a1cf1213d9e1ecbc7580b9ce8640f617
2. [canal 对insert有bug](https://www.jianshu.com/p/93d9018e2fa1)
3. [MySql主从配置](https://www.jianshu.com/p/b0cf461451fb)
4. [Canal增量同步mysql数据库到ES](https://juejin.im/post/5d0dfec56fb9a07ed064bb6f)
=======
2. [canal对insert有bug](https://www.jianshu.com/p/93d9018e2fa1)
>>>>>>> update readme.md
