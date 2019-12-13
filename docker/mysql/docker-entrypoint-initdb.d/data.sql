-- https://yov.oschina.io/article/%E5%AE%B9%E5%99%A8/Docker/Docker%20Hub%20mysql%E5%AE%98%E6%96%B9%E9%95%9C%E5%83%8F%E5%AE%9E%E7%8E%B0%E9%A6%96%E6%AC%A1%E5%90%AF%E5%8A%A8%E5%90%8E%E5%88%9D%E5%A7%8B%E5%8C%96%E5%BA%93%E8%A1%A8/
-- 创建数据库 
DROP database IF EXISTS `test`;
create database `test` default character set utf8 collate utf8_general_ci; 

DROP database IF EXISTS `example`;
create database `example` default character set utf8 collate utf8_general_ci; 
-- 切换到test数据库
use test; 
-- 建表 
DROP TABLE IF EXISTS 'test';
CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `address` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `user`; 
CREATE TABLE `user` ( 
	`id` bigint(20) NOT NULL, 
	`name` varchar(255) DEFAULT NULL, 
	`age` bigint(20) NOT NULL,
	PRIMARY KEY (`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 
-- 插入数据 
INSERT INTO `user` (`id`,`name`,`age` ) 
VALUES 
   (0,'Tom',18);

-- 创建canal用户，授权, 
CREATE USER canal IDENTIFIED BY 'canal';  
GRANT SELECT, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'canal'@'%';
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'canal'@'%';
FLUSH PRIVILEGES;