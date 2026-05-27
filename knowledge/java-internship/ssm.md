---
created: 2026-05-21
tags:
  - java/internship
  - java/ssm
---

# SSM 框架

> 📖 **目录**
> 
> [[#一、Maven]] — [[#Maven 坐标（GAV）|坐标]] · [[#依赖管理|依赖]] · [[#生命周期|生命周期]]
> 
> [[#二、Spring]] — [[#IoC（控制反转）|IoC]] · [[#DI（依赖注入）|DI]] · [[#Bean 配置|Bean]] · [[#注解开发|注解]]
> 
> [[#三、SpringMVC]] — [[#执行流程|流程]] · [[#请求注解|请求]] · [[#响应|响应]] · [[#拦截器|拦截器]]
> 
> [[#四、MyBatis]] — [[#MyBatis 配置|配置]] · [[#映射文件|映射]] · [[#动态 SQL|动态 SQL]]
> 
> [[#五、SpringBoot]] — [[#自动配置原理|自动配置]] · [[#常用注解|注解]]

---

## 一、Maven

**Maven = 项目管理工具（依赖管理 + 项目构建）**

### Maven 坐标（GAV）

每个依赖/项目都有唯一坐标：

```xml
<groupId>com.example</groupId>      <!-- 公司/组织名（反向域名） -->
<artifactId>my-app</artifactId>      <!-- 项目名 -->
<version>1.0.0</version>             <!-- 版本号 -->
```

### 依赖管理

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-context</artifactId>
        <version>5.3.30</version>
        <!-- <scope>compile</scope> -->   <!-- 默认 compile -->
    </dependency>
</dependencies>
```

#### 依赖范围（scope）

| scope | 编译 | 测试 | 运行 | 示例 |
| ----- | ---- | ---- | ---- | ---- |
| **compile**（默认） | ✅ | ✅ | ✅ | spring-core |
| **provided** | ✅ | ✅ | ❌ | servlet-api（Tomcat 自带） |
| **runtime** | ❌ | ✅ | ✅ | MySQL 驱动 |
| **test** | ❌ | ✅ | ❌ | JUnit |
| **system** | ✅ | ✅ | ❌ | 本地 jar（不推荐） |

### 生命周期

```
clean → validate → compile → test → package → verify → install → deploy
```

| 常用命令 | 说明 |
| -------- | ---- |
| `mvn clean` | 删除 target 目录 |
| `mvn compile` | 编译源代码 |
| `mvn test` | 运行测试 |
| `mvn package` | 打包（jar / war） |
| `mvn install` | 安装到本地仓库 |
| `mvn clean install` | 最常用：清空 + 重新构建 |

> **依赖传递**：A 依赖 B，B 依赖 C → A 自动拿到 C  
> 排除依赖：
> ```xml
> <exclusions>
>     <exclusion>
>         <groupId> unwanted </groupId>
>         <artifactId> unwanted </artifactId>
>     </exclusion>
> </exclusions>
> ```

---

## 二、Spring

**Spring 核心 = IoC（控制反转）+ DI（依赖注入）**

### IoC（控制反转）

**原来**：自己 new 对象 → `UserService userService = new UserService();`  
**Spring**：把对象交给 Spring 容器管理，用的时候直接拿

```java
// 1. 告诉 Spring 这个类归它管
@Component   // 把当前类交给 Spring 管理（创建 Bean）
public class UserService {
    public void save() {
        System.out.println("保存用户");
    }
}

// 2. 从容器中获取
public class Main {
    public static void main(String[] args) {
        ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserService userService = ctx.getBean(UserService.class);
        userService.save();
    }
}
```

### Bean 配置方式

#### XML 配置（老方式）

```xml
<bean id="userService" class="com.example.UserService"/>
```

#### 注解配置（主流）

| 注解 | 说明 |
| ---- | ---- |
| `@Component` | 通用组件 |
| `@Service` | 业务层（Service） |
| `@Repository` | 数据层（Dao） |
| `@Controller` | 控制层（SpringMVC） |
| `@Configuration` | 配置类 |
| `@Bean` | 在配置类中声明第三方 Bean |

#### 配置类方式（推荐）

```java
@Configuration
@ComponentScan("com.example")   // 扫描包下的 @Component
public class SpringConfig {
    @Bean
    public DataSource dataSource() {
        return new DruidDataSource();
    }
}
// new AnnotationConfigApplicationContext(SpringConfig.class);
```

### DI（依赖注入）

```java
@Service
public class UserService {
    @Autowired        // 按类型注入（byType）
    private UserDao userDao;

    @Autowired
    @Qualifier("userDaoImpl")   // 指定名称（配合 @Autowired）
    private UserDao userDao2;

    @Resource(name = "userDaoImpl")     // 按名称注入（javax）
    private UserDao userDao3;
}
```

> `@Autowired` 默认按类型匹配，找到多个同类型 Bean 会报错 → 配合 `@Qualifier` 指定名字  
> `@Resource` 默认按名称匹配，找不到再按类型

### 作用域与生命周期

```java
@Component
@Scope("singleton")     // 默认：单例（一个类只创建一个对象）
// @Scope("prototype")  // 原型：每次 getBean 都新创建

@PostConstruct         // 初始化后执行（构造方法 → 注入 → 执行）
public void init() {}

@PreDestroy            // 销毁前执行（单例才生效）
public void destroy() {}
```

### 注解开发汇总

| 注解 | 作用 |
| ---- | ---- |
| `@Component` / `@Service` / `@Controller` / `@Repository` | 声明 Bean |
| `@Autowired` | 按类型注入 |
| `@Qualifier` | 按名称注入（配合 @Autowired） |
| `@Value` | 注入普通类型属性 |
| `@Scope` | 设置作用域 |
| `@PostConstruct` / `@PreDestroy` | 生命周期回调 |
| `@Configuration` | 声明配置类 |
| `@Bean` | 声明第三方 Bean |
| `@ComponentScan` | 包扫描 |

---

## 三、SpringMVC

**SpringMVC = Web 层框架，替代 Servlet**

### 执行流程

```
用户请求 → DispatcherServlet（前端控制器）
    → HandlerMapping（找哪个 Controller 处理）
    → Controller（执行业务逻辑）
    → ModelAndView（封装数据和视图）
    → ViewResolver（解析视图）
    → 响应页面 / JSON
```

### 常用注解

```java
@Controller
@RequestMapping("/user")   // 类级别：统一前缀
public class UserController {

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    // @GetMapping("/list")    // 简化写法
    @ResponseBody             // 返回 JSON，不走视图解析器
    public String list() {
        return "user list";
    }
}
```

#### 请求注解

| 注解 | 说明 |
| ---- | ---- |
| `@RequestMapping` | 映射请求路径（可加 method） |
| `@GetMapping` | GET 请求 |
| `@PostMapping` | POST 请求 |
| `@PutMapping` | PUT 请求 |
| `@DeleteMapping` | DELETE 请求 |

#### 参数绑定

```java
// 1. 普通参数（参数名一致自动匹配）
@GetMapping("/get")
@ResponseBody
public String get(String name, int age) {}

// 2. @RequestParam（参数名不一致 / 必填）
@GetMapping("/get")
@ResponseBody
public String get(@RequestParam("username") String name,
                  @RequestParam(required = false) Integer age) {}

// 3. @PathVariable（RESTful）
@GetMapping("/user/{id}")
@ResponseBody
public String get(@PathVariable Integer id) {}

// 4. @RequestBody（JSON）
@PostMapping("/save")
@ResponseBody
public String save(@RequestBody User user) {}
```

### 响应

```java
@RestController            // = @Controller + @ResponseBody
@RequestMapping("/user")
public class UserController {

    @GetMapping("/{id}")
    public Result<User> getById(@PathVariable Integer id) {
        User user = userService.getById(id);
        return Result.success(user);   // 统一返回 JSON
    }
}
```

> 前后端分离项目：统一返回 `Result` 对象（code + message + data）

### 拦截器（Interceptor）

```java
@Component
public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 在 Controller 执行前运行
        // 返回 true 放行，false 拦截
        return true;
    }

    @Override
    public void postHandle(...) {}      // Controller 执行后，视图渲染前

    @Override
    public void afterCompletion(...) {} // 视图渲染后
}
```

```java
// 注册拦截器
@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/login", "/register");
    }
}
```

> **拦截器 vs 过滤器**：拦截器是 SpringMVC 的，只拦截 Controller 请求；过滤器是 Servlet 的，范围更广

---

## 四、MyBatis

**MyBatis = ORM 框架，操作数据库**

### 核心配置

```xml
<!-- mybatis-config.xml -->
<configuration>
    <environments default="development">
        <environment id="development">
            <transactionManager type="JDBC"/>
            <dataSource type="POOLED">
                <property name="driver" value="com.mysql.cj.jdbc.Driver"/>
                <property name="url" value="jdbc:mysql://localhost:3306/test"/>
                <property name="username" value="root"/>
                <property name="password" value="123456"/>
            </dataSource>
        </environment>
    </environments>
    <mappers>
        <mapper resource="com/example/UserMapper.xml"/>
    </mappers>
</configuration>
```

### 映射文件

```xml
<!-- UserMapper.xml -->
<mapper namespace="com.example.UserMapper">

    <!-- 查 -->
    <select id="selectById" resultType="com.example.User">
        SELECT * FROM user WHERE id = #{id}
    </select>

    <!-- 增 -->
    <insert id="insert" useGeneratedKeys="true" keyProperty="id">
        INSERT INTO user(name, age) VALUES(#{name}, #{age})
    </insert>

    <!-- 改 -->
    <update id="update">
        UPDATE user SET name = #{name} WHERE id = #{id}
    </update>

    <!-- 删 -->
    <delete id="delete">
        DELETE FROM user WHERE id = #{id}
    </delete>
</mapper>
```

### `#{}`  vs  `${}`

| 占位符 | 说明 | 防 SQL 注入 |
| ----- | ---- | ---------- |
| `#{name}` | 预编译，参数用 `?` 替代 | ✅ 安全 |
| `${name}` | 字符串拼接，直接替换 | ❌ 不安全（表名/列名动态时用） |

### 结果映射

```xml
<!-- 解决字段名不一致 -->
<resultMap id="userMap" type="com.example.User">
    <id column="id" property="id"/>
    <result column="user_name" property="name"/>
    <result column="user_age" property="age"/>
</resultMap>

<select id="selectById" resultMap="userMap">
    SELECT * FROM user WHERE id = #{id}
</select>
```

### 动态 SQL

```xml
<!-- if -->
<select id="list" resultType="User">
    SELECT * FROM user WHERE 1=1
    <if test="name != null and name != ''">
        AND name LIKE #{name}
    </if>
</select>

<!-- foreach -->
<select id="listByIds" resultType="User">
    SELECT * FROM user WHERE id IN
    <foreach collection="ids" item="id" open="(" separator="," close=")">
        #{id}
    </foreach>
</select>

<!-- sql 片段 -->
<sql id="columns">id, name, age</sql>
<select id="selectById" resultType="User">
    SELECT <include refid="columns"/> FROM user WHERE id = #{id}
</select>
```

### 注解方式（简单 SQL 推荐）

```java
public interface UserMapper {
    @Select("SELECT * FROM user WHERE id = #{id}")
    User selectById(int id);

    @Insert("INSERT INTO user(name, age) VALUES(#{name}, #{age})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(User user);

    @Update("UPDATE user SET name = #{name} WHERE id = #{id}")
    int update(User user);

    @Delete("DELETE FROM user WHERE id = #{id}")
    int delete(int id);
}
```

> **XML vs 注解**：复杂 SQL 用 XML（动态 SQL），简单 CRUD 用注解

---

## 五、SpringBoot

**SpringBoot = 简化 Spring 配置（开箱即用）**

```java
@SpringBootApplication   // 启动类
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

### 核心概念

| 概念 | 说明 |
| ---- | ---- |
| **起步依赖（Starter）** | 封装好的一组依赖，引入一个 = 引入一堆 |
| **自动配置** | 根据依赖自动配置 Bean（不用写 XML） |
| **application.yml** | 统一配置文件（替代 XML） |

### 常用 Starter

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
    <!-- 自动包含：Spring + SpringMVC + Tomcat + Jackson -->
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starter</artifactId>
    <version>2.3.0</version>
</dependency>
```

### 配置文件

```yaml
# application.yml（推荐，比 properties 更简洁）
server:
  port: 8080

spring:
  datasource:
    url: jdbc:mysql://localhost:3306/test
    username: root
    password: 123456
    driver-class-name: com.mysql.cj.jdbc.Driver

mybatis:
  mapper-locations: classpath:mapper/*.xml
  type-aliases-package: com.example.entity
  configuration:
    map-underscore-to-camel-case: true
```

### 自动配置原理

```
@SpringBootApplication
  ├── @SpringBootConfiguration     // 标记为配置类
  ├── @ComponentScan               // 扫描当前包及其子包
  └── @EnableAutoConfiguration      // 核心：自动配置
       └── 读取 META-INF/spring.factories（里面有 XXXAutoConfiguration）
           └── 条件装配（有相关依赖才生效）
```

**条件装配注解**：

| 注解 | 说明 |
| ---- | ---- |
| `@ConditionalOnClass` | 类路径有指定类才生效 |
| `@ConditionalOnMissingBean` | 容器中没有指定 Bean 才生效 |
| `@ConditionalOnProperty` | 配置中有指定属性才生效 |

### 配置绑定

```java
@Component
@ConfigurationProperties(prefix = "aliyun")   // 绑定 yml 中的 aliyun.*
@Data
public class AliyunProperties {
    private String accessKey;
    private String secretKey;
    private String bucket;
}
```

```yaml
# application.yml
aliyun:
  access-key: xxx
  secret-key: xxx
  bucket: my-bucket
```

### @SpringBootApplication 常用注解补充

| 注解 | 说明 |
| ---- | ---- |
| `@SpringBootApplication` | 启动类注解（组合注解） |
| `@EnableConfigurationProperties` | 开启配置绑定 |
| `@ConfigurationProperties` | 将 yml 属性绑定到类 |
| `@ConditionalOnXxx` | 条件装配系列 |
| `@Import` | 导入配置类 |
| `@SpringBootTest` | 测试类注解 |



