<%--
  Created by IntelliJ IDEA.
  User: 杨志鹏
  Date: 2026/5/8
  Time: 10:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录结果</title>
</head>
<body>
<h2>登录信息</h2>
用户名：<%=request.getParameter("id")%><br>
密码：<%=request.getParameter("pwd")%>
</body>
</html>
