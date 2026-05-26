---
created: 2026-05-21
tags:
  - java/internship
  - database/mysql
---

# MySQL

> 📖 **目录**
> 
> [[#一、数据库基础概念]] — [[#数据库 Database|DB]] · [[#DBMS]] · [[#SQL]]
> 
> [[#二、SQL 分类]]
> 
> [[#三、DDL — 数据库/表操作]]

---

## 一、数据库基础概念

### 数据库（Database / DB）

> **数据库 = 存储数据的仓库**

```txt
Excel   → 一个文件存一堆数据
数据库  → 专门管理数据的软件，更安全、更高效、支持多人同时操作
```

### 数据库管理系统（Database Management System / DBMS）

| 术语 | 英文 | 说明 |
| ---- | ---- | ---- |
| **数据库** | Database (DB) | 存数据的仓库 |
| **数据库管理系统** | Database Management System (DBMS) | 管理数据库的软件 |
| **SQL** | Structured Query Language | 操作数据库的语言 |

```
用户 → 发 SQL 语句 → DBMS → 操作 → 数据库
```

**常见 DBMS**：

| DBMS | 特点 |
| ---- | ---- |
| **MySQL** | 开源免费，最流行 |
| **Oracle** | 商业收费，大厂用 |
| **SQL Server** | 微软的，.NET 项目 |
| **PostgreSQL** | 功能强大，开源 |
| **SQLite** | 轻量级，嵌入式 |

### SQL（Structured Query Language）

> **SQL = 操作数据库的标准语言**

```sql
-- 查
SELECT * FROM user WHERE age > 18;

-- 增
INSERT INTO user(name, age) VALUES('张三', 20);

-- 改
UPDATE user SET age = 21 WHERE name = '张三';

-- 删
DELETE FROM user WHERE id = 1;
```

### 表结构概念

| 术语 | 英文 | 说明 |
| ---- | ---- | ---- |
| **表** | Table | 存数据的二维结构 |
| **行 / 记录** | Row / Record | 表中的一条数据 |
| **列 / 字段** | Column / Field | 表中的一个属性 |
| **主键** | Primary Key | 唯一标识一条记录（不能重复） |
| **外键** | Foreign Key | 关联其他表的字段 |

---

## 二、SQL 分类

| 分类      | 英文                         | 说明      | 关键字                        |
| ------- | -------------------------- | ------- | -------------------------- |
| **DDL** | Data Definition Language   | 定义数据库结构 | `CREATE` `ALTER` `DROP`    |
| **DML** | Data Manipulation Language | 操作数据    | `INSERT` `UPDATE` `DELETE` |
| **DQL** | Data Query Language        | 查询数据    | `SELECT`                   |
| **DCL** | Data Control Language      | 权限控制    | `GRANT` `REVOKE`           |

---

## 三、DDL — 数据库/表操作

### 数据库操作

```sql
-- 查所有数据库
SHOW DATABASES;

-- 创建
CREATE DATABASE db_name;

-- 创建（指定字符集）
CREATE DATABASE db_name CHARACTER SET utf8mb4;

-- 使用
USE db_name;

-- 查看当前使用的数据库
SELECT DATABASE();

-- 删除
DROP DATABASE db_name;
```

### 表操作

```sql
-- 查所有表
SHOW TABLES;

-- 创建表
CREATE TABLE user (
    id       INT PRIMARY KEY AUTO_INCREMENT,  -- 主键、自增
    name     VARCHAR(20) NOT NULL,             -- 非空
    age      INT DEFAULT 0,                     -- 默认值
    email    VARCHAR(50) UNIQUE,                -- 唯一约束
    dept_id  INT,
    FOREIGN KEY (dept_id) REFERENCES dept(id)  -- 外键
);

-- 查看表结构
DESC user;

-- 删除表
DROP TABLE user;




