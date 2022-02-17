<%-- 
    Document   : OrderDetail
    Created on : Feb 17, 2022, 4:40:01 PM
    Author     : duyhu
--%>

<%@page import="duyhq.dto.OrderDetail"%>
<%@page import="java.util.ArrayList"%>
<%@page import="duyhq.dao.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <header>
            <%@include file="header_loginedUser.jsp" %>
        </header>
        <section>
            <h3>Logout</h3>
            <a href="personalPage.jsp">View all orders</a>
        </section>
        <section>
            <%
                String orderid = request.getParameter("orderid");
                if (orderid != null) {
                    int orderID = Integer.parseInt(orderid.trim());
                    ArrayList<OrderDetail> list = OrderDAO.getOrderDetails(orderID);
                    if (list != null && !list.isEmpty()) {
                        int money = 0;
                        for (OrderDetail detail: list) {
            %>
                            
                            <table class="order">
                                <tr>
                                    <td>Order ID</td>
                                    <td>Plant ID</td>
                                    <td>Plant name</td>
                                    <td>Image</td>
                                    <td>Quantity</td>
                                </tr>
                                <tr>
                                    <td><%= detail.getOrderID() %></td>
                                    <td><%= detail.getPlantID() %></td>
                                    <td><%= detail.getPlantName() %></td>
                                    <td>
                                        <img src="<%= detail.getImgPath()%>" class="plantimg" />
                                        <br />
                                        <%= detail.getPrice()%>
                                    </td>
                                    <td><%= detail.getQuantity() %></td>
                                    <% money = money + detail.getPrice() * detail.getQuantity(); %>
                                </tr>
                            </table>
                            
                        <%
                        }
                        %>
                        <h3>Total money: <%= money %></h3>
                    <%
                    } else {
                    %>
                        <p>You don't have any orders.</p>
            <%
                    }
                }
            %>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
