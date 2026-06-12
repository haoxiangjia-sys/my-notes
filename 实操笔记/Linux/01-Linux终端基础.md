---
tags: [linux, 实操, 终端]
created: 2026-06-10
---

# Linux 终端基础：文件与目录

## 核心概念

- **`~`** = 你的家目录 `/home/你的用户名`
- **`.`** = 当前目录
- **`..`** = 上一级目录
- **`/`** = 根目录（整个系统的起点）
- **Tab 键** = 自动补全（多按！省时间）

---

## 一、你在哪里？

```bash
pwd                    # 打印当前所在目录
# 输出：/home/xiang
```

---

## 二、查看目录内容

```bash
ls                     # 列出文件（不含隐藏的）
ls -l                  # 详细信息（权限、大小、时间）
ls -a                  # 包括隐藏文件（.开头）
ls -la                 # 两者结合，最常用
ls -lh                 # 文件大小以人类可读格式显示（K, M, G）
ls *.md                # 只看 .md 文件
```

---

## 三、目录穿梭

```bash
cd my-project          # 进入子目录
cd ..                  # 返回上一级
cd ../..               # 返回上两级
cd ~                   # 直接回家目录
cd /                   # 去根目录
cd -                   # 回到上次在的目录（超好用）
```

---

## 四、创建与删除

```bash
mkdir new-folder              # 创建目录
mkdir -p a/b/c                # 一次性创建多层嵌套目录
touch file.txt                # 创建空文件（或更新文件时间戳）
echo "hello" > hello.txt      # 创建文件并写入内容
echo "第二行" >> hello.txt    # 追加内容到文件末尾
rm file.txt                   # 删除文件（没有回收站！）
rm -r folder/                 # 删除目录及内容
rm -rf folder/                # 强制删除，不询问（❌危险！）
rmdir empty-folder/           # 只删空目录
```

---

## 五、复制与移动

```bash
cp a.txt b.txt                # 复制文件
cp -r folder1/ folder2/       # 复制整个目录
mv old.txt new.txt            # 重命名（同一目录下）
mv file.txt ../               # 移动到上一级目录
```

---

## 六、查看文件内容

```bash
cat file.txt                  # 一次性显示全部（小文件）
less file.txt                 # 分页浏览（按 q 退出，/ 搜索）
head -n 20 file.txt           # 看前 20 行
tail -n 20 file.txt           # 看后 20 行
tail -f log.txt               # 实时追踪日志（Ctrl+C 停止）
wc -l file.txt                # 统计行数
```

---

## 实操练习 🎯

打开终端，逐条敲一遍：

```bash
# 1. 先回家
cd ~

# 2. 创建一个练习目录
mkdir linux-practice
cd linux-practice

# 3. 创建一些文件
touch readme.md
echo "Hello Linux!" > hello.txt
echo "这是第二行" >> hello.txt
mkdir subfolder
touch subfolder/test.js

# 4. 探索
pwd
ls -la
cat hello.txt
wc -l hello.txt

# 5. 清理（回到上级再删）
cd ..
rm -rf linux-practice
```
