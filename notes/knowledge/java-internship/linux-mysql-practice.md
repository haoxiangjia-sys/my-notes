---
created: 2026-06-09
tags:
  - java/internship
  - linux
  - database/mysql
  - docker
related:
  - "[[Linux]]"
  - "[[sql/mysql]]"
---

# Linux + MySQL 动手练习

> 基于 Docker 的零影响练习环境：搞坏了就删掉重建，不会影响你的主机。

## 环境概览

```
┌──────────────────────────────────────────────┐
│                  Docker Desktop               │
│                                              │
│  ┌──────────────┐    ┌───────────────────┐  │
│  │ mysql-practice│    │  linux-practice    │  │
│  │  MySQL 8.0   │◄──►│  Ubuntu 22.04      │  │
│  │  Port: 3306  │    │  含 vim/curl/grep  │  │
│  │  root:root123│    │  含 mysql-client   │  │
│  └──────────────┘    └───────────────────┘  │
│                                              │
│  ✓ 所有数据在容器内，不影响主机                 │
│  ✓ 删掉容器就恢复如初                          │
│  ✓ 用完就 docker compose down                 │
└──────────────────────────────────────────────┘
```

## 快速开始

```powershell
# 1. 进入 scripts 目录
cd "C:\Users\xiang\Documents\Obsidian Vault\scripts"

# 2. 启动环境
docker compose up -d

# 3. 查看状态
docker compose ps

# 4. 进入 Linux 练习终端
docker exec -it linux-practice bash

# 5. 进入 MySQL
docker exec -it mysql-practice mysql -uroot -proot123 practice

# 6. 用完停止（数据保留）
docker compose down

# 7. 完全重置（清空数据重新来）
docker compose down -v && docker compose up -d
```

---

## 一、Linux 每日练习

> 进入 `docker exec -it linux-practice bash` 后执行

### Day 1：终端基础（30分钟）

```bash
# === 你是谁，在哪 ===
pwd
whoami
hostname
uname -a
cat /etc/os-release

# === 看看练习目录 ===
cd /home/practice
ls -la
cat README.txt

# === 文件浏览 ===
ls -lh                    # 人类可读的大小
ls -lt                    # 按时间排序
ls -laR                   # 递归显示所有文件

# === vim 初体验 ===
vim hello.txt
# 按 i → 输入 "hello linux" → 按 Esc → 输入 :wq
cat hello.txt             # 看看写入的内容
```

### Day 2：文件操作 + 权限（30分钟）

```bash
cd /home/practice

# === 创建与复制 ===
mkdir -p test/{src,bin,conf,logs}
touch test/app.log
echo "config=prod" > test/conf/app.conf

cp test/app.log test/app.log.bak
cp -r test test_backup

# === 移动与删除 ===
mv test/app.log.bak test/logs/
rm test/app.log
rm -rf test_backup        # ⚠️ 慎用

# === 权限实验 ===
touch my_script.sh
ls -la my_script.sh       # 看看初始权限 -rw-r--r--
chmod +x my_script.sh     # 加上执行权限
ls -la my_script.sh       # 变成 -rwxr-xr-x
chmod 600 my_script.sh    # 只有自己能读写
ls -la my_script.sh       # 变成 -rw-------

# === 理解权限数字 ===
# r=4  w=2  x=1
# 755 = rwxr-xr-x (所有者全权限，组读执行，其他读执行)
# 644 = rw-r--r-- (文件常见权限)
# 755 = rwxr-xr-x (目录常见权限)
```

### Day 3：进程管理（30分钟）

```bash
# === 后台进程 ===
sleep 300 &               # 启动一个后台进程
ps -ef | grep sleep       # 找到它的 PID
kill -15 <PID>            # 优雅终止
# 再试一次
sleep 300 &
kill -9 <PID>             # 强制终止

# === 进程监控 ===
htop                       # 动态进程监控（按 q 退出）
ps aux --sort=-%mem | head -10  # 内存占用前10

# === 后台作业管理 ===
sleep 100 &
jobs                       # 查看后台作业
fg %1                      # 切到前台
# Ctrl+Z 暂停，然后
bg %1                      # 切回后台
kill %1                    # 杀掉

# === 重定向练习 ===
echo "hello stdout"          # 输出到屏幕
echo "hello stdout" > a.txt  # 重定向到文件
echo "hello stderr" 1>&2     # 重定向到 stderr
# 2>&1 的含义：把 stderr 合并到 stdout
```

### Day 4：日志排查（重点！实习高频）

```bash
cd /home/practice/logs

# === 查看预制的模拟日志 ===
cat app.log

# === grep 过滤（最常用） ===
grep "ERROR" app.log                         # 只找错误行
grep -c "ERROR" app.log                      # 错误次数
grep -n "ERROR" app.log                      # 显示行号
grep "ERROR" app.log | wc -l                 # 计数
grep -E "ERROR|WARN" app.log                 # 匹配多个关键词
grep -v "INFO" app.log                       # 排除 INFO 行（只看非正常）
grep -A 2 -B 2 "ERROR" app.log               # 错误行的前后各2行
grep -C 3 "NullPointerException" app.log     # 上下文各3行

# === 排序与统计 ===
cat app.log | sort                            # 排序
cat app.log | sort | uniq -c                  # 排序+统计次数
grep "ERROR" app.log | awk '{print $8}' | sort | uniq -c | sort -rn
#  ↑ 提取异常类型，统计出现频率，按次数降序

# === 管道进阶 ===
grep "ERROR" app.log | sed 's/ERROR/❌错误/g'   # sed 替换
```

### Day 5：网络 + 端口（30分钟）

```bash
# === 端口检查 ===
netstat -tlnp                   # 监听端口（可能没安装此命令）
ss -tlnp                        # 同上，更快
ss -tlnp | grep 3306            # 看看 MySQL 在不在

# === 测试 MySQL 连接 ===
# 从 linux 容器连 mysql 容器
mysql -h mysql-practice -uroot -proot123 -e "SHOW DATABASES;"

# === ping ===
ping -c 3 mysql-practice        # 测试容器间网络
ping -c 3 baidu.com             # 测试外网

# === curl（如果装了的话） ===
curl -v http://baidu.com 2>&1 | head -20
```

### Day 6：磁盘 + 系统信息（15分钟）

```bash
# === 磁盘 ===
df -h                            # 磁盘空间
du -sh /home/practice/*          # 每个子目录大小
du -sh * | sort -rh              # 按大小排序

# === 内存 ===
free -h                          # 内存使用

# === 系统信息 ===
uptime                           # 运行多久了
date                             # 当前时间
lsblk                            # 磁盘设备
```

---

## 二、MySQL 每日练习

> 进入：`docker exec -it mysql-practice mysql -uroot -proot123 practice`

### Day 1：建表 + 查看（30分钟）

```sql
-- 数据库已建好，直接 USE
USE practice;

-- 看看有什么表
SHOW TABLES;

-- 看看表结构
DESC user;
DESC orders;
DESC product;
DESC order_item;

-- 查看已有数据
SELECT * FROM user;
SELECT * FROM product;
SELECT * FROM orders;

-- 自己建一张表
CREATE TABLE IF NOT EXISTS blog (
    id      BIGINT PRIMARY KEY AUTO_INCREMENT,
    title   VARCHAR(200) NOT NULL,
    content TEXT,
    author  VARCHAR(50),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 查看建表语句
SHOW CREATE TABLE blog;
```

### Day 2：CRUD 增删改查（30分钟）

```sql
-- === INSERT 增 ===
INSERT INTO blog(title, content, author) VALUES
('第一篇博客', '今天开始学MySQL', 'zhangsan'),
('Spring Boot笔记', 'Spring Boot很好用', 'lisi'),
('Linux学习心得', 'grep真好用', 'wangwu');

INSERT INTO blog(title, content, author) VALUES
(NULL, '标题为空', 'test');  -- 这个会报错，为什么？

-- === SELECT 查 ===
SELECT * FROM blog;
SELECT title, author FROM blog;
SELECT * FROM blog WHERE author = 'zhangsan';
SELECT * FROM blog WHERE title LIKE '%MySQL%';      -- 模糊查询
SELECT * FROM blog WHERE author IN ('zhangsan', 'lisi');
SELECT * FROM blog ORDER BY created_at DESC;
SELECT * FROM blog LIMIT 2;                          -- 只取前2条

-- === UPDATE 改 ===
UPDATE blog SET content = 'MySQL是关系型数据库' WHERE id = 1;
-- ⚠️ UPDATE 必须有 WHERE！
SELECT * FROM blog WHERE id = 1;  -- 确认改对了

-- === DELETE 删 ===
DELETE FROM blog WHERE id = 4;    -- 如果没有 id=4 就自己选一个
-- ⚠️ DELETE 必须有 WHERE！
-- DELETE FROM blog;  ← 这会删掉整个表！
```

### Day 3：多表查询 JOIN（40分钟）

```sql
-- === 内连接 INNER JOIN ===
-- 查所有有订单的用户及其订单
SELECT u.username, o.amount, o.status, o.created_at
FROM user u
INNER JOIN orders o ON u.id = o.user_id;

-- === 左连接 LEFT JOIN ===
-- 查所有用户（含没有订单的）
SELECT u.username, o.amount, o.status
FROM user u
LEFT JOIN orders o ON u.id = o.user_id;

-- === 右连接 RIGHT JOIN ===
SELECT u.username, o.amount, o.status
FROM user u
RIGHT JOIN orders o ON u.id = o.user_id;

-- === 三表联查 ===
-- 查每个订单包含哪些商品
SELECT u.username, o.id order_id, p.name product_name, 
       oi.quantity, p.price, (oi.quantity * p.price) subtotal
FROM orders o
JOIN user u ON o.user_id = u.id
JOIN order_item oi ON o.id = oi.order_id
JOIN product p ON oi.product_id = p.id;

-- === 聚合函数 ===
SELECT COUNT(*) FROM user;
SELECT AVG(age) FROM user;
SELECT SUM(amount) FROM orders WHERE status = 'PAID';
SELECT status, COUNT(*), SUM(amount) 
FROM orders 
GROUP BY status;
```

### Day 4：索引 + 事务（30分钟）

```sql
-- === 索引 ===
-- 给 user 表的 age 字段加索引
CREATE INDEX idx_user_age ON user(age);

-- 查看索引
SHOW INDEX FROM user;

-- 用 EXPLAIN 看是否走索引
EXPLAIN SELECT * FROM user WHERE age > 23;
-- 看 key 列：NULL = 没走索引，idx_user_age = 走了索引

-- 删除索引
DROP INDEX idx_user_age ON user;

-- === 事务 ===
-- 开第1个终端
START TRANSACTION;
UPDATE orders SET status = 'PAID' WHERE id = 2;

-- 开第2个终端
-- docker exec -it mysql-practice mysql -uroot -proot123 practice
SELECT * FROM orders WHERE id = 2;  -- 能查到吗？
-- → 默认隔离级别下，第2终端看不到第1终端未提交的修改

-- 回到第1终端
COMMIT;
-- 现在第2终端能看到了

-- 再练一次：事务回滚
START TRANSACTION;
DELETE FROM order_item WHERE order_id = 5;
SELECT * FROM order_item;  -- 确实删了
ROLLBACK;                    -- 撤销！
SELECT * FROM order_item;  -- 数据回来了
```

### Day 5：实用查询（30分钟）

```sql
-- === 分页查询（后端必写） ===
-- 第1页，每页2条
SELECT * FROM user LIMIT 0, 2;
-- 第2页
SELECT * FROM user LIMIT 2, 2;

-- === 子查询 ===
-- 查下过订单的用户
SELECT * FROM user WHERE id IN (
    SELECT DISTINCT user_id FROM orders
);

-- === 联合查询 UNION ===
SELECT id, username AS name FROM user
UNION
SELECT id, name FROM product;

-- === 条件更新 CASE WHEN ===
SELECT username, age,
    CASE 
        WHEN age < 25 THEN '青年'
        WHEN age < 30 THEN '壮年'
        ELSE '中年'
    END AS age_group
FROM user;

-- === 去重 ===
SELECT DISTINCT status FROM orders;
```

---

## 三、综合练习  Linux + MySQL 联动

### 场景：模拟线上故障排查

```bash
# 1. 进入 Linux 容器
docker exec -it linux-practice bash

# 2. 连上 MySQL 查数据
mysql -h mysql-practice -uroot -proot123 practice -e "
SELECT u.username, o.id, o.amount, o.status
FROM user u JOIN orders o ON u.id = o.user_id
WHERE o.status = 'PENDING';"

# 3. 写一个脚本自动化
cat > /home/practice/scripts/check_orders.sh << 'EOF'
#!/bin/bash
echo "===== 订单状态统计 $(date) ====="
mysql -h mysql-practice -uroot -proot123 practice -e "
SELECT status, COUNT(*) count, SUM(amount) total
FROM orders GROUP BY status;"
echo ""
EOF

chmod +x /home/practice/scripts/check_orders.sh
./home/practice/scripts/check_orders.sh

# 4. 设置定时执行（模拟 crontab）
# 每2分钟检查一次
while true; do
    clear
    /home/practice/scripts/check_orders.sh
    sleep 120
done
# Ctrl+C 停止
```

---

## 四、结合 Java 项目练

在你的 Spring Boot 项目 `application.yml` 里：

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/practice
    username: dev
    password: dev123
    driver-class-name: com.mysql.cj.jdbc.Driver
```

然后写一个简单的 Controller 连上数据库 CRUD——这才是实习最重要的能力。

---

## 五、8 天练完计划表

| 天 | 内容 | 时间 |
|----|------|------|
| 1 | Docker 环境启动 + Linux Day 1（终端基础） | 30min |
| 2 | Linux Day 2（文件权限）+ Day 3（进程） | 45min |
| 3 | Linux Day 4（日志排查 grep） | 30min |
| 4 | Linux Day 5-6（网络+磁盘） | 30min |
| 5 | MySQL Day 1-2（建表+CRUD） | 45min |
| 6 | MySQL Day 3（JOIN 多表查询） | 45min |
| 7 | MySQL Day 4（索引+事务） | 30min |
| 8 | 综合场景练习（Linux + MySQL 联动） | 45min |

---

## 常用命令速查

```bash
# Docker 环境
docker compose up -d                    # 启动
docker compose down                     # 停止（保留数据）
docker compose down -v                  # 停止+删数据
docker compose ps                       # 看状态
docker compose logs -f mysql            # 看 MySQL 日志
docker exec -it linux-practice bash     # 进 Linux
docker exec -it mysql-practice mysql -uroot -proot123 practice  # 进 MySQL
```

---

**相关笔记**: [[Linux]] · [[sql/mysql]]
