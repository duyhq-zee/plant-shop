<%-- 
    Document   : viewCart
    Created on : Mar 13, 2022, 9:58:44 PM
    Author     : duyhu
--%>

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
        <table width="100%" class="shopping">
            <tr>
                <td>Product id</td>
                <td>Quantity</td>
                <td>Action</td>
            </tr>
            <%
            HashMap<String, Integer> cart = (HashMap) session.getAttribute("cart");
            if (cart != null) {
                Set<String> pids = cart.keySet();
                for (String pid: pids) {
                    int quantity = cart.get(pid);
            %>
            <form action="mainController" method="POST">
                <tr>
                    <td><input type="hidden" value="<%= pid %>" name="pid"/><a href="#"><%= pid %></a></td>
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
            <tr><td>Total money</td></tr>
        </table>
    </body>
</html>
