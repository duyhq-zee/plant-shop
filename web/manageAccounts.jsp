<%-- 
    Document   : manageAccount
    Created on : Mar 16, 2022, 5:46:26 PM
    Author     : duyhu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="duyhq.dto.Account"%>
<%@page import="duyhq.dao.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Accounts</title>
    </head>
    <body>
        <%
            ArrayList<Account> list = AccountDAO.getAccounts();
            String keyword = request.getParameter("txtSearch");
        %>
        
        <%@include file="header_loginedAdmin.jsp" %>
        <form action="manageAccounts.jsp" method="POST">
            <input type="text" name="txtSearch" />
            <input type="submit" value="searchAccount" name="action" />
        </form>
        <h1></h1>
        <table class="order">
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Full name</th>
                <th>Status</th>
                <th>Phone</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
            <%
                
                for (Account acc: list) {
                    if (keyword == null || acc.getFullname() == null || acc.getFullname().contains(keyword)) {
            %>
            
            <tr>
                <td><%= acc.getAccId()%></td>
                <td><%= acc.getEmail()%></td>
                <td><%= acc.getFullname()%></td>
                <td><%= (acc.getStatus() == 1) ? "Active" : "Inactive" %></td>
                <td><%= acc.getPhone()%></td>
                <td><%= (acc.getRole() == 1) ? "Admin" : "User" %></td>
                <td><% if (acc.getRole() == 0) { %>
                    <form action="mainController" method="POST">
                        <input type="hidden" name="email" value="<%= acc.getEmail() %>"/>
                        <input type="hidden" name="status" value="<%= acc.getStatus() %>"/>
                        <button type="submit" name="action" value="updateAccountStatus"><%= (acc.getStatus() == 1) ? "Block" : "Unblock" %></button>
                    </form>
                    <% } %>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>
        <%@include file="footer.jsp" %>
    </body>
</html>
