---
created: 2026-05-21
tags:
  - java/internship
  - java/basics
---

# Java 基础

> 📖 **目录**
> 
> [[#一、Java 概述]] — [[#JVM / JDK / JRE|JVM/JDK/JRE]]
> 
> [[#二、基础语法]] — [[#关键字 & class|关键字]] · [[#字面量]] · [[#数据类型]] · [[#转义符 \t|转义符]] · [[#定义变量]] · [[#进制转换]] · [[#标识符规则]] · [[#键盘录入]]
> 
> [[#三、运算符]] — [[#算术运算符]] · [[#类型转换]] · [[#自增自减]] · [[#赋值运算符]] · [[#关系运算符]] · [[#逻辑运算符]] · [[#三元运算符]]
> 
> [[#四、流程控制]] — [[#switch]]
> 
> [[#五、循环结构]] — [[#for 循环|for]] · [[#while 循环|while]]
> 
> [[#六、数组]] — [[#一维数组]] · [[#二维数组]]
> 
> [[#七、方法（Method）|七、方法]] — [[#基本方法]] · [[#带参数的方法]] · [[#带返回值的方法]] · [[#方法重载（Overload）|方法重载]]
> 
> [[#八、Java 内存分配]]
> 
> [[#九、包（Package）|九、包]] 
> 
> [[#十、面向对象（OOP）|十、面向对象]] — [[#封装]] · [[#权限修饰符|权限]] · [[#继承]] · [[#继承的特点|特点]] · [[#继承体系|体系]] · [[#super 关键字|super]] · [[#多态]] · [[#抽象类和抽象方法|抽象类]] · [[#接口（interface）|接口]] · [[#final 关键字|final]] · [[#this 关键字|this]] · [[#构造方法]] · [[#JavaBean]]
> 
> [[#十一、StringBuilder]] — [[#StringJoiner]]
> 
> [[#十二、集合（Collection）|十二、集合]]
> 
> [[#十三、数据结构]] — [[#栈（Stack）|栈]] · [[#队列（Queue）|队列]] · [[#数组（Array）|数组]] · [[#链表（LinkedList）|链表]] · [[#二叉树]] · [[#二叉查找树（BST）|BST]] · [[#平衡二叉树（AVL）|AVL]] · [[#红黑树（Red-Black Tree）|红黑树]]
> 
> [[#十四、泛型（Generic）|十四、泛型]]
> 
> [[#十五、Stream 流]] — [[#创建 Stream|创建]] · [[#中间操作|中间]] · [[#终结操作|终结]] · [[#collect 收集器|collect]]
> 
> [[#十六、方法引用（::）|十六、方法引用]] — [[#① 静态方法引用 类名::static方法|静态]] · [[#② 实例方法引用 对象::实例方法|实例]] · [[#③ 特定类型方法引用 类名::实例方法|特定类型]] · [[#④ 构造方法引用 类名::new|构造]]
> 
> [[#十七、异常体系]] — [[#异常体系结构|体系结构]] · [[#两种异常的区别|两种异常]] · [[#异常处理方式|处理方式]] · [[#自定义异常|自定义]]
> 
> [[#十八、File 类]] — [[#创建 File 对象|创建对象]] · [[#常用方法|常用方法]]
> 
> [[#十九、IO 流(input output)|十九、IO 流]] — [[#IO 流分类|分类]] · [[#字节流（读写所有文件）|字节流]] · [[#字符流（读写文本文件）|字符流]] · [[#缓冲流（推荐，效率更高）|缓冲流]] · [[#try-with-resources 自动关流|自动关流]]
> 
> [[#二十、多线程]] — [[#进程 vs 线程|进程 vs 线程]] · [[#并发 vs 并行|并发 vs 并行]] · [[#创建线程的四种方式|创建方式]] · [[#线程生命周期（六种状态）|生命周期]] · [[#线程安全]] · [[#线程池参数（面试重点）|线程池]]

## 一、Java 概述

| 概念 | 全称 | 说明 |
| ---- | ---- | ---- |
| **Java SE** | 标准版 | 桌面开发 |
| **Java ME** | 微型版 | 嵌入式 |
| **Java EE** | 企业版 | Web 网站开发 |

> 应用方向：微服务、鸿蒙、Android、大数据开发

### JVM / JDK / JRE

| 术语 | 说明 |
| ---- | ---- |
| **JVM** (Java Virtual Machine) | 真正运行 Java 的地方 |
| **JDK** (Java Development Kit) | JVM + 库 + 开发工具 |
| **JRE** (Java Runtime Environment) | Java 运行时环境 |

---

## 二、基础语法

### 关键字 & class

```java
public    // 关键字
class     // 创建 / 定义一个类（class 是最小单位）
```

### 字面量

整数、小数、字符串、字符、布尔、空（null）

![[Pasted image 20260521231842.png]]

### 数据类型

#### 基本数据类型

| 类型 | 关键字 | 大小 | 取值范围 |
| ---- | ------ | ---- | -------- |
| 字节型 | `byte` | 1 字节 | -128 ~ 127 |
| 短整型 | `short` | 2 字节 | -32768 ~ 32767 |
| 整型 | `int` | 4 字节 | -21 亿 ~ 21 亿 |
| 长整型 | `long` | 8 字节 | -922 亿亿 ~ 922 亿亿 |
| 单精度浮点 | `float` | 4 字节 | ±3.4E-38 ~ ±3.4E+38 |
| 双精度浮点 | `double` | 8 字节 | ±1.7E-308 ~ ±1.7E+308 |
| 字符型 | `char` | 2 字节 | 0 ~ 65535 |
| 布尔型 | `boolean` | 未明确定义 | `true` / `false` |

> 整型默认是 `int`，浮点默认是 `double`  
> `long` 赋值要加 L：`long l = 100L;`  
> `float` 赋值要加 F：`float f = 1.5F;`

#### 引用数据类型

| 类型 | 说明 | 示例 |
| ---- | ---- | ---- |
| **类（class）** | 自定义或 JDK 提供的类 | `String`、`Student` |
| **接口（interface）** | 定义行为规范 | `List`、`Map` |
| **数组（array）** | 存储多个同类型数据 | `int[]`、`String[]` |

> 引用数据类型变量存的是**地址值**，指向堆内存中的对象  
> 基本数据类型变量存的是**具体的值**

### 转义符 `\t`

制表符，将长度补到 8

```java
System.out.println("name" + '\t' + "age");   // 输出：name    age
```

### 定义变量

```java
数据类型 变量名 = 数据值；
```

1. 变量中只保留一个值
2. 变量名不允许重复定义
3. 一条语句可以定义多个变量
4. 变量使用前要进行赋值
5. 变量有作用域

### 进制转换

二进制 → 十进制：**系数 × 基数的权次幂 相加**

```
101 = 1 × 2² + 0 × 2¹ + 1 × 2⁰ = 5
```

### 标识符规则

1. 由数字、字母、下划线和 `$` 组成
2. 不能用数字开头
3. 不能是关键字
4. 区分大小写

### 键盘录入

```java
import java.util.Scanner;              // 导包
Scanner sc = new Scanner(System.in);   // 创建对象
int i = sc.nextInt();                  // 接受输入
```

---

## 三、运算符

### 算术运算符

```java
+   -   *   /   %
```

### 类型转换

| 转换方式 | 说明 | 示例 |
| -------- | ---- | ---- |
| **隐式转换** | 小范围 → 大范围 | `byte → short → int → long → float → double` |
| | byte、short、char 运算时先转为 int | |
| **强制转换** | 大范围 → 小范围 | `byte b = (byte) a;` |

### 自增自减

```java
int x = 10;
int y = x++;   // y = 10，先赋值后自增
int z = ++x;   // z = 12，先自增后赋值
// 最终：x=12, y=10, z=12
```

### 赋值运算符

| 符号 | 等价于 | 示例 |
| ---- | ------ | ---- |
| `=` | — | `int a = 10` |
| `+=` | `a + b` | `a += b` |
| `-=` | `a - b` | `a -= b` |
| `*=` | `a * b` | `a *= b` |
| `/=` | `a / b` | `a /= b` |
| `%=` | `a % b` | `a %= b` |

> **注意**：`a += b` 自带隐式类型转换，比 `a = a + b` 更安全  
> 例：`short s = 1; s += 1;` ✅ 编译通过；`s = s + 1;` ❌ 类型提升报错

### 关系运算符

| 符号 | 示例 | 结果 |
| ---- | ---- | ---- |
| `==` | `2 == 3` | `false` |
| `!=` | `2 != 3` | `true` |
| `>` | `3 > 2` | `true` |
| `>=` | `3 >= 3` | `true` |
| `<` | `2 < 3` | `true` |
| `<=` | `3 <= 2` | `false` |

> 结果都是 `boolean` 类型，只有 `true` 或 `false`

### 逻辑运算符

| 符号 | 作用 | 说明 |
| ---- | ---- | ---- |
| `&` | 逻辑与（且） | 并且，两边都为真，结果才是真 |
| `\|` | 逻辑或 | 或者，两边都为假，结果才是假 |
| `^` | 逻辑异或 | 相同为 false，不同为 true |
| `!` | 逻辑非 | 取反 |

> `&&` 和 `||` 是**短路运算符**：左边能决定结果时，右边就不执行  
> `&` 和 `|` 两边都会执行

### 三元运算符

```java
关系表达式 ? 表达式1 : 表达式2;
// true → 返回表达式1，false → 返回表达式2
```

---

## 四、流程控制

### switch

```java
switch (表达式) {
    case value1:
        语句体1;
        break;
    case value2:
        语句体2;
        break;
    default:
        语句体3;
        break;
}
```

---

## 五、循环结构

### for 循环

```java
for (初始化; 条件判断; 条件控制) {
    // 循环体
}
```

### while 循环

```java
while (条件判断) {
    // 循环体
    // 条件控制
}
```

---

## 六、数组

### 一维数组

```java
数据类型[] 数组名;
```

数组存在**内存**里，通过**索引（index）** 对元素访问

#### 静态初始化

```java
int[] arr = new int[]{11, 22, 33};
int[] arr = {11, 22, 33};   // 简化写法
```

#### 动态初始化

```java
int[] arr = new int[3];     // 指定长度，默认值填充
```

### 二维数组

#### 静态初始化

```java
int[][] arr = {{11, 22}, {33, 44}};
```

#### 动态初始化

```java
int[][] arr = new int[2][3];
```

---

## 七、方法（Method）

方法：程序的**最小执行单元**，提高代码复用性、可维护性

### 基本方法

```java
public static void 方法名() {
    // 方法体
}

// 调用
方法名();
```

### 带参数的方法

```java
public static void method(int num1, int num2) {   // num1, num2 是形参
    int result = num1 + num2;
    System.out.println(result);
}
```

### 带返回值的方法

需要结果去编写另一段代码时，用返回值

```java
public static int 方法名(参数) {
    // 方法体
    return value;
}
```

### 方法重载（Overload）

同一个类中，定义了**同名**的方法，功能相似，但**参数类型或个数不同**

```java
public static int sum(int a, int b) { return a + b; }
public static double sum(double a, double b) { return a + b; }
public static int sum(int a, int b, int c) { return a + b + c; }
```

---

## 八、Java 内存分配

| 区域 | 说明 |
| ---- | ---- |
| **栈（Stack）** | 方法运行时用，方法进栈运行，运行完毕出栈 |
| **堆（Heap）** | `new` 出来的东西存在这里，在堆内存开了个空间 |
| **方法区（Method Area）** | 存储 class 信息 |

> 引用数据类型：变量储存的是**地址值**，引用其他空间的数据

---

## 九、包（Package）

**包 = 文件夹，用来管理类，防止类名冲突**

```java
package com.quiz.model;   // 声明包，必须写在文件第一行

import java.util.Scanner; // 导入其他包下的类
import com.quiz.model.Student;
```

| 概念 | 说明 |
| ---- | ---- |
| **package** | 声明类所在的包 |
| **import** | 导入其他包的类，省去写全类名 |
| **全类名** | 包名 + 类名，例如 `java.util.Scanner` |

> 域名倒写：`com.公司名.项目名.模块名` — 包命名规范

---

## 十、面向对象（OOP）

```java
public class Student {
    // 属性（成员变量）
    String name;
    double height;

    // 方法
    public void study() {}
    public void sleep() {}
}
```

### 封装

**把数据藏起来，只给外界暴露方法去操作它**

- **private** 把属性锁起来
- **public getter/setter** 提供受控的访问通道

### 权限修饰符

| 修饰符 | 同一个类 | 同包 | 子类（不同包） | 任何地方 |
| :----: | :------: | :--: | :------------: | :------: |
| `private` | ✅ | ❌ | ❌ | ❌ |
| `默认（default）` | ✅ | ✅ | ❌ | ❌ |
| `protected` | ✅ | ✅ | ✅ | ❌ |
| `public` | ✅ | ✅ | ✅ | ✅ |

```java
public class Student {
    private   int a;   // 只有本类能访问
              int b;   // 默认：本类 + 同包
    protected int c;   // 本类 + 同包 + 子类
    public    int d;   // 所有人都能访问
}
```

> 权限大小：`private` < `默认` < `protected` < `public`

### 继承

**子类继承父类的属性和方法，减少重复代码**

#### 继承的特点

| 特点                 | 说明                     |
| ------------------ | ---------------------- |
| **单继承**            | 一个子类只能继承一个父类           |
| **多层继承**           | 爷 → 父 → 子，可以一直往下传      |
| **所有类继承 Object**   | 所有类都隐式继承 `Object`（老祖宗） |
| **子类拥有父类的所有**      | 除了 private 和构造方法       |
| **子类可以扩展**         | 在父类基础上加自己的方法和属性        |
| **方法重写（Override）** | 子类可以重写父类的方法            |

#### 继承体系

```
Object（根类）
 └── Animal
      ├── Dog
      │    └── Husky（多层继承）
      └── Cat
```

```java
// 顶层：父类
public class Animal {
    public void eat() {
        System.out.println("吃东西");
    }
}

// 中间层：继承了 Animal
public class Dog extends Animal {
    public void bark() {
        System.out.println("汪汪");
    }
}

// 底层：继承了 Dog（多层继承）
public class Husky extends Dog {
    public void pullSled() {
        System.out.println("拉雪橇");
    }
}

// 使用
Husky h = new Husky();
h.eat();       // Animal 的
h.bark();      // Dog 的
h.pullSled();  // 自己的
```

#### 继承相关关键字

| 关键字         | 说明               |
| ----------- | ---------------- |
| `extends`   | 表示继承关系           |
| `super`     | 指向父类对象的引用        |
| `@Override` | 重写父类方法（方法名、参数相同） |
| `final`     | 类不能被继承，方法不能被重写   |

#### super 关键字

**`super` = 父类对象**

| 用法 | 说明 |
| ---- | ---- |
| `super.成员变量` | 访问父类的成员变量 |
| `super.方法名()` | 调用父类的方法 |
| `super()` | 调用父类的构造方法，必须写在第一行 |

```java
public class Dog extends Animal {
    public Dog() {
        super();           // 调用父类构造，必须写在第一行
    }

    @Override
    public void eat() {
        super.eat();       // 调用父类的 eat
        System.out.println("狗在吃骨头");
    }
}
```

### 多态

**同一个行为有多种不同的表现形式**

前提：继承 + 方法重写 + 父类引用指向子类对象

```java
// 父类
public class Animal {
    public void shout() {
        System.out.println("动物叫");
    }
}

// 子类1
public class Dog extends Animal {
    @Override
    public void shout() {
        System.out.println("汪汪");
    }
}

// 子类2
public class Cat extends Animal {
    @Override
    public void shout() {
        System.out.println("喵喵");
    }
}

// 测试多态
public class Test {
    public static void main(String[] args) {
        Animal a1 = new Dog();   // 父类引用指向子类对象
        Animal a2 = new Cat();

        a1.shout();   // 汪汪（Dog 的）
        a2.shout();   // 喵喵（Cat 的）
    }
}
```

#### 多态的好处

**解耦**：写代码时面向父类编程，要换子类时不用改调用方的代码

```java
// 没有多态：每加一种动物就要写一个新方法
public void makeSound(Dog d) { d.shout(); }
public void makeSound(Cat c) { c.shout(); }

// 有多态：一个方法搞定所有动物
public void makeSound(Animal a) {   // 参数写父类
    a.shout();                       // 不管传什么子类进来都能调
}
```

#### 类型转换

```java
// 向上转型（自动）—— 把子类转成父类
Animal a = new Dog();

// 向下转型（强制）—— 把父类转回子类
Dog d = (Dog) a;

// 用 instanceof 判断类型，避免转型失败
if (a instanceof Dog) {
    Dog d2 = (Dog) a;
}
```

> **多态的核心**：编译看左边（父类），运行看右边（子类）

#### 多态的弊端

父类引用**不能调用子类特有的方法或属性**

```java
Animal a = new Dog();
a.shout();       // ✅ 父类有 shout()，调得到
a.bark();        // ❌ 编译报错！bark() 是 Dog 特有的，父类没有
```

解决办法：向下转型

```java
Animal a = new Dog();
if (a instanceof Dog) {
    Dog d = (Dog) a;   // 转回子类
    d.bark();          // ✅ 可以调了
}
```

> **总结**：多态让代码更灵活（解耦），但代价是丢失了子类特有的东西，要用向下转型拿回来

### 抽象类和抽象方法

**抽象类** — 用 `abstract` 修饰的类，不能创建对象，专门给子类继承

**抽象方法** — 只有声明没有方法体，强制子类重写

```java
// 抽象类
public abstract class Animal {
    public void eat() {
        System.out.println("吃东西");
    }

    // 抽象方法：没有方法体，子类必须重写
    public abstract void shout();
}

// 子类必须重写所有抽象方法，否则也得是抽象类
public class Dog extends Animal {
    @Override
    public void shout() {    // 不重写就编译报错
        System.out.println("汪汪");
    }
}
```

| 概念                | 规则                             |
| ----------------- | ------------------------------ |
| **抽象类**           | 用 `abstract class` 修饰，不能 `new` |
| **抽象方法**          | 用 `abstract` 修饰，没有方法体，必须被子类重写  |
| **抽象类可以有构造方法**    | 但不能直接 `new`，给子类 `super()` 调用的  |
| **抽象类可以有普通方法**    | 也可以有成员变量，和普通类一样                |
| **有抽象方法的类必须是抽象类** | 但抽象类可以没有抽象方法                   |

> 抽象类存在的意义：**强制子类按统一规范去实现**

### 接口（interface）

**接口 = 完全抽象的"规范"，只定义方法签名，不写实现**

```java
// 定义接口
public interface Flyable {
    void fly();   // 抽象方法，public abstract 省略了
}

// 实现接口（implements）
public class Bird implements Flyable {
    @Override
    public void fly() {
        System.out.println("鸟在飞");
    }
}

// 使用
Bird b = new Bird();
b.fly();
```

| 接口 vs 抽象类 | 接口 | 抽象类 |
| -------------- | ---- | ------ |
| 关键字 | `interface` | `abstract class` |
| 方法 | 全是抽象方法（Java 8+ 可以有 default/static） | 可以有普通方法 |
| 变量 | 只能 `public static final`（常量） | 可以有成员变量 |
| 构造方法 | 没有构造方法 | 可以有构造方法 |
| 多继承 | 类可以**实现多个接口** | 类只能继承一个抽象类 |

#### 接口的特性

```java
// 1. 一个类可以实现多个接口（弥补单继承的不足）
public class Plane implements Flyable, Moveable {
    @Override
    public void fly() { ... }

    @Override
    public void move() { ... }
}

// 2. 接口可以继承接口
public interface SuperFlyable extends Flyable {
    void superFly();
}

// 3. 接口中的变量都是常量
interface Config {
    int MAX_SIZE = 100;   // 相当于 public static final int MAX_SIZE = 100;
}
```

> **接口的意义**：定义规范，让不同的类遵循同样的行为标准  
> 常用接口：`List`、`Map`、`Runnable`、`Comparable`

### final 关键字

**`final` = 不可变的，最终状态**

| 使用位置 | 效果 | 示例 |
| -------- | ---- | ---- |
| **修饰变量** | 变量变成常量，值不能改 | `final int MAX = 100;` |
| **修饰方法** | 方法不能被重写 | `public final void run() {}` |
| **修饰类** | 类不能被继承 | `public final class Math {}` |

```java
public class Parent {
    public final void show() {
        System.out.println("不能重写我");
    }
}

public class Child extends Parent {
    // ❌ 编译报错！final 方法不能重写
    // @Override
    // public void show() {}
}

public final class MyString {
    // final 类不能被继承
}
```

> 常见 final 类：`String`、`Math`、`Integer`（包装类都是 final 的）

### this 关键字

**`this` = 当前对象自己**

| 用法 | 说明 | 示例 |
| ---- | ---- | ---- |
| `this.成员变量` | 区分成员变量和参数 | `this.name = name;` |
| `this()` | 本构造方法中调用另一个构造方法 | `this(name, age);` |

```java
public class Student {
    private String name;

    public void setName(String name) {
        this.name = name;  // this.name 是对象的name，= name 是参数
    }
}
```

### 构造方法

创建对象时自动调用，用来初始化对象

| 特点 | 说明 |
| ---- | ---- |
| 方法名 = 类名 | 必须和类名相同 |
| 无返回值 | 连 `void` 都不用写 |
| 默认赠送 | 不写任何构造时，Java 自动给一个无参构造 |

```java
public class Student {
    private String name;
    private int age;

    // 无参构造
    public Student() {
    }

    // 有参构造
    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }
}

// 使用
Student s1 = new Student();                  // 调无参构造
Student s2 = new Student("张三", 20);        // 调有参构造
```

> 注意：写了有参构造后，无参构造**不会自动生成**，要两个都用就都得手动写上

### JavaBean

一种 Java 类的编写规范（约定），框架依赖这套规范来操作你的类

| 规范 | 说明 |
| ---- | ---- |
| **类用 public 修饰** | 对外可见 |
| **提供无参构造** | 让框架能通过反射创建对象 |
| **属性用 private** | 封装，不让外界直接访问 |
| **提供 getter/setter** | 通过公共方法读写属性 |

```java
public class Student {
    private String name;
    private int age;

    public Student() {}

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }
}
```

> MyBatis、Spring 等框架都依赖 JavaBean 规范来创建对象和读写属性

### 内部类

**在一个类的内部再定义一个类**

#### 成员内部类

```java
public class Outer {
    private int num = 10;

    public class Inner {
        public void show() {
            System.out.println(num);   // 可以直接访问外部类的成员
        }
    }
}

// 使用
Outer o = new Outer();
Outer.Inner i = o.new Inner();
i.show();
```

#### 静态内部类

```java
public class Outer {
    public static class Inner {
        public void show() {
            System.out.println("静态内部类");
        }
    }
}

// 使用
Outer.Inner i = new Outer.Inner();
```

#### 匿名内部类（最常用）

**简化代码，不用单独写一个类，直接 new 接口或抽象类**

```java
// 不用匿名内部类：得单独写一个实现类
public class Dog implements Animal {
    @Override
    public void shout() { ... }
}

// 用匿名内部类：当场实现
Animal a = new Animal() {
    @Override
    public void shout() {
        System.out.println("汪汪");
    }
};
a.shout();
```

> 匿名内部类常用于：**事件监听**、**线程**、**集合排序（Comparator）**

### Lambda 表达式

**简化匿名内部类的写法，只保留核心参数和逻辑**

前提：接口必须是**函数式接口**（只有一个抽象方法）

```java
// 匿名内部类的写法
Comparator<Integer> c1 = new Comparator<>() {
    @Override
    public int compare(Integer a, Integer b) {
        return a - b;
    }
};

// Lambda 写法
Comparator<Integer> c2 = (a, b) -> a - b;
```

#### Lambda 语法

```java
(参数) -> { 方法体 }

// 示例
Runnable r1 = () -> System.out.println("run");           // 无参
Consumer<String> r2 = (s) -> System.out.println(s);      // 单参
BinaryOperator<Integer> r3 = (a, b) -> a + b;             // 多参
```

| 场景 | 匿名内部类 | Lambda |
| ---- | ---------- | ------ |
| 排序 | `new Comparator<>() { compare(a,b) { ... } }` | `(a, b) -> a - b` |
| 线程 | `new Runnable() { run() { ... } }` | `() -> { ... }` |
| 集合遍历 | `new Consumer<>() { accept(s) { ... } }` | `s -> System.out.println(s)` |

> **Lambda 本质**：函数式接口的快捷写法，代码更简洁  
> 常用函数式接口：`Runnable`、`Comparator`、`Consumer`、`Function`、`Predicate`

---

## 十一、StringBuilder

**StringBuilder** — 可变的字符串，用来解决 String 拼接效率低的问题

| 特点 | 说明 |
| ---- | ---- |
| **可变** | 内容可以修改，不会创建新对象 |
| **效率高** | 拼接字符串比 String 快很多 |
| **线程不安全** | 但性能比 StringBuffer 好 |

### 常用方法

| 方法                   | 说明        |
| -------------------- | --------- |
| `append(xxx)`        | 追加内容      |
| `insert(index, xxx)` | 在指定位置插入   |
| `delete(start, end)` | 删除指定范围    |
| `reverse()`          | 反转字符串     |
| `toString()`         | 转成 String |

```java
StringBuilder sb = new StringBuilder();

sb.append("Hello");
sb.append(" World");
System.out.println(sb);          // Hello World

sb.insert(5, ",");
System.out.println(sb);          // Hello, World

sb.reverse();
System.out.println(sb);          // dlroW ,olleH

String result = sb.toString();   // 转成 String
```

> String 拼接每次都会创建新对象，大量拼接时用 StringBuilder

### StringJoiner

用指定分隔符拼接字符串，可以加前缀和后缀

| 方法 | 说明 |
| ---- | ---- |
| `add(xxx)` | 添加元素 |
| `toString()` | 转成拼接后的字符串 |

```java
// 普通拼接，逗号分隔
StringJoiner sj = new StringJoiner(", ");
sj.add("Java");
sj.add("Python");
sj.add("C++");
System.out.println(sj);            // Java, Python, C++

// 带前缀和后缀
StringJoiner sj2 = new StringJoiner(", ", "[", "]");
sj2.add("A");
sj2.add("B");
sj2.add("C");
System.out.println(sj2);           // [A, B, C]
```

> 相比于 StringBuilder 手动处理分隔符，StringJoiner 更简单

---

## 十二、集合（Collection）

集合：可变的容器，用来存储多个对象，比数组更灵活

### 集合框架图

```
Collection（单列集合）
├── List（有序、可重复）
│   ├── ArrayList    ← 数组结构，查询快，增删慢
│   └── LinkedList   ← 链表结构，增删快，查询慢
├── Set（无序、不可重复）
│   ├── HashSet      ← 哈希表，存取最快
│   └── TreeSet      ← 红黑树，自动排序
│
Map（双列集合，键值对）
├── HashMap          ← 哈希表，最常用
├── LinkedHashMap    ← 哈希表 + 链表，**有序**
└── TreeMap          ← 红黑树，按键排序
```

### List

**List 特有方法（有索引，操作位置）**

| 方法 | 说明 |
| ---- | ---- |
| `add(index, element)` | 在指定位置插入 |
| `get(index)` | 获取指定位置的元素 |
| `set(index, element)` | 修改指定位置的元素 |
| `remove(index)` | 删除指定位置的元素 |
| `indexOf(element)` | 查找元素第一次出现的位置 |
| `lastIndexOf(element)` | 查找元素最后一次出现的位置 |
| `subList(from, to)` | 截取子列表（含头不含尾） |
| `sort(Comparator)` | 排序 |

```java
List<String> list = new ArrayList<>();
list.add("Java");                // 尾部添加
list.add(0, "Python");           // 在索引 0 插入
list.get(0);                     // 获取索引 0 的元素
list.set(0, "C++");              // 修改索引 0 的元素
list.remove(0);                  // 删除索引 0 的元素
list.indexOf("Java");            // 查找位置
list.sort(null);                 // 默认升序排序
```

#### ArrayList

```java
ArrayList<String> list = new ArrayList<>();
list.add("Java");
list.get(0);
list.set(0, "Python");
list.remove(0);
list.size();
```

> **特点**：底层数组，查询快（`get/set` O(1)），中间增删慢

#### LinkedList

```java
LinkedList<String> list = new LinkedList<>();
list.addFirst("A");        // 头部添加
list.addLast("B");         // 尾部添加
list.removeFirst();        // 移除头部
list.getFirst();           // 获取头部
list.getLast();            // 获取尾部
```

> **特点**：底层链表，头尾操作快（`addFirst/addLast` O(1)），中间查询慢

### Set

#### HashSet

```java
HashSet<String> set = new HashSet<>();
set.add("Java");
set.add("Python");
set.add("Java");           // 重复的不会被添加
// 输出：无顺序，不重复
```

#### TreeSet

```java
TreeSet<Integer> set = new TreeSet<>();
set.add(5);
set.add(1);
set.add(3);
// 输出：1, 3, 5（自动排序）
```

### Map

#### HashMap

```java
HashMap<String, Integer> map = new HashMap<>();
map.put("Java", 1);        // 添加键值对
map.get("Java");           // 根据键取值 → 1
map.remove("Java");        // 根据键删除
map.containsKey("Java");   // 判断键是否存在
map.keySet();              // 获取所有键
```

> **无序**：不保证顺序

#### LinkedHashMap

**有序的 HashMap，底层多了一个链表维护顺序**

```java
LinkedHashMap<String, Integer> map = new LinkedHashMap<>();
map.put("a", 1);
map.put("b", 2);
map.put("c", 3);
System.out.println(map);   // {a=1, b=2, c=3} 有序！
```

| | HashMap | LinkedHashMap |
| -- | ------- | ------------- |
| **底层** | 哈希表 | 哈希表 + 双向链表 |
| **顺序** | 无序 | 有序（默认插入顺序） |
| **性能** | 快 | 稍慢（维护链表开销） |
| **适用** | 不关心顺序 | 需要保持顺序 |

> **两种顺序模式**：
> 1. **插入顺序**（默认） — 按 put 的顺序
> 2. **访问顺序** — `new LinkedHashMap<>(16, 0.75f, true)`，最近访问的放最后，**可用于 LRU 缓存**

#### TreeMap

**按键自动排序（红黑树），遍历出来就是有序的**

```java
TreeMap<String, Integer> map = new TreeMap<>();
map.put("c", 3);
map.put("a", 1);
map.put("b", 2);
System.out.println(map);   // {a=1, b=2, c=3} 按键排序了！
```

|        | HashMap | TreeMap    |
| ------ | ------- | ---------- |
| **底层** | 哈希表     | 红黑树        |
| **顺序** | 无序      | 按键排序（默认升序） |
| **性能** | O(1)    | O(log n)   |
| **适用** | 不关心顺序   | 需要排序、范围查找  |

```java
// 自定义排序规则
TreeMap<String, Integer> map2 = new TreeMap<>((a, b) -> b.compareTo(a));
map2.put("a", 1);
map2.put("b", 2);
map2.put("c", 3);
System.out.println(map2);   // {c=3, b=2, a=1} 降序
```

> 相关：[[#红黑树（Red-Black Tree）]]

### Iterator（迭代器）

**用来遍历集合，不依赖索引**

```java
List<String> list = new ArrayList<>();
list.add("A");
list.add("B");
list.add("C");

// 获取迭代器
Iterator<String> it = list.iterator();

// hasNext() 判断还有没有下一个
// next() 获取下一个元素
while (it.hasNext()) {
    String s = it.next();
    System.out.println(s);
}
```

#### 迭代过程中删除

```java
// ❌ 错误：for-each 遍历时直接删会报错 ConcurrentModificationException
for (String s : list) {
    if (s.equals("B")) list.remove(s);   // 报错！
}

// ✅ 正确：用 iterator 的 remove
Iterator<String> it = list.iterator();
while (it.hasNext()) {
    String s = it.next();
    if (s.equals("B")) it.remove();      // 安全删除
}
```

### 五种遍历方式

```java
List<String> list = new ArrayList<>();
list.add("A");
list.add("B");
list.add("C");
```

#### ① 普通 for（有索引才能用）

```java
for (int i = 0; i < list.size(); i++) {
    System.out.println(list.get(i));
}
```

> 适用：List（有索引），Set/Map 不能用

#### ② 增强 for（for-each）

**底层就是 Iterator，代码更简洁**

```java
for (String s : list) {
    System.out.println(s);
}
```

> 适用：所有 Collection，不能修改/删除元素

#### ③ Iterator（迭代器）

```java
Iterator<String> it = list.iterator();
while (it.hasNext()) {
    String s = it.next();
    System.out.println(s);
}
```

> 适用：所有 Collection，可以安全删除元素（`it.remove()`）

#### ④ ListIterator（列表迭代器）

**List 特有，可以双向遍历**

```java
ListIterator<String> lit = list.listIterator();
while (lit.hasNext()) {
    System.out.println(lit.next());
}

// 从后往前遍历
while (lit.hasPrevious()) {
    System.out.println(lit.previous());
}
```

> 适用：只有 List 能用，支持前进/后退、添加、修改

#### ⑤ Lambda + forEach

```java
list.forEach(s -> System.out.println(s));
// 或
list.forEach(System.out::println);
```

> 适用：所有 Collection + Map，代码最简洁

#### Map 的遍历

```java
HashMap<String, Integer> map = new HashMap<>();
map.put("a", 1);
map.put("b", 2);
map.put("c", 3);
```

**① keySet + get（遍历键，再取值）**

```java
for (String key : map.keySet()) {
    System.out.println(key + "=" + map.get(key));
}
```

> 最简单，但每次 `get(key)` 都要查一次，效率略低

**② entrySet（遍历键值对）**

```java
for (Map.Entry<String, Integer> entry : map.entrySet()) {
    System.out.println(entry.getKey() + "=" + entry.getValue());
}
```

> 一次拿到键和值，性能最好，推荐

**③ Lambda（forEach）**

```java
map.forEach((k, v) -> System.out.println(k + "=" + v));
```

> 代码最简洁，Java 8+ 推荐写法

**④ Iterator + entrySet**

```java
Iterator<Map.Entry<String, Integer>> it = map.entrySet().iterator();
while (it.hasNext()) {
    Map.Entry<String, Integer> entry = it.next();
    System.out.println(entry.getKey() + "=" + entry.getValue());
}
```

> 遍历过程中可以安全删除元素（`it.remove()`）

**⑤ values（只遍历值）**

```java
for (Integer v : map.values()) {
    System.out.println(v);   // 1, 2, 3
}
```

> 只需要值、不需要键的时候用

### Collections 工具类

**`java.util.Collections` — 操作集合的工具类，全是静态方法**

| 方法 | 说明 |
| ---- | ---- |
| `sort(list)` | 排序（升序） |
| `sort(list, Comparator)` | 按自定义规则排序 |
| `reverse(list)` | 反转顺序 |
| `shuffle(list)` | 打乱顺序 |
| `binarySearch(list, key)` | 二分查找 |
| `max(list)` / `min(list)` | 找最大/最小值 |
| `fill(list, obj)` | 用指定对象填充 |
| `copy(dest, src)` | 复制集合 |
| `swap(list, i, j)` | 交换两个位置的元素 |
| `addAll(collection, elements...)` | 批量添加元素 |

```java
List<Integer> list = new ArrayList<>();
list.add(3);
list.add(1);
list.add(2);

Collections.sort(list);                  // [1, 2, 3]
Collections.reverse(list);               // [3, 2, 1]
Collections.shuffle(list);               // 打乱
Collections.addAll(list, 4, 5, 6);       // 批量加
int max = Collections.max(list);         // 最大值
int index = Collections.binarySearch(list, 3);  // 二分查找（必须先排序）
```

#### 不可变集合

**创建后不能修改的集合（增/删/改都会报错）**

**方式一：Collections 工具类**

```java
// 空集合
List<String> emptyList = Collections.emptyList();
Set<String> emptySet = Collections.emptySet();
Map<String, String> emptyMap = Collections.emptyMap();

// 单元素集合
List<String> singleList = Collections.singletonList("A");

// 把可变集合变成不可变
List<String> unmodifiableList = Collections.unmodifiableList(list);
// unmodifiableList.add("X");   // ❌ UnsupportedOperationException
```

**方式二：Java 9+ `List.of()` / `Set.of()` / `Map.of()`（推荐）**

```java
// 直接创建不可变集合
List<String> list = List.of("a", "b", "c");
Set<String> set = Set.of("a", "b", "c");
Map<String, Integer> map = Map.of("a", 1, "b", 2);

// list.add("d");   // ❌ 报错！不可变
```

| 方式 | 旧版写法 | Java 9+ 推荐 |
| ---- | -------- | ------------ |
| 空列表 | `Collections.emptyList()` | `List.of()` |
| 单元素 | `Collections.singletonList("a")` | `List.of("a")` |
| 多元素 | `Collections.unmodifiableList(list)` | `List.of("a", "b", "c")` |

> **不可变集合的好处**：安全（不会被意外修改）、省内存、线程安全

> `Collections` 和 `Collection` 的区别：
> - **Collection** — 接口，集合框架的根
> - **Collections** — 工具类，全是静态方法

---

## 十三、数据结构

### 栈（Stack）

**先进后出（FILO）** — 像叠盘子，先放的在最底下，后放的先拿

```
入栈：push → [ 底 | 1 | 2 | 3 ] ← 出栈：pop
```

> Java 对应：`Stack` 类、`Deque`（双端队列）

### 队列（Queue）

**先进先出（FIFO）** — 像排队，先排的先出

```
入队：add → [ 1 | 2 | 3 ] → 出队：poll
```

> Java 对应：`Queue` 接口、`LinkedList` 实现

### 数组（Array）

**连续内存，通过索引直接访问**

```
索引： [0] [1] [2] [3]
值：  [10][20][30][40]
```

| 操作 | 时间复杂度 |
| ---- | ---------- |
| 根据索引查询 | O(1) ✅ |
| 根据值查找 | O(n) |
| 中间插入/删除 | O(n) |
| 尾部添加 | O(1) ✅ |

### 链表（LinkedList）

**节点 + 指针，不连续内存**

```
单向链表：  head → [A|●] → [B|●] → [C|null]
双向链表：  null ⇄ [A|●] ⇄ [B|●] ⇄ [C] ⇄ null
```

| 操作 | 时间复杂度 |
| ---- | ---------- |
| 查询 | O(n) |
| 头尾插入/删除 | O(1) ✅ |
| 中间插入/删除 | O(n) |

### 二叉树

**每个节点最多有两个子节点（左子、右子）**

```
         root
        /    \
     left    right
     /  \    /   \
   LL   LR  RL   RR
```

> 遍历方式：前序（根左右）、中序（左根右）、后序（左右根）

### 二叉查找树（BST）

**二叉树的升级版，左小右大**

```
        10
       /  \
      5    15
     / \   /
    3   7 12
```

| 特性 | 说明 |
| ---- | ---- |
| **左子树** | 所有节点值 < 根节点 |
| **右子树** | 所有节点值 > 根节点 |
| **查找效率** | 理想 O(log n)，但可能退化成链表 O(n) |

### 平衡二叉树（AVL）

**解决 BST 退化成链表的问题，自动保持平衡**

```
        10
       /  \
      5    15     ← 左右高度差 ≤ 1
     / \
    3   7
```

> 任意节点的左右子树高度差不超过 1，通过**旋转**维持平衡

### 红黑树（Red-Black Tree）

**近似平衡的二叉树，HashMap 8+ 和 TreeMap 的底层实现**

| 规则 | 说明 |
| ---- | ---- |
| **1.** | 每个节点是红色或黑色 |
| **2.** | 根节点是黑色 |
| **3.** | 叶子节点（null）是黑色 |
| **4.** | 红色节点的子节点必须是黑色（不能有连续红色） |
| **5.** | 任意节点到叶子节点的路径上黑色节点数相同 |

> **效率**：查找 / 插入 / 删除 都是 O(log n)  
> **应用**：`HashMap`（链表 ≥8 转红黑树）、`TreeMap`、`TreeSet`

---

## 十四、泛型（Generic）

**泛型 = 参数化类型，把类型当参数传进去，编译时检查类型安全**

### 为什么用泛型

```java
// ❌ 不用泛型：可以存任何类型，取出来要强转，容易报错
List list = new ArrayList();
list.add("Hello");
list.add(123);
String s = (String) list.get(0);   // ✅ 但 list.get(1) 转 String 就炸了

// ✅ 用泛型：限制类型，编译时就检查
List<String> list2 = new ArrayList<>();
list2.add("Hello");
// list2.add(123);     // ❌ 编译报错，提前发现问题
String s2 = list2.get(0);          // ✅ 不需要强转
```

### 泛型类

```java
// 定义：<T> 是类型占位符
public class Box<T> {
    private T data;

    public void set(T data) {
        this.data = data;
    }

    public T get() {
        return data;
    }
}

// 使用
Box<String> box1 = new Box<>();      // T = String
box1.set("Hello");

Box<Integer> box2 = new Box<>();      // T = Integer
box2.set(123);
```

### 泛型方法

```java
public <T> void printArray(T[] arr) {
    for (T t : arr) {
        System.out.println(t);
    }
}
```

### 泛型接口

```java
public interface List<T> {
    void add(T element);
    T get(int index);
}

// 实现时指定类型
public class MyList implements List<String> {
    @Override
    public void add(String element) { ... }

    @Override
    public String get(int index) { ... }
}
```

### 泛型通配符

| 通配符 | 说明 | 示例 |
| ------ | ---- | ---- |
| `?` | 任意类型 | `List<?>` |
| `? extends T` | T 或 T 的子类（上限） | `List<? extends Number>` |
| `? super T` | T 或 T 的父类（下限） | `List<? super Integer>` |

```java
// ? extends T：可以传 Number 或其子类（Integer、Double...）
public void printNum(List<? extends Number> list) {
    for (Number n : list) {
        System.out.println(n);
    }
}

// ? super T：可以传 Integer 或其父类（Number、Object...）
public void addInt(List<? super Integer> list) {
    list.add(123);
}
```

> **常见泛型标识**：`T`（Type）、`E`（Element）、`K`（Key）、`V`（Value）

---

## 十五、Stream 流

**Stream = 对集合进行函数式操作，链式调用，一行搞定过滤/转换/收集**

### 创建 Stream

```java
// 从集合创建
List<String> list = Arrays.asList("a", "b", "c");
Stream<String> stream1 = list.stream();

// 从数组创建
Stream<String> stream2 = Arrays.stream(new String[]{"a", "b", "c"});

// 直接创建
Stream<String> stream3 = Stream.of("a", "b", "c");
```

### 中间操作（返回 Stream，可以链式调用）

| 方法 | 说明 | 示例 |
| ---- | ---- | ---- |
| `filter` | 过滤 | `filter(s -> s.startsWith("a"))` |
| `map` | 转换 | `map(s -> s.toUpperCase())` |
| `distinct` | 去重 | `distinct()` |
| `sorted` | 排序 | `sorted()` |
| `limit` | 截取前 n 个 | `limit(3)` |
| `skip` | 跳过前 n 个 | `skip(2)` |

### 终结操作（触发执行，一个 Stream 只能用一次）

| 方法 | 说明 |
| ---- | ---- |
| `collect` | 收集到集合 |
| `forEach` | 遍历 |
| `count` | 计数 |
| `anyMatch / allMatch / noneMatch` | 匹配判断 |
| `findFirst / findAny` | 查找 |
| `reduce` | 归约 |

### 实战示例

```java
List<String> list = Arrays.asList("张三", "李四", "王五", "张三丰", "张飞");

// 需求：找出姓张的，名字3个字的，转大写，排序，取前2个
List<String> result = list.stream()
    .filter(s -> s.startsWith("张"))       // 过滤：姓张
    .filter(s -> s.length() == 3)          // 过滤：3个字
    .map(String::toUpperCase)              // 转大写
    .sorted()                              // 排序
    .limit(2)                              // 取前2个
    .collect(Collectors.toList());         // 收集成 List

System.out.println(result);  // [张三丰, 张飞]
```

### collect 收集器

```java
// 收集到 List
List<String> list = stream.collect(Collectors.toList());

// 收集到 Set
Set<String> set = stream.collect(Collectors.toSet());

// 收集到 Map
Map<Integer, String> map = stream.collect(
    Collectors.toMap(String::length, s -> s)
);

// 分组
Map<Integer, List<String>> group = list.stream()
    .collect(Collectors.groupingBy(String::length));
// {1=[a], 2=[ab, cd], 3=[abc]}
```

> **Stream 特点**：
> - 不修改原数据，产生新流
> - 延迟执行，没有终结操作就不干活
> - 一个 Stream 只能用一次

---

## 十六、方法引用（::）

**方法引用 = Lambda 的简化写法，用 `::` 替代 `s -> ...`**

| 类型 | 语法 | Lambda 写法 | 方法引用 |
| ---- | ---- | ----------- | -------- |
| **静态方法** | `类名::静态方法` | `s -> Integer.parseInt(s)` | `Integer::parseInt` |
| **实例方法** | `对象::实例方法` | `s -> System.out.println(s)` | `System.out::println` |
| **特定类型方法** | `类名::实例方法` | `s -> s.compareTo(s2)` | `String::compareTo` |
| **构造方法** | `类名::new` | `() -> new Student()` | `Student::new` |

### 四种类型详解

#### ① 静态方法引用 `类名::static方法`

**条件**：Lambda 的参数 → 静态方法的参数

```java
// Lambda：参数 s 传给 parseInt
Function<String, Integer> f1 = s -> Integer.parseInt(s);
// 方法引用：参数自动传给静态方法
Function<String, Integer> f2 = Integer::parseInt;
```

#### ② 实例方法引用 `对象::实例方法`

**条件**：Lambda 的参数 → 实例方法的参数

```java
// Lambda：参数 s 传给 println
Consumer<String> c1 = s -> System.out.println(s);
// 方法引用：参数自动传给实例方法
Consumer<String> c2 = System.out::println;
```

#### ③ 特定类型方法引用 `类名::实例方法`

**条件**：Lambda 的第一个参数作为调用者，其余参数传给方法

```java
// Lambda：a 是调用者，b 是参数
Comparator<String> cmp1 = (a, b) -> a.compareTo(b);
// 方法引用：第一个参数当调用者
Comparator<String> cmp2 = String::compareTo;

// 再看一个
Function<String, Integer> g1 = s -> s.length();
Function<String, Integer> g2 = String::length;
```

#### ④ 构造方法引用 `类名::new`

**条件**：Lambda 的参数 → 构造方法的参数

```java
// Lambda：参数 s 传给构造方法
Function<String, Student> f1 = s -> new Student(s);
// 方法引用：参数自动传给构造
Function<String, Student> f2 = Student::new;

// 无参构造
Supplier<Student> s1 = () -> new Student();
Supplier<Student> s2 = Student::new;
```

### 使用规则总结

**能用方法引用的条件**：Lambda 体只有一行，且这一行正好在调用一个现有的方法

| 类型 | Lambda 参数 | 方法接收 | 示例 |
| ---- | ----------- | -------- | ---- |
| **静态方法引用** | 全部参数 | 作为静态方法参数 | `s -> Integer.parseInt(s)` → `Integer::parseInt` |
| **实例方法引用** | 全部参数 | 作为实例方法参数 | `s -> System.out.println(s)` → `System.out::println` |
| **特定类型方法引用** | 第一个参数当调用者，其余当参数 | 调用者.方法(其余参数) | `(a, b) -> a.compareTo(b)` → `String::compareTo` |
| **构造方法引用** | 全部参数 | 作为构造方法参数 | `s -> new Student(s)` → `Student::new` |

> **一句话规则**：如果你的 Lambda 只是把参数转发给另一个方法，就能换成 `::`

---

## 十七、异常体系

### 异常体系结构

```
Throwable（所有异常和错误的根类）
├── Error（严重错误，程序处理不了）
│   ├── OutOfMemoryError      内存溢出
│   ├── StackOverflowError    栈溢出
│   └── NoClassDefFoundError  类找不到
│
└── Exception（程序能处理的异常）
    ├── RuntimeException（运行时异常，不检查）
    │   ├── NullPointerException         空指针
    │   ├── ArrayIndexOutOfBoundsException 数组越界
    │   ├── ClassCastException           类型转换
    │   ├── ArithmeticException          算术异常（除0）
    │   └── IllegalArgumentException     非法参数
    │
    └── Checked Exception（编译时异常，必须处理）
        ├── IOException                  IO 异常
        ├── SQLException                 数据库异常
        ├── ClassNotFoundException       类找不到
        ├── InterruptedException         线程中断
        └── FileNotFoundException        文件找不到
```

### 两种异常的区别

| | RuntimeException | Checked Exception |
| -- | --------------- | ----------------- |
| **检查时机** | 运行时才报错 | 编译时就检查 |
| **必须处理吗** | 可以不处理 | 必须 try-catch 或 throws |
| **常见例子** | 空指针、越界、除0 | IOException、SQLException |
| **原因** | 代码逻辑bug | 外部环境问题 |

### 异常处理方式

#### 方式一：try-catch（自己处理）

```java
try {
    int result = 10 / 0;           // 可能出异常的代码
} catch (ArithmeticException e) {
    System.out.println("除0了");
    e.printStackTrace();           // 打印异常信息（最常用）
} finally {
    System.out.println("不管有没有异常都执行");
}
```

> `finally` — 不管有没有异常都会执行，通常用来关资源（数据库连接、文件流）

#### 方式二：throws（抛出去让别人处理）

```java
public void readFile() throws IOException {
    FileReader fr = new FileReader("test.txt");
    // 可能抛出 IOException，自己不处理，抛给调用方
}
```

#### 方式三：try-with-resources（自动关资源）

```java
// 实现了 AutoCloseable 的资源可以自动关闭
try (FileReader fr = new FileReader("test.txt")) {
    // 用完后自动 close，不用写 finally
} catch (IOException e) {
    e.printStackTrace();
}
```

### 自定义异常

```java
// 继承 RuntimeException（运行时异常）或 Exception（编译时异常）
public class AgeIllegalException extends RuntimeException {
    public AgeIllegalException(String message) {
        super(message);
    }
}

// 使用
public void setAge(int age) {
    if (age < 0 || age > 150) {
        throw new AgeIllegalException("年龄不合法：" + age);
    }
}
```

### 异常关键字总结

| 关键字 | 说明 |
| ------ | ---- |
| `try` | 监视可能出异常的代码 |
| `catch` | 捕获并处理异常 |
| `finally` | 不管怎样都会执行 |
| `throws` | 声明方法可能抛出的异常 |
| `throw` | 手动抛出一个异常 |

---

## 十八、File 类

**`java.io.File` — 代表文件或文件夹的路径，可以操作文件/目录的增删查**

> 注意：File 类操作的是**文件路径本身**，不是文件内容（读写内容用 IO 流）

### 创建 File 对象

```java
// 方式一：直接传路径
File f1 = new File("E:\\test\\a.txt");

// 方式二：父路径 + 子路径
File f2 = new File("E:\\test", "a.txt");

// 方式三：父 File 对象 + 子路径
File parent = new File("E:\\test");
File f3 = new File(parent, "a.txt");
```

### 常用方法

#### 获取信息

| 方法 | 说明 |
| ---- | ---- |
| `getName()` | 获取文件名或文件夹名 |
| `getPath()` | 获取构造时传入的路径 |
| `getAbsolutePath()` | 获取绝对路径 |
| `length()` | 获取文件大小（字节） |
| `lastModified()` | 获取最后修改时间（时间戳） |

#### 判断功能

| 方法 | 说明 |
| ---- | ---- |
| `exists()` | 判断文件或文件夹是否存在 |
| `isFile()` | 判断是否为文件 |
| `isDirectory()` | 判断是否为文件夹 |
| `isAbsolute()` | 判断是否为绝对路径 |

#### 增删功能

| 方法 | 说明 |
| ---- | ---- |
| `createNewFile()` | 创建新文件（不存在时才创建） |
| `mkdir()` | 创建单级文件夹 |
| `mkdirs()` | 创建多级文件夹（**推荐**） |
| `delete()` | 删除文件或空文件夹 |
| `renameTo(File dest)` | 重命名或移动 |

#### 目录遍历

| 方法 | 说明 |
| ---- | ---- |
| `list()` | 获取目录下的所有文件名（String[]） |
| `listFiles()` | 获取目录下的所有文件对象（File[]） |

### 示例

```java
File dir = new File("E:\\test");
File file = new File(dir, "a.txt");

// 创建文件夹
if (!dir.exists()) {
    dir.mkdirs();          // 创建多级目录
}

// 创建文件
if (!file.exists()) {
    file.createNewFile();
}

// 获取信息
System.out.println(file.getName());        // a.txt
System.out.println(file.length());         // 0（刚创建）
System.out.println(file.isFile());         // true

// 遍历目录
File[] files = dir.listFiles();
for (File f : files) {
    System.out.println(f.getName());
}
```

> **路径分隔符**：Windows 用 `\`，Linux/Mac 用 `/`  
> 跨平台推荐用 `File.separator` 常量

---

## 十九、IO 流(input output)

**IO 流 = 用来读写文件数据（输入/输出）**

### IO 流分类

```
字节流（读写所有类型文件）
├── InputStream（输入：读文件）
│   ├── FileInputStream        文件输入流
│   └── BufferedInputStream    缓冲输入流
└── OutputStream（输出：写文件）
    ├── FileOutputStream       文件输出流
    └── BufferedOutputStream   缓冲输出流

字符流（读写文本文件）
├── Reader（输入：读文本）
│   ├── FileReader             文件字符输入流
│   ├── BufferedReader         缓冲字符输入流
│   └── InputStreamReader      转换流（字节→字符）
└── Writer（输出：写文本）
    ├── FileWriter              文件字符输出流
    ├── BufferedWriter          缓冲字符输出流
    └── OutputStreamWriter      转换流（字符→字节）
```

| | 字节流 | 字符流 |
| -- | ----- | ------ |
| **读写单位** | 字节（byte） | 字符（char） |
| **适用** | 图片、视频、音频、任意文件 | 纯文本文件（.txt .java） |
| **基类** | InputStream / OutputStream | Reader / Writer |

### 字节流（读写所有文件）

```java
// 写文件
FileOutputStream fos = new FileOutputStream("E:\\test.txt");
fos.write("Hello".getBytes());     // 写入字节
fos.close();                       // 关闭流

// 读文件
FileInputStream fis = new FileInputStream("E:\\test.txt");
int b;
while ((b = fis.read()) != -1) {   // 一个个字节读
    System.out.print((char) b);
}
fis.close();
```

### 字符流（读写文本文件）

```java
// 写文件
FileWriter fw = new FileWriter("E:\\test.txt");
fw.write("Hello World");
fw.close();

// 读文件
FileReader fr = new FileReader("E:\\test.txt");
int ch;
while ((ch = fr.read()) != -1) {
    System.out.print((char) ch);
}
fr.close();
```

### 缓冲流（推荐，效率更高）

```java
// 缓冲输出
BufferedWriter bw = new BufferedWriter(new FileWriter("E:\\test.txt"));
bw.write("Hello");
bw.newLine();                      // 换行
bw.write("World");
bw.close();                        // 关外层即可，内层自动关

// 缓冲输入
BufferedReader br = new BufferedReader(new FileReader("E:\\test.txt"));
String line;
while ((line = br.readLine()) != null) {   // 一次读一行
    System.out.println(line);
}
br.close();
```

### try-with-resources 自动关流

```java
// 不用手动 close，自动关
try (FileWriter fw = new FileWriter("E:\\test.txt");
     BufferedWriter bw = new BufferedWriter(fw)) {

    bw.write("自动关流");
} catch (IOException e) {
    e.printStackTrace();
}
// 不用写 finally 关流了！
```

### IO 流使用场景速查

| 场景 | 用什么 |
| ---- | ------ |
| 读文本文件（.txt .java） | `BufferedReader` + `FileReader` |
| 写文本文件 | `BufferedWriter` + `FileWriter` |
| 读二进制文件（图片、视频） | `BufferedInputStream` + `FileInputStream` |
| 写二进制文件 | `BufferedOutputStream` + `FileOutputStream` |
| 按行读 | `BufferedReader.readLine()` |
| 指定编码读 | `BufferedReader` + `InputStreamReader` + `FileInputStream` |

---

### 附录：IO 流底层原理

#### 字节流缓冲区：一次读一个字节数组

```java
// ❌ 慢：一次读一个字节
FileInputStream fis = new FileInputStream("big.mp4");
int b;
while ((b = fis.read()) != -1) {   // 读一次，硬盘IO一次
    // ...
}

// ✅ 快：一次读一个字节数组（像卡车拉货）
FileInputStream fis = new FileInputStream("big.mp4");
byte[] buffer = new byte[8192];     // 8KB 缓冲区
int len;
while ((len = fis.read(buffer)) != -1) {  // 一次读一堆
    // buffer 里装了 len 个字节
}
```

> 原理：`read()` 一次读 1 字节 = 自行车拉货；`read(byte[])` 一次读 8KB = 卡车拉货

#### 文件拷贝实战

```java
public static void copyFile(String src, String dest) throws IOException {
    try (FileInputStream fis = new FileInputStream(src);
         FileOutputStream fos = new FileOutputStream(dest)) {

        byte[] buffer = new byte[8192];
        int len;
        while ((len = fis.read(buffer)) != -1) {
            fos.write(buffer, 0, len);   // 读多少写多少
        }
    }
}
```

#### FileOutputStream 追加写

```java
// 默认：覆盖写
FileOutputStream fos1 = new FileOutputStream("test.txt");
fos1.write("覆盖".getBytes());

// true = 追加写（续写，不覆盖原有内容）
FileOutputStream fos2 = new FileOutputStream("test.txt", true);
fos2.write("追加".getBytes());
```

#### 字符集与编码

**乱码的原因**：编码和解码用的字符集不一样

```java
// GBK 编码 → UTF-8 解码 = 乱码
byte[] bytes = "你好".getBytes("GBK");       // 编码
String str = new String(bytes, "UTF-8");    // 解码 → 乱码！
```

| 字符集 | 说明 | 中文占几个字节 |
| ------ | ---- | ------------- |
| **ASCII** | 英文编码，1字节 | 不支持中文 |
| **GBK** | 中文老标准 | 2 字节 |
| **UTF-8** | 国际通用标准（推荐） | 3 字节 |

```java
// Java 中编码解码
String str = "你好";

byte[] utf8 = str.getBytes("UTF-8");        // 编码：文字 → 字节
String s1 = new String(utf8, "UTF-8");      // 解码：字节 → 文字（不乱码）
String s2 = new String(utf8, "GBK");        // 解码用错字符集 → 乱码！
```

#### 字符流底层原理

**字符流 = 字节流 + 编码表 + 内存缓冲区**

```java
// 字符流内部做了什么？
FileReader fr = new FileReader("test.txt");
// 1. 底层用的是 FileInputStream（字节流）
// 2. 自动按 UTF-8 把字节解码成字符
// 3. 内部有一个 8KB 的缓冲区，减少硬盘IO

int ch;
while ((ch = fr.read()) != -1) {  // 读的是字符，不是字节
    System.out.print((char) ch);
}
```

#### flush() 的作用

**把缓冲区里的数据强制刷到硬盘**

```java
// 没有 flush()：数据可能还在缓冲区，没写到文件
BufferedWriter bw = new BufferedWriter(new FileWriter("test.txt"));
bw.write("Hello");
// 没 close、没 flush → 如果程序崩了，Hello 可能没写进去

// flush()：立马刷到硬盘
bw.flush();      // 还能继续写
bw.write(" World");
bw.close();      // close() 内部会自动 flush()
```

> **flush vs close**：`flush()` 刷完还能继续写；`close()` 刷完就关闭流，不能再写了

---

## 二十、多线程

**多线程 = 让程序同时干多件事**

### 进程 vs 线程

| 概念 | 说明 |
| ---- | ---- |
| **进程 (Process)** | 正在运行的程序，有独立的内存空间 |
| **线程 (Thread)** | 进程内的执行单元，共享进程的内存（堆和方法区） |

> 一个进程至少有一个线程（main 主线程），可以有多个线程并行执行

### 并发 vs 并行

| 概念 | 英文 | 说明 | 比喻 |
| ---- | ---- | ---- | ---- |
| **并发** | Concurrency | 同一时间段内交替执行（单核也能做） | 一个人同时烧水+扫地，来回切换 |
| **并行** | Parallelism | 同一时刻真正同时执行（必须多核） | 两个人，一个烧水一个扫地 |

```java
// 并发：单核 CPU 上，两个线程快速交替
// 看起来是"同时"跑，实际是 CPU 时间片轮转

// 并行：多核 CPU 上，两个线程各跑在一个核心上
// 真正的同一时刻都在执行
```

> **关键区别**：并发是**逻辑上的同时**（交替做），并行是**物理上的同时**（真的同时做）  
> 单核 CPU 只能并发，多核 CPU 才能并行

### 创建线程的四种方式

| 方式 | 返回值 | 抛异常 | 适用场景 |
| ---- | ----- | ------ | -------- |
| 继承 `Thread` | ❌ 无 | ❌ 不能抛 | 简单任务，但受单继承限制 |
| 实现 `Runnable` | ❌ 无 | ❌ 不能抛 | 常用，可继续继承其他类 |
| 实现 `Callable` | ✅ 有 | ✅ 可以抛 | 需要返回结果 |
| **线程池** | ✅ 推荐 | — | 生产环境首选，资源可控 |

#### ① 继承 Thread

```java
class MyThread extends Thread {
    @Override
    public void run() {
        System.out.println("线程执行了");
    }
}

// 启动线程
MyThread t = new MyThread();
t.start();    // start() 会开新线程去跑 run()
// t.run() 是普通方法调用，不会开新线程！
```

#### ② 实现 Runnable（推荐）

```java
class MyRunnable implements Runnable {
    @Override
    public void run() {
        System.out.println("线程执行了");
    }
}

Thread t = new Thread(new MyRunnable());
t.start();

// Lambda 简化
Thread t = new Thread(() -> System.out.println("线程执行了"));
t.start();
```

#### ③ 实现 Callable（有返回值）

```java
class MyCallable implements Callable<String> {
    @Override
    public String call() throws Exception {
        return "线程执行完毕";
    }
}

FutureTask<String> task = new FutureTask<>(new MyCallable());
Thread t = new Thread(task);
t.start();

String result = task.get();   // 获取返回值（会阻塞等待线程结束）
```

#### ④ 线程池（生产推荐）

```java
// 创建线程池（3 个固定线程）
ExecutorService pool = Executors.newFixedThreadPool(3);

pool.submit(() -> {
    System.out.println("线程池执行任务");
});

pool.shutdown();   // 关闭线程池
```

> 其他常见线程池：`newCachedThreadPool()`（动态扩容）、`newSingleThreadExecutor()`（单线程）

### 线程生命周期（六种状态）

```
NEW ──→ RUNNABLE ──→ TERMINATED
           │
           ↓
    BLOCKED / WAITING / TIMED_WAITING
```

| 状态 | 说明 |
| ---- | ---- |
| **NEW** | 创建了 Thread 对象，还没调用 `start()` |
| **RUNNABLE** | 调用了 `start()`，正在运行或等待 CPU 时间片 |
| **BLOCKED** | 等待锁（synchronized 没抢到锁） |
| **WAITING** | 调用了 `wait()` 或 `join()`，等待被唤醒 |
| **TIMED_WAITING** | 带超时的等待，如 `sleep(1000)`、`wait(1000)` |
| **TERMINATED** | 线程执行完毕 |

### 线程安全

**线程不安全的原因**：多个线程同时操作共享数据，导致数据不一致

```java
// ❌ 线程不安全：两个线程同时 count++ 会丢数据
int count = 0;
count++;  // 实际拆成三步：读 → 加 → 写，可能被插队
```

#### synchronized 同步锁

```java
// 方式一：同步代码块（锁对象）
synchronized (lockObj) {
    // 一次只允许一个线程进来
    count++;
}

// 方式二：同步方法（锁的是 this）
public synchronized void increment() {
    count++;
}

// 方式三：静态同步方法（锁的是 类.class）
public static synchronized void staticIncrement() {
    count++;
}
```

#### Lock 显式锁

```java
Lock lock = new ReentrantLock();

lock.lock();     // 加锁
try {
    count++;
} finally {
    lock.unlock(); // 一定要释放锁！
}
```

> **synchronized vs Lock**：`synchronized` 自动加解锁（简单）；`Lock` 更灵活（可超时、可中断、可尝试获取）

#### volatile 关键字

```java
// volatile 保证可见性：一个线程改了，其他线程立马看到
private volatile boolean flag = false;
```

> `volatile` 不能保证原子性（`count++` 仍然不安全），只是让变量在多个线程间**可见**

### 线程通信：wait / notify

```java
synchronized (lock) {
    while (条件不满足) {
        lock.wait();      // 释放锁，进入等待
    }
    // 条件满足，继续执行
    lock.notify();        // 唤醒一个等待线程
    lock.notifyAll();     // 唤醒所有等待线程
}
```

> `wait()` / `notify()` 必须在 `synchronized` 代码块内使用！

### 常用方法

| 方法 | 说明 |
| ---- | ---- |
| `start()` | 启动线程（开新线程执行 run） |
| `run()` | 线程要执行的任务（直接调不会开新线程） |
| `sleep(ms)` | 当前线程休眠，不释放锁 |
| `join()` | 等待这个线程执行完 |
| `yield()` | 让出 CPU 时间片（不一定生效） |
| `setDaemon(true)` | 设为守护线程（主线程结束它自动结束） |
| `interrupt()` | 中断线程（设置中断标志位） |

### 线程池参数（面试重点）

```java
ThreadPoolExecutor executor = new ThreadPoolExecutor(
    2,                    // corePoolSize：核心线程数
    5,                    // maximumPoolSize：最大线程数
    60L,                  // keepAliveTime：空闲线程存活时间
    TimeUnit.SECONDS,     // 时间单位
    new ArrayBlockingQueue<>(10),  // workQueue：任务队列
    new ThreadPoolExecutor.AbortPolicy()  // 拒绝策略
);
```

**线程池流程**：
1. 任务来了 → 核心线程没满 → 创建核心线程执行
2. 核心线程满了 → 放入任务队列等待
3. 队列满了 → 创建临时线程（直到最大线程数）
4. 都满了 → 执行拒绝策略

**四种拒绝策略**：

| 策略 | 行为 |
| ---- | ---- |
| `AbortPolicy`（默认） | 抛异常 `RejectedExecutionException` |
| `CallerRunsPolicy` | 谁提交的谁自己跑 |
| `DiscardPolicy` | 悄悄丢掉，不报错 |
| `DiscardOldestPolicy` | 丢掉最老的任务，再尝试提交 |
