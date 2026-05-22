<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String cid = request.getParameter("id");
    Class.forName("org.sqlite.JDBC");
    String url = "jdbc:sqlite:D:/web实验/lab05/src/main/database/bookstore.db";
    Connection conn = DriverManager.getConnection(url);

    PreparedStatement ps = conn.prepareStatement(
            "select name,author,price,image_url from book where category_id=?"
    );
    ps.setString(1, cid);
    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
%>

<div class="col-md-3" style="margin-bottom: 20px;">
    <div class="thumbnail" style="height: 100%;">
        <img src="<%=rs.getString("image_url")%>" style="width:100%;height:220px;object-fit:cover;">
        <div class="caption">
            <h4><%=rs.getString("name")%></h4>
            <p>作者：<%=rs.getString("author")%></p>
            <p>价格：<%=rs.getString("price")%> 元</p>
        </div>
    </div>
</div>

<%
    }
    rs.close();
    ps.close();
    conn.close();
%>