---
created: 2026-05-21
tags:
  - java/internship
  - linux
related:
  - "[[_index]]"
---

# Linux

> Java 开发常用 Linux 命令与操作

## 目录与文件操作

### 常用命令

| 命令 | 说明 | 示例 |
| ---- | ---- | ---- |
| `pwd` | 当前目录路径 | `pwd` → `/home/user` |
| `ls` | 列出文件 | `ls -la`（显示所有文件+详情） |
| `cd` | 切换目录 | `cd /var/log` |
| `mkdir` | 创建目录 | `mkdir -p a/b/c`（递归创建） |
| `rmdir` | 删除空目录 | `rmdir dir` |
| `rm` | 删除文件/目录 | `rm -rf dir`（⚠️ 慎用） |
| `cp` | 复制 | `cp -r dir1 dir2`（递归复制） |
| `mv` | 移动/重命名 | `mv old new` |
| `touch` | 创建空文件 | `touch app.log` |
| `cat` | 查看小文件 | `cat application.yml` |
| `less` | 分页查看 | `less -N app.log`（显示行号） |
| `head` | 查看头部 | `head -100 app.log`（前100行） |
| `tail` | 查看尾部 | `tail -f app.log`（实时追踪） |

```bash
# 常用操作
ls -la                   # 查看文件详情（包含隐藏文件）
ls -lh                   # 文件大小以人类可读方式显示
ls -lt                   # 按修改时间排序

mkdir -p myapp/{src,bin,conf,logs}  # 一键创建多级目录

rm -rf logs/             # 删除 logs 目录及所有内容
rm -f *.log              # 删除所有 .log 文件

cp app.jar app.jar.bak   # 备份
cp -r /opt/app /backup/  # 递归复制整个目录

tail -f app.log          # 实时查看日志（最常用）
tail -200 app.log        # 查看最后200行
tail -f app.log | grep ERROR  # 实时过滤错误日志

less app.log             # 分页：/搜索 n下一个 N上一个 q退出
head -20 app.log         # 只看头20行
```

### 文件查找

| 命令 | 说明 | 示例 |
| ---- | ---- | ---- |
| `find` | 查找文件 | `find / -name "*.log"` |
| `grep` | 搜索内容 | `grep -r "ERROR" logs/` |
| `locate` | 快速查找 | `locate application.yml` |

```bash
find /var/log -name "*.log" -mtime -7    # 7天内修改的.log文件
find . -type f -name "*.java"            # 查找所有.java文件
find . -type d -name "target"            # 查找所有target目录

grep -r "Exception" --include="*.java" . # 搜索Java文件中的异常
grep -rn "error" logs/                   # 显示行号递归搜索
grep -v "^#" config.ini                  # 排除注释行
grep "^[0-9]" data.txt                   # 匹配数字开头的行
```

## 文件权限

```bash
# 权限表示
-rw-r--r--  1 root root  1024 May 27 10:00 app.log
|  |  |  |
|  用户 其他
|  组
类型：-文件 d目录 l链接

r=4  w=2  x=1
# chmod 755 = rwxr-xr-x（所有者rwx，组rx，其他rx）
```

| 命令 | 说明 | 示例 |
| ---- | ---- | ---- |
| `chmod` | 修改权限 | `chmod +x app.sh` |
| `chown` | 修改所有者 | `chown user:group file` |
| `chgrp` | 修改组 | `chgrp dev app.jar` |

```bash
chmod +x deploy.sh                      # 添加执行权限
chmod 600 id_rsa                        # 私钥只能自己读写
chmod 755 /opt/app                      # 目录标准权限
chown -R tomcat:tomcat /opt/tomcat/     # 递归修改所有者
```

## 进程管理

| 命令 | 说明 | 示例 |
| ---- | ---- | ---- |
| `ps` | 进程列表 | `ps -ef | grep java` |
| `top` | 进程监控 | `top -p PID` |
| `kill` | 结束进程 | `kill -9 PID`（强制） |
| `nohup` | 后台运行 | `nohup java -jar app.jar &` |
| `&` | 后台执行 | `command &` |

```bash
ps -ef | grep java               # 查找Java进程
ps aux --sort=-%mem | head -10   # 内存占用前10的进程

top -b -n 1 | head -20           # 一次性的top输出

kill 12345                       # 正常终止（发送 SIGTERM）
kill -9 12345                    # 强制终止（发送 SIGKILL）
kill -15 12345                   # 优雅终止（和kill一样）

nohup java -jar app.jar > app.log 2>&1 &    # 后台启动Java应用
# nohup：退出终端不停止
# > app.log：标准输出重定向
# 2>&1：错误输出也重定向到同一个文件
# &：后台运行

jobs                             # 查看后台作业
fg %1                            # 将后台作业1切回前台
bg %1                            # 将前台作业切到后台
```

## 网络相关

| 命令 | 说明 | 示例 |
| ---- | ---- | ---- |
| `netstat` | 端口/连接 | `netstat -tlnp` |
| `ss` | 端口（更快） | `ss -tlnp` |
| `curl` | HTTP 请求 | `curl http://localhost:8080/health` |
| `ping` | 网络连通性 | `ping -c 4 baidu.com` |
| `telnet` | 端口连通性 | `telnet 192.168.1.1 8080` |

```bash
# 端口检查（排查端口被占用）
netstat -tlnp | grep 8080        # 查看8080端口被谁占用
ss -tlnp | grep 8080             # 同上，更快

# curl 测试（排查接口）
curl http://localhost:8080/actuator/health    # 健康检查
curl -X POST http://localhost:8080/api/user   # POST 请求
curl -v http://localhost:8080/api             # 显示请求详情（调试用）

# 网络连通性
ping -c 4 baidu.com              # 测试网络通不通
telnet 192.168.1.100 3306        # 测试远程 MySQL 端口
```

## 磁盘与内存

| 命令 | 说明 | 示例 |
| ---- | ---- | ---- |
| `df` | 磁盘空间 | `df -h` |
| `du` | 目录大小 | `du -sh *` |
| `free` | 内存 | `free -h` |

```bash
df -h                            # 磁盘空间（人类可读）
du -sh /opt/app/*                # 每个子目录的大小
du -sh * | sort -rh | head -10   # 当前目录下最大的10个

free -h                          # 内存使用情况
#               total   used   free  shared  buff/cache  available
# Mem:          7.6G    3.2G   1.8G    ...       2.6G      3.9G
# Swap:         2.0G    0.0G   2.0G
```

## 压缩与解压

| 命令 | 说明 | 示例 |
| ---- | ---- | ---- |
| `tar` | 打包/解包 | `tar -zcvf` / `tar -zxvf` |
| `zip` | zip 压缩 | `zip -r` |
| `unzip` | zip 解压 | `unzip` |

```bash
# tar.gz（最常用）
tar -zcvf app.tar.gz app/        # 压缩目录
tar -zxvf app.tar.gz             # 解压到当前目录
tar -zxvf app.tar.gz -C /opt/    # 解压到指定目录
tar -tf app.tar.gz               # 查看压缩包内容

# zip
zip -r app.zip app/              # 压缩目录
unzip app.zip                    # 解压
unzip app.zip -d /opt/app        # 解压到指定目录
```

## 系统管理

| 命令 | 说明 | 示例 |
| ---- | ---- | ---- |
| `systemctl` | 服务管理 | `systemctl start nginx` |
| `service` | 服务管理（旧） | `service mysql start` |
| `crontab` | 定时任务 | `crontab -e` |

```bash
# systemctl（CentOS 7+ / Ubuntu 16+）
systemctl status nginx           # 查看服务状态
systemctl start nginx            # 启动
systemctl stop nginx             # 停止
systemctl restart nginx          # 重启
systemctl enable nginx           # 开机自启
journalctl -u nginx -f           # 查看服务日志

# crontab
crontab -e                       # 编辑定时任务
crontab -l                       # 查看定时任务

# 格式：分 时 日 月 周  命令
0 3 * * *   /opt/backup.sh       # 每天凌晨3点执行
*/5 * * * *  /opt/check.sh       # 每5分钟执行
0 9 * * 1-5  /opt/work.sh        # 工作日上午9点执行
```

## 常用技巧

### 日志排查

```bash
# 实时追踪 + 过滤
tail -f app.log | grep --line-buffered ERROR

# 统计错误次数
grep -c "ERROR" app.log

# 查看某个时间段
sed -n '/2026-05-27 10:00/,/2026-05-27 11:00/p' app.log

# 只显示匹配行的上下几行
grep -A 5 "NullPointerException" app.log     # 后5行
grep -B 5 "NullPointerException" app.log     # 前5行
grep -C 5 "NullPointerException" app.log     # 前后各5行
```

### Vim 快速操作

```bash
vim app.log

# 常用模式
i          # 进入插入模式
Esc        # 退出插入模式
:w         # 保存
:q         # 退出
:wq        # 保存并退出
:q!        # 不保存强制退出

# 移动
gg         # 文件开头
G          # 文件末尾
:n         # 跳到第n行

# 搜索
/error     # 搜索error，n下一个 N上一个
:set nu    # 显示行号
```

### 查看系统信息

```bash
uname -a                       # 内核版本
cat /etc/os-release            # 系统版本
lscpu                          # CPU 信息
lsblk                          # 磁盘信息
hostname -I                    # IP 地址
uptime                         # 系统运行时间
date                           # 当前时间
```

---

## SQL 与 Linux 联动

> **Linux 是操作系统，MySQL 是安装在 Linux 上的一个服务。你通过 Linux 终端输入 mysql 命令来操作数据库。**

### 关系图

```
┌─────────────────────────────────────────┐
│              Linux (Ubuntu)              │
│                                          │
│  ┌──────────┐    ┌───────────────────┐  │
│  │ 终端/bash │───▶│  mysql 客户端      │  │
│  └──────────┘    └───────┬───────────┘  │
│                          │               │
│  ┌───────────────────────▼───────────┐  │
│  │  MySQL 服务 (mysqld)              │  │
│  │  - 监听 3306 端口                 │  │
│  │  - systemctl 管理启停             │  │
│  │  - 日志在 /var/log/mysql/         │  │
│  └───────────────────────────────────┘  │
└─────────────────────────────────────────┘
```

### 在 Ubuntu 上安装 MySQL

```bash
# 1. 安装 MySQL Server
sudo apt update
sudo apt install mysql-server -y

# 2. 查看服务状态（systemctl = Linux 命令管理 MySQL 这个服务）
sudo systemctl status mysql

# 3. 启动 + 开机自启
sudo systemctl start mysql
sudo systemctl enable mysql

# 4. 安全初始化（设 root 密码、删匿名用户等）
sudo mysql_secure_installation

# 5. 用 root 登录
sudo mysql
# 或者创建普通用户后：
mysql -u youruser -p
```

### Linux 命令 ↔ MySQL/SQL 对应关系

| 你要做的事 | Linux 命令 | MySQL/SQL |
|-----------|-----------|-----------|
| 启动服务 | `systemctl start mysql` | — |
| 查看进程 | `ps -ef \| grep mysql` | — |
| 查看端口 | `ss -tlnp \| grep 3306` | — |
| 查看日志 | `tail -f /var/log/mysql/error.log` | — |
| 连接数据库 | `mysql -u root -p` | — |
| 查看有哪些库 | — | `SHOW DATABASES;` |
| 查看有哪些表 | — | `SHOW TABLES;` |
| 查数据 | — | `SELECT * FROM user;` |
| 备份数据库 | `mysqldump -u root -p db > backup.sql` | — |
| 恢复数据库 | `mysql -u root -p db < backup.sql` | — |

### 日常使用流程

```bash
# 第1步：打开终端（就是你的 Ubuntu 终端）
# 第2步：检查 MySQL 是否在跑（Linux 命令）
sudo systemctl status mysql
ss -tlnp | grep 3306          # 端口在不在监听

# 第3步：如果没跑就启动（Linux 命令）
sudo systemctl start mysql

# 第4步：连上数据库（从 Linux 终端进入 MySQL 交互界面）
mysql -u root -p

# 第5步：现在你在 MySQL 里了，写 SQL
USE practice;
SELECT * FROM user;
SELECT COUNT(*) FROM orders WHERE status = 'PENDING';
EXIT;   -- 退出 MySQL，回到 Linux 终端
```

### 一行命令执行 SQL（不进入交互界面）

```bash
# 在 Linux 终端直接执行 SQL，拿结果
mysql -u root -proot123 practice -e "SELECT * FROM user;"

# 结合 Linux 管道：查完数据后用 grep/tail 过滤
mysql -u root -proot123 practice -e "SELECT * FROM user;" | grep "zhang"
mysql -u root -proot123 practice -e "SELECT COUNT(*) FROM orders;" | tail -1
```

### 备份与恢复（用 Linux 命令操作 MySQL 数据）

```bash
# 备份（导出 SQL 文件）
mysqldump -u root -p practice > practice_backup.sql

# 用 Linux 命令查看备份文件
head -50 practice_backup.sql           # 前50行
grep "CREATE TABLE" practice_backup.sql # 找建表语句

# 恢复（导入 SQL 文件）
mysql -u root -p practice < practice_backup.sql
```

### 查看 MySQL 日志（用 Linux 命令排查问题）

```bash
# MySQL 慢查询日志
sudo tail -f /var/log/mysql/mysql-slow.log

# MySQL 错误日志
sudo tail -100 /var/log/mysql/error.log | grep -i error

# 实时监控谁在连数据库
watch -n 2 'ss -tn | grep :3306'
```

### Shell + SQL 自动化脚本

```bash
#!/bin/bash
# check_db.sh - 定时检查数据库状态

echo "===== $(date) ====="
echo "--- MySQL 进程 ---"
ps -ef | grep mysql | grep -v grep

echo "--- 端口监听 ---"
ss -tlnp | grep 3306

echo "--- 数据库状态 ---"
mysql -u root -proot123 -e "
SELECT table_name, table_rows 
FROM information_schema.tables 
WHERE table_schema = 'practice';"

echo "--- 磁盘 ---"
df -h /var/lib/mysql
```

---

**相关笔记**: [[_index]] · [[sql/mysql]] · [[linux-mysql-practice|🧪 Linux+MySQL 动手练习]]
