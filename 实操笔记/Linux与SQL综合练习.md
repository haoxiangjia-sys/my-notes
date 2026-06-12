---
tags: [linux, sql, 实操, 综合]
created: 2026-06-10
---

# Linux + SQL 综合练习

以下练习让你在 Linux 终端中用 SQLite 完成一个有实际场景的数据分析任务。

---

## 场景：书店销售数据分析

### 第一步：在 Linux 中准备环境

```bash
cd ~
mkdir bookstore-analysis
cd bookstore-analysis

# 创建 SQLite 数据库
sqlite3 bookstore.db
```

### 第二步：建表和数据

```sql
-- 书的类别
CREATE TABLE categories (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

-- 书
CREATE TABLE books (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    author TEXT,
    price REAL,
    category_id INTEGER,
    stock INTEGER DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- 顾客
CREATE TABLE customers (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    city TEXT,
    join_date TEXT    -- 用 TEXT 存日期，格式 'YYYY-MM-DD'
);

-- 订单
CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- 订单明细
CREATE TABLE order_items (
    order_id INTEGER,
    book_id INTEGER,
    quantity INTEGER,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);
```

### 插入数据

```sql
-- 类别
INSERT INTO categories VALUES (1, '计算机'), (2, '文学'), (3, '历史'), (4, '科学');

-- 书
INSERT INTO books VALUES
(1, '深入理解计算机系统', 'Randal Bryant', 139.0, 1, 50),
(2, '算法导论', 'CLRS', 128.0, 1, 30),
(3, '活着', '余华', 45.0, 2, 100),
(4, '三体', '刘慈欣', 93.0, 4, 80),
(5, '万历十五年', '黄仁宇', 36.0, 3, 60),
(6, 'JavaScript高级程序设计', 'Matt Frisbie', 89.0, 1, 25),
(7, '百年孤独', '马尔克斯', 55.0, 2, 40);

-- 顾客
INSERT INTO customers VALUES
(1, '张三', '北京', '2024-01-15'),
(2, '李四', '上海', '2024-02-20'),
(3, '王五', '北京', '2024-03-10'),
(4, '赵六', '深圳', '2024-04-05');

-- 订单
INSERT INTO orders VALUES
(1, 1, '2024-06-01'),
(2, 1, '2024-06-15'),
(3, 2, '2024-06-10'),
(4, 3, '2024-07-01'),
(5, 3, '2024-07-20'),
(6, 4, '2024-07-15');

-- 订单明细
INSERT INTO order_items VALUES
(1, 1, 1), (1, 4, 2),          -- 张三买了1本CS书+2本三体
(2, 2, 1),                      -- 张三又买了1本算法导论
(3, 3, 1), (3, 5, 2),          -- 李四买了活着+2本万历十五年
(4, 1, 1), (4, 6, 1),          -- 王五买了CS书+JS书
(5, 4, 1),                      -- 王五又买了三体
(6, 7, 1), (6, 3, 2);          -- 赵六买了百年孤独+2本活着
```

---

## 习题

### 初级
1. 列出所有计算机类的书名和价格
2. 查出价格高于 80 元的书
3. 统计每个顾客来自哪些城市（去重）
4. 按价格降序列出所有书

### 中级
5. 每个顾客下了几个订单？（GROUP BY + COUNT）
6. 列出每个订单买了哪些书、各几本、总金额（JOIN + 计算）
7. 哪个类别的书最多？（GROUP BY + ORDER BY + LIMIT）
8. 查询张三买过的所有书的书名

### 高级
9. 找出每个顾客的总消费金额
10. 哪本书卖得最好？（按总销量排序）
11. 列出库存低于平均库存的书
12. 2024年6月的总销售额是多少？

---

## 答案

<details>
<summary>点击展开答案</summary>

```sql
-- 1
SELECT title, price FROM books WHERE category_id = 1;

-- 2
SELECT title, price FROM books WHERE price > 80;

-- 3
SELECT DISTINCT city FROM customers;

-- 4
SELECT title, price FROM books ORDER BY price DESC;

-- 5
SELECT c.name, COUNT(o.id) as order_count
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.id;

-- 6
SELECT o.id AS 订单号, b.title AS 书名, oi.quantity AS 数量,
       b.price AS 单价, oi.quantity * b.price AS 小计
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN books b ON oi.book_id = b.id
ORDER BY o.id;

-- 7
SELECT c.name, COUNT(b.id) as book_count
FROM categories c
JOIN books b ON c.id = b.category_id
GROUP BY c.id
ORDER BY book_count DESC
LIMIT 1;

-- 8
SELECT DISTINCT b.title
FROM books b
JOIN order_items oi ON b.id = oi.book_id
JOIN orders o ON oi.order_id = o.id
JOIN customers c ON o.customer_id = c.id
WHERE c.name = '张三';

-- 9
SELECT c.name, SUM(oi.quantity * b.price) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN books b ON oi.book_id = b.id
GROUP BY c.id
ORDER BY total_spent DESC;

-- 10
SELECT b.title, SUM(oi.quantity) AS total_sold
FROM books b
JOIN order_items oi ON b.id = oi.book_id
GROUP BY b.id
ORDER BY total_sold DESC
LIMIT 1;

-- 11
SELECT title, stock FROM books
WHERE stock < (SELECT AVG(stock) FROM books);

-- 12
SELECT SUM(oi.quantity * b.price) AS june_revenue
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN books b ON oi.book_id = b.id
WHERE o.order_date BETWEEN '2024-06-01' AND '2024-06-30';
```
</details>
