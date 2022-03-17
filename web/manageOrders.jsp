<%-- 
    Document   : manageAccount
    Created on : Mar 16, 2022, 5:46:26 PM
    Author     : duyhu
--%>

<%@page import="duyhq.dto.Order"%>
<%@page import="duyhq.dao.OrderDAO"%>
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
            ArrayList<Order> list = OrderDAO.getAllOrders();
//            String keyword = request.getParameter("txtSearch");
            String[] status = {"", "processing", "completed", "canceled"};
        %>
        <%--<c:import url="header_loginedAdmin.jsp" />--%>
        <%@include file="header_loginedAdmin.jsp" %>
        <h1></h1>
        <table class="order">
            <tr>
                <th>ID</th>
                <th>Order Date</th>
                <th>Ship Date</th>
                <th>Status</th>
                <th>Customer phone</th>
            </tr>
            <%
                for (Order o: list) {
            %>
            
            <tr>
                <td><%= o.getOrderID()%></td>
                <td><%= o.getOrderDate()%></td>
                <td><%= o.getShipDate()%></td>
                <td><%= status[o.getStatus()] %></td>
            </tr>
            <%
                }
            %>
        </table>
        <%@include file="footer.jsp" %>
    </body>
</html>
