-- ============================================
-- MySQL 练习初始化脚本
-- 容器首次启动时自动执行
-- ============================================

USE practice;

-- ------------------------------------------
-- 用户表
-- ------------------------------------------
CREATE TABLE IF NOT EXISTS user (
    id         BIGINT PRIMARY KEY AUTO_INCREMENT,
    username   VARCHAR(50)  NOT NULL UNIQUE,
    password   VARCHAR(100) NOT NULL,
    age        INT,
    email      VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET utf8mb4;

-- ------------------------------------------
-- 订单表
-- ------------------------------------------
CREATE TABLE IF NOT EXISTS orders (
    id         BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id    BIGINT NOT NULL,
    amount     DECIMAL(10,2),
    status     VARCHAR(20) DEFAULT 'PENDING',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET utf8mb4;

-- ------------------------------------------
-- 商品表
-- ------------------------------------------
CREATE TABLE IF NOT EXISTS product (
    id    BIGINT PRIMARY KEY AUTO_INCREMENT,
    name  VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET utf8mb4;

-- ------------------------------------------
-- 订单商品关联表（多对多）
-- ------------------------------------------
CREATE TABLE IF NOT EXISTS order_item (
    id         BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id   BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity   INT NOT NULL DEFAULT 1,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
) ENGINE=InnoDB DEFAULT CHARSET utf8mb4;

-- ------------------------------------------
-- 插入示例数据
-- ------------------------------------------
INSERT INTO user(username, password, age, email) VALUES
('zhangsan', '123456', 25, 'zs@test.com'),
('lisi',     '123456', 28, 'ls@test.com'),
('wangwu',   '123456', 22, 'ww@test.com'),
('zhaoliu',  '123456', 30, 'zl@test.com');

INSERT INTO product(name, price, stock) VALUES
('Java编程思想',  79.00, 100),
('Spring实战',    89.00, 50),
('MySQL必知必会', 59.00, 200),
('Linux鸟哥',    99.00, 30);

INSERT INTO orders(user_id, amount, status) VALUES
(1, 79.00, 'PAID'),
(1, 148.00, 'PENDING'),
(2, 59.00, 'PAID'),
(2, 99.00, 'PAID'),
(3, 89.00, 'CANCELLED');

INSERT INTO order_item(order_id, product_id, quantity) VALUES
(1, 1, 1),
(2, 2, 1),
(2, 3, 1),
(3, 3, 1),
(4, 4, 1),
(5, 2, 1);
