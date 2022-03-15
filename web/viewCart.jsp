<%-- 
    Document   : viewCart
    Created on : Mar 13, 2022, 9:58:44 PM
    Author     : duyhu
--%>

<%@page import="duyhq.dto.Plant"%>
<%@page import="duyhq.dao.PlantDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="duyhq.dto.Account"%>
<%@page import="duyhq.dao.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% 
            String name = (String) session.getAttribute("name");
            String email = (String) session.getAttribute("email");

            Cookie[] c = request.getCookies();

            boolean login = false;

            Account acc = null;

            String token = "";

            if (name == null) {
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
            } else {
                acc = AccountDAO.getAccountByEmail(email);
                login = true;
            }

            if (!login) {
        %>
            <%@include file="header.jsp" %>
        <% } else {%>
            <%@include file="header_loginedUser.jsp" %>
        <% } %>
        
        <h3>Welcome <%= name %></h3>
        
        <font style="color: red;"><%= (request.getAttribute("WARNING") == null) ? "" : (String)request.getAttribute("WARNING")%></font>
        
        <table width="100%" class="shopping">
            <tr>
                <td></td>
                <td>Product id</td>
                <td>Product name</td>
                <td>Unit price</td>
                <td>Quantity</td>
                <td>Action</td>
            </tr>
            <%
            HashMap<String, Integer> cart = (HashMap) session.getAttribute("cart");
            int totalMoney = 0;
            if (cart != null) {
                Set<String> pids = cart.keySet();
                for (String pid: pids) {
                    int quantity = cart.get(pid);
                    Plant p = PlantDAO.getPlant(pid);
                    totalMoney += p.getPrice() * quantity;
            %>
            <form action="mainController" method="POST">
                <tr>
                    <td><img src="<%= p.getImgpath() %>" width="100px"/></td>
                    <td><input type="hidden" value="<%= pid %>" name="pid"/><a href="productDetail.jsp?pid=<%= pid %>"><%= pid %></a></td>
                    <td><a><%= p.getName() %></a></td>
                    <td><p><%= p.getPrice() %></p></td>
                    <td><input type="number" value="<%= quantity %>" name="quantity"/></td>
                    <td><button type="submit" name="action" value="updatecart">Update</button>
                        <button type="submit" name="action" value="deletefromcart">Delete</button></td>
                </tr>
            </form>
            
            <%
                }
            } else {
            %>
            <tr><td>Your cart is empty</td></tr>
            <% } %>
            <tr><td>Total money: <%= totalMoney %></td></tr>
            <tr><td>Order date: <%= (new Date()).toString() %></td></tr>
            <tr><td>Ship date: N/A</td></tr>
        </table>
        <section>
            <form action="mainController" method="POST">
                <button type="submit" value="saveOrder" name="action" class="submitOrder">Order</button>
            </form>
        </section>
        <%@include file="footer.jsp" %>
    </body>
</html>
