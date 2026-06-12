---
tags: [sql, 实操, 进阶]
created: 2026-06-10
---

# SQL 进阶：多表查询与 JOIN

## 前置：创建多表数据

```sql
-- 学生表
CREATE TABLE students (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

-- 课程表
CREATE TABLE courses (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    teacher TEXT
);

-- 选课表（关联表）
CREATE TABLE enrollments (
    student_id INTEGER,
    course_id INTEGER,
    score REAL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- 插入数据
INSERT INTO students VALUES (1, '张三'), (2, '李四'), (3, '王五'), (4, '赵六');
INSERT INTO courses VALUES (1, '数据库', '王教授'), (2, '操作系统', '李教授'), (3, '算法', '陈教授');
INSERT INTO enrollments VALUES
    (1, 1, 88), (1, 2, 76),
    (2, 1, 92), (2, 3, 85),
    (3, 2, 65), (3, 3, 70),
    (4, 1, 58);   -- 赵六只选了一门且不及格
```

---

## 一、INNER JOIN（内连接）

只返回**两表都有匹配**的行：

```sql
-- 查每个学生的选课和成绩
SELECT s.name, c.title, e.score
FROM students s
INNER JOIN enrollments e ON s.id = e.student_id
INNER JOIN courses c ON e.course_id = c.id;

-- 结果：
-- 张三 | 数据库   | 88
-- 张三 | 操作系统 | 76
-- 李四 | 数据库   | 92
-- 李四 | 算法     | 85
-- 王五 | 操作系统 | 65
-- 王五 | 算法     | 70
-- 赵六 | 数据库   | 58
```

> 💡 `s`, `e`, `c` 是**表别名**，简化书写。

---

## 二、LEFT JOIN（左连接）

返回**左表所有行**，右表没有匹配就填 NULL：

```sql
-- 每个学生及其选课情况（没选课的学生也显示）
SELECT s.name, c.title, e.score
FROM students s
LEFT JOIN enrollments e ON s.id = e.student_id
LEFT JOIN courses c ON e.course_id = c.id;
```

---

## 三、JOIN 类型对比

| JOIN 类型 | 返回什么 |
|-----------|---------|
| `INNER JOIN` | 两边都有匹配的行 |
| `LEFT JOIN` | 左表全部 + 右表匹配（无匹配填 NULL）|
| `RIGHT JOIN` | 右表全部 + 左表匹配（SQLite 不支持）|
| `FULL JOIN` | 两边全部（SQLite 不支持）|
| `CROSS JOIN` | 笛卡尔积（所有组合）|

---

## 四、子查询

```sql
-- 查询成绩高于平均分的学生
SELECT s.name, e.score
FROM students s
JOIN enrollments e ON s.id = e.student_id
WHERE e.score > (SELECT AVG(score) FROM enrollments);

-- 查询选了'数据库'这门课的学生
SELECT name FROM students
WHERE id IN (
    SELECT student_id FROM enrollments
    WHERE course_id = (SELECT id FROM courses WHERE title = '数据库')
);

-- 查每门课的最高分学生（相关子查询）
SELECT c.title, s.name, e.score
FROM enrollments e
JOIN students s ON e.student_id = s.id
JOIN courses c ON e.course_id = c.id
WHERE e.score = (
    SELECT MAX(score) FROM enrollments
    WHERE course_id = e.course_id
);
```

---

## 五、UNION（合并结果集）

```sql
-- 两个查询的结果纵向合并（列数和类型要匹配）
SELECT name, '学生' AS role FROM students
UNION
SELECT teacher, '教师' AS role FROM courses;

-- UNION ALL 不去重，UNION 自动去重
```

---

## 六、实用技巧

```sql
-- CASE WHEN（条件判断）
SELECT name, score,
    CASE
        WHEN score >= 90 THEN '优秀'
        WHEN score >= 80 THEN '良好'
        WHEN score >= 60 THEN '及格'
        ELSE '不及格'
    END AS 等级
FROM enrollments e
JOIN students s ON e.student_id = s.id;

-- COALESCE（取第一个非 NULL 值）
SELECT name, COALESCE(grade, '未评级') FROM students;

-- 创建视图（保存常用查询）
CREATE VIEW student_scores AS
SELECT s.name, c.title AS course, e.score
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id;

-- 以后直接查视图
SELECT * FROM student_scores WHERE score > 80;
```

---

## 实操练习 🎯

```bash
sqlite3 school.db
```

复制上面的建表和数据插入语句，然后完成：

1. 查出所有选了"数据库"课的学生和成绩，按成绩降序
2. 找出每门课的平均分
3. 列出**没有人选的课程**（LEFT JOIN 技巧）
4. 用 CASE WHEN 给每个选课记录评级
5. 找出每个学生选了几门课（GROUP BY + COUNT）

参考答案：

```sql
-- 1
SELECT s.name, e.score FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id
WHERE c.title = '数据库' ORDER BY e.score DESC;

-- 2
SELECT c.title, AVG(e.score) FROM courses c
JOIN enrollments e ON c.id = e.course_id
GROUP BY c.title;

-- 3（没人选的课程）
SELECT c.title FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
WHERE e.student_id IS NULL;

-- 4（见上面 CASE WHEN 示例）

-- 5
SELECT s.name, COUNT(e.course_id) as 选课数
FROM students s
LEFT JOIN enrollments e ON s.id = e.student_id
GROUP BY s.id;
```
