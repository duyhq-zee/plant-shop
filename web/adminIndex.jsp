<%-- 
    Document   : adminIndex
    Created on : Mar 16, 2022, 1:54:49 PM
    Author     : duyhu
--%>

<%@page import="duyhq.dao.AccountDAO"%>
<%@page import="duyhq.dto.Account"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Homepage</title>
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
            
            if (!login || acc.getRole() != 1) {
                response.sendRedirect("index.jsp");
            }
        %>
        <c:import url="header_loginedAdmin.jsp"></c:import>
        
        <h3>Welcome ${sessionScope.name}</h3>
        <section class="right">
            <!--<img src="images/background.jpg"/>-->
        </section>
    </body>
</html>
