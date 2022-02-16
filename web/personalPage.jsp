<%-- 
    Document   : personalPage
    Created on : Jan 25, 2022, 4:07:42 PM
    Author     : duyhu
--%>

<%@page import="duyhq.dto.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="duyhq.dao.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Personal page</title>
    </head>
    <body>
        <%
            String name = (String) session.getAttribute("name");
            if (name == null) {
        %>
        <p><font color="red">You must login to view personal page</font></p>
        <p></p>
        <%
        } else {
        %>
        <header>
            <%@include file="header_loginedUser.jsp" %>
        </header>
        <section>
            <h3>Welcome <%= name%> come back</h3>
            <h3><a href="mainController?action=Logout">Logout</a></h3>
        </section>
        <section>
            <!-- Orders -->
            <%
                String email = (String) session.getAttribute("email");
                ArrayList<Order> list = OrderDAO.getOrders(email);
                String[] status = {"", "processing", "completed", "canceled"};
                if (list != null && !list.isEmpty()) {
                    for (Order ord: list) {
            %>
            <table class="order">
                <tr>
                    <td>Order ID</td>
                    <td>Order Date</td>
                    <td>Ship Date</td>
                    <td>Order's status</td>
                    <td>Action</td>
                </tr>
                <tr>
                    <td><%= ord.getOrderID()%></td>
                    <td><%= ord.getOrderDate()%></td>
                    <td><%= ord.getShipDate()%></td>
                    <td>
                        <%= status[ord.getStatus()]%>
                        <br/>
                        <% if (ord.getStatus() == 1) %><a href="#">Cancel order</a>
                    </td>
                    <td><a href="orderDetail.jsp?orderid=<%= ord.getOrderID() %>">Detail</a></td>
                </tr>
            </table>

            <%
                    }
                } else
            %>
            <p>You don't have any order</p>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
        <%
            }
        %>
    </body>
</html>
