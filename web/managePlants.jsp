<%-- 
    Document   : manageAccount
    Created on : Mar 16, 2022, 5:46:26 PM
    Author     : duyhu
--%>

<%@page import="duyhq.dto.Plant"%>
<%@page import="duyhq.dao.PlantDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Orders</title>
    </head>
    <body>
        <%
            ArrayList<Plant> list = PlantDAO.getPlants("", "");
//            String keyword = request.getParameter("txtSearch");
            String[] status = {"", "processing", "completed", "canceled"};
        %>
        <%--<c:import url="header_loginedAdmin.jsp" />--%>
        <%@include file="header_loginedAdmin.jsp" %>
        <h1></h1>
        <table class="order">
            <tr>
                <th></th>
                <th>ID</th>
                <th>Plant name</th>
                <th>Description</th>
                <th>Category</th>
            </tr>
            <%
                for (Plant o: list) {
            %>
            
            <tr>
                <td><img width="100px" src="<%= o.getImgpath()%>"/></td>
                <td><%= o.getId()%></td>
                <td><%= o.getName()%></td>
                <td><%= o.getDescription()%></td>
                <td><%= o.getCatename()%></td>
            </tr>
            <%
                }
            %>
        </table>
        <%@include file="footer.jsp" %>
    </body>
</html>
