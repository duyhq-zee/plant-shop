<%-- 
    Document   : productDetail
    Created on : Mar 15, 2022, 9:12:06 PM
    Author     : duyhu
--%>

<%@page import="duyhq.dao.AccountDAO"%>
<%@page import="duyhq.dto.Account"%>
<%@page import="duyhq.dto.Plant"%>
<%@page import="duyhq.dao.PlantDAO"%>
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
        
        
        <jsp:useBean id="plantObj" class="duyhq.dto.Plant" scope="request"/>
        <table width="100%" class="shopping">
            <tr>
                <td></td>
                <td>Product id</td>
                <td>Product name</td>
                <td>Unit price</td>
                <td>Description</td>
                <td>Status</td>
                <td>Category Id</td>
                <td>Category name</td>
            </tr>
            <tr>
                <td><img src="${plantObj.imgpath}" width="100px"/></td>            
                <td><p>${plantObj.id}</p></td>
                <td><p>${plantObj.name}</p></td>
                <td><p>${plantObj.price}</p></td>
                <td><p>${plantObj.description}</p></td>
                <td><p>${plantObj.status}</p></td>
                <td><p>${plantObj.cateid}</p></td>
                <td><p>${plantObj.catename}</p></td>
            </tr>        
        </table>
        <%@include file="footer.jsp" %>
    </body>
</html>
