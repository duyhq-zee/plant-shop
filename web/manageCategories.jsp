<%-- 
    Document   : manageAccount
    Created on : Mar 16, 2022, 5:46:26 PM
    Author     : duyhu
--%>

<%@page import="duyhq.dto.Category"%>
<%@page import="duyhq.dao.CategoryDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="duyhq.dto.Account"%>
<%@page import="duyhq.dao.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Orders</title>
    </head>
    <body>
        <%
            ArrayList<Category> list = CategoryDAO.getCategories();
//            String keyword = request.getParameter("txtSearch");
        %>
        <%--<c:import url="header_loginedAdmin.jsp" />--%>
        <%@include file="header_loginedAdmin.jsp" %>
        <h1></h1>
        <table class="order">
            <tr>
                <th>ID</th>
                <th>Category Name</th>
            </tr>
            <%
                for (Category o: list) {
            %>
            
            <tr>
                <td><%= o.getId()%></td>
                <td><%= o.getName()%></td>
            </tr>
            <%
                }
            %>
        </table>
        <%@include file="footer.jsp" %>
    </body>
</html>
