<%-- 
    Document   : personalPage
    Created on : Jan 25, 2022, 4:07:42 PM
    Author     : duyhu
--%>

<%@page import="duyhq.dto.Account" %>
<%@page import="duyhq.dao.AccountDAO" %>
<%@page import="duyhq.dto.Order" %>
<%@page import="java.util.ArrayList" %>
<%@page import="duyhq.dao.OrderDAO" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Personal page</title>
    </head>
    <body>
        <header>
            <%@include file="header_loginedUser.jsp" %>
        </header>
        <%
            String name = (String) session.getAttribute("name");
            String email = (String) session.getAttribute("email");

            Cookie[] c = request.getCookies();

            boolean login = false;

            Account acc = null;

            String token = "";

            if (c != null) {
                for (Cookie aCookie : c) {
                    if (aCookie.getName().equals("selector")) {
                        token = aCookie.getValue();
                        acc = AccountDAO.getAccountByToken(token);
                        if (acc != null) {
                            name = acc.getFullname();
                            email = acc.getEmail();
                            login = true;
                        }
                    }
                }
            }

            if (!login) {
        %>
        <p><font color="red">You must <a style="color: red; text-decoration: underline" href="login.jsp">login</a> to view
            personal page</font></p>

        <%
        } else {
        %>

        <section>
            <h3>Welcome <%= name%> come back</h3>
            <h3><a href="mainController?action=Logout">Logout</a></h3>
            <p><a href="personalPage.jsp">View all orders</a></p>
            <p><a href="personalPage.jsp?filter=completed">View completed orders</a></p>
            <p><a href="personalPage.jsp?filter=processing">View processing orders</a></p>
            <p><a href="personalPage.jsp?filter=canceled">View canceled orders</a></p>
        </section>

        <br/>
        <br/>
        <br/>

        <section>
            <h3>Your information</h3>
            <form action="accountServlet" method="POST">
                <input type="text" name="fullname" value="<%=acc.getFullname()%>"/>
                <input type="text" name="phone" value="<%=acc.getPhone()%>"/>
                <input type="hidden" name="email" value="<%=acc.getEmail()%>"/>
                <input type="hidden" name="password" value="<%=acc.getPassword()%>"/>

                <input type="submit" name="action" value="Save"/>
            </form>
        </section>

        <br/>
        <br/>
        <br/>

        <section>
            <h3>Your orders</h3>
            <!-- Orders -->
            <%
                ArrayList<Order> list = OrderDAO.getOrders(email);
                String[] status = {"", "processing", "completed", "canceled"};
                String filter = request.getParameter("filter");
                if (list != null && !list.isEmpty()) {
                    for (Order ord : list) {
                        if (filter == null || filter.equals(status[ord.getStatus()])) {
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
                    <td><%= ord.getOrderID()%>
                    </td>
                    <td><%= ord.getOrderDate()%>
                    </td>
                    <td><%= ord.getShipDate()%>
                    </td>
                    <td>
                        <%= status[ord.getStatus()]%>
                        <br/>
                        <% if (ord.getStatus() == 1) {%><a
                            href="orderServlet?action=updateOrder&orderId=<%= ord.getOrderID()%>&newStatus=3">Cancel
                            order</a><%}%>
                        <% if (ord.getStatus() == 3) {%><a
                            href="orderServlet?action=updateOrder&orderId=<%= ord.getOrderID()%>&newStatus=1">Order
                            again</a><%}%>
                    </td>
                    <td>
                        <a href="orderDetail.jsp?orderid=<%= ord.getOrderID()%>">Detail</a>
                    </td>
                </tr>
            </table>

            <%
                    }
                }
            } else {
            %>
            <p>You don't have any order</p>
            <% } %>
        </section>

        <%
            }
        %>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
