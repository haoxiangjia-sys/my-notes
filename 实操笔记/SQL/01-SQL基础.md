---
tags: [sql, 实操, 数据库]
created: 2026-06-10
---

# SQL 基础实操

## 前置准备

在 WSL 中安装 MySQL（免费）：

```bash
sudo apt update
sudo apt install mysql-server -y

# 启动 MySQL 服务
sudo service mysql start

# 进入 MySQL 命令行
sudo mysql
```

或者用 **SQLite**（更轻量，无需服务）：

```bash
sudo apt install sqlite3 -y
sqlite3 test.db    # 创建/打开数据库文件，直接进入交互模式
```

> 💡 以下练习建议用 SQLite，零配置、单文件、随时删。

---

## 一、创建表

```sql
-- 创建一个学生表
CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER,
    grade TEXT,
    score REAL
);

-- 查看表结构
.schema students       -- SQLite
DESC students;         -- MySQL
```

---

## 二、插入数据

```sql
INSERT INTO students (name, age, grade, score) VALUES ('张三', 20, 'A', 88.5);
INSERT INTO students (name, age, grade, score) VALUES ('李四', 21, 'B', 72.0);
INSERT INTO students (name, age, grade, score) VALUES ('王五', 19, 'A', 95.0);
INSERT INTO students (name, age, grade, score) VALUES ('赵六', 22, 'C', 60.5);
INSERT INTO students (name, age, grade, score) VALUES ('孙七', 20, 'B', 78.0);
INSERT INTO students (name, age, grade, score) VALUES ('周八', 21, 'A', 91.0);

-- 批量插入
INSERT INTO students (name, age, grade, score) VALUES
    ('吴九', 19, 'C', 55.0),
    ('郑十', 22, 'B', 83.0);
```

---

## 三、查询基础

```sql
-- 查全部
SELECT * FROM students;

-- 查特定列
SELECT name, score FROM students;

-- 条件查询
SELECT * FROM students WHERE grade = 'A';
SELECT * FROM students WHERE score >= 80;
SELECT * FROM students WHERE age BETWEEN 20 AND 22;
SELECT * FROM students WHERE name LIKE '张%';     -- % 匹配任意字符
SELECT * FROM students WHERE name LIKE '_五';     -- _ 匹配单个字符

-- 多条件
SELECT * FROM students WHERE grade = 'A' AND score > 90;
SELECT * FROM students WHERE grade = 'C' OR score < 60;
SELECT * FROM students WHERE grade IN ('A', 'B');

-- 排序
SELECT * FROM students ORDER BY score DESC;        -- 降序
SELECT * FROM students ORDER BY grade ASC, score DESC;

-- 限制条数
SELECT * FROM students ORDER BY score DESC LIMIT 3;

-- 去重
SELECT DISTINCT grade FROM students;
```

---

## 四、聚合函数

```sql
SELECT COUNT(*) FROM students;              -- 总人数
SELECT AVG(score) FROM students;            -- 平均分
SELECT MAX(score) FROM students;            -- 最高分
SELECT MIN(score) FROM students;            -- 最低分
SELECT SUM(score) FROM students;            -- 总分

-- 分组统计
SELECT grade, COUNT(*) as 人数 FROM students GROUP BY grade;
SELECT grade, AVG(score) as 平均分 FROM students GROUP BY grade;

-- 分组后过滤（HAVING）
SELECT grade, AVG(score) as avg_score
FROM students
GROUP BY grade
HAVING avg_score >= 80;      -- 只看平均分 >= 80 的等级
```

> ⚠️ `WHERE` 过滤行，`HAVING` 过滤分组。`WHERE` 在分组前，`HAVING` 在分组后。

---

## 五、更新与删除

```sql
-- 更新
UPDATE students SET score = 85 WHERE name = '张三';
UPDATE students SET grade = 'A', score = 90 WHERE id = 4;

-- 删除
DELETE FROM students WHERE score < 60;
DELETE FROM students WHERE id = 8;         -- ✅ 精确删除
DELETE FROM students;                      -- ❌ 删光所有数据！慎用！
```

> 🔴 **WHERE 条件写之前先 SELECT 确认！**

---

## 实操练习 🎯

用 SQLite 完整跑一遍：

```bash
# 打开 SQLite（会自动创建文件）
sqlite3 school.db
```

在 SQLite 中逐条输入上面的 SQL。常用 SQLite 特有命令：

```
.tables          -- 查看所有表
.schema students -- 查看建表语句
.mode column     -- 查询结果按列对齐显示
.headers on      -- 显示列名
.quit            -- 退出
```

练习目标：
1. 建表 → 插 8 条数据 → 查全部
2. 查出 score > 80 的学生
3. 按 grade 分组求平均分
4. 把成绩最低的学生删掉
5. 统计还剩多少人、平均分多少
