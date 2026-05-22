<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>网上书店</title>
    <!-- 引入 Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 自定义页面样式 */
        body {
            background-color: #f5f5f5;
        }
        .header {
            text-align: center;
            margin: 30px 0;
        }
        .header h1 {
            color: #4a148c;
            text-decoration: underline;
        }
        .top-links {
            position: absolute;
            top: 20px;
            right: 50px;
        }
        .top-links a {
            margin-left: 15px;
            color: #8b0000;
            font-size: 16px;
        }
        .modal-content {
            border-radius: 8px;
        }
        .modal-header {
            text-align: center;
            display: block;
            border-bottom: none;
        }
        .modal-title {
            font-size: 24px;
            color: #333;
        }
        .modal-footer {
            border-top: none;
            text-align: right;
        }
        .btn-primary {
            background-color: #337ab7;
            border-color: #2e6da4;
        }
        .btn-danger {
            background-color: #d9534f;
            border-color: #d43f3a;
        }
    </style>
</head>
<body onload="initAJAX()">

<!-- 顶部链接：登录/注册 -->
<div class="top-links">
    <a href="#" data-toggle="modal" data-target="#myModal">登录</a>
    <a href="#">注册</a>
</div>

<!-- 标题 -->
<div class="header">
    <h1>欢迎来到我的书店.</h1>
</div>

<!-- 登录弹窗（和示例样式一致） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">登录</h4>
            </div>
            <div class="modal-body">
                <form action="showID.jsp" method="post">
                    <div class="form-group">
                        <label>用户名</label>
                        <input type="text" name="id" class="form-control" placeholder="请输入用户名">
                    </div>
                    <div class="form-group">
                        <label>密码</label>
                        <input type="password" name="pwd" class="form-control" placeholder="请输入密码">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
                <button type="submit" class="btn btn-primary" formaction="showID.jsp" formmethod="post">登录</button>
            </div>
        </div>
    </div>
</div>

<!-- 主体内容区：书籍分类 + 书籍列表 -->
<div class="container">
    <div class="row">
        <div class="col-md-3">
            <ul class="nav nav-list">
                <li class="nav-header">书籍类型</li>
                <%
                    Class.forName("org.sqlite.JDBC");
                    // 改成你自己的数据库路径！
                    String url = "jdbc:sqlite:D:/web实验/lab05/src/main/database/bookstore.db";
                    Connection conn = DriverManager.getConnection(url);
                    Statement stat = conn.createStatement();
                    ResultSet rs = stat.executeQuery("select id,name from category");
                    while (rs.next()) {
                %>
                <li>
                    <a href="javascript:showBook('<%=rs.getString("id")%>')">
                        <%=rs.getString("name")%>
                    </a>
                </li>
                <%
                    }
                    rs.close(); stat.close(); conn.close();
                %>
            </ul>
        </div>

        <!-- 右侧书籍显示区 -->
        <div class="col-md-9" id="book"></div>
    </div>
</div>

<!-- 引入 jQuery 和 Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"></script>

<!-- AJAX 脚本 -->
<script>
    var xmlHttp;
    function initAJAX() {
        xmlHttp = new XMLHttpRequest();
    }
    function showBook(categoryID) {
        xmlHttp.onreadystatechange = function() {
            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                document.getElementById("book").innerHTML = xmlHttp.responseText;
            }
        };
        xmlHttp.open("GET", "getBook.jsp?id="+categoryID, true);
        xmlHttp.send();
    }
</script>

</body>
</html>