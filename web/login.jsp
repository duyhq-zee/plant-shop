<%-- 
    Document   : login
    Created on : Jan 25, 2022, 2:31:43 PM
    Author     : duyhu
--%>

<%@page import="duyhq.dto.Account"%>
<%@page import="duyhq.dao.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
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

            if (login) {
                response.sendRedirect("personalPage.jsp");
            }
        %>
        
        <%@include file="header.jsp" %>
        
        <section>
            <form action="mainController" method="post" class="formlogin">
                <font style="color: red;"><%= (request.getAttribute("WARNING") == null) ? "" : (String)request.getAttribute("WARNING")%></font>
                <table>
                    <tr>
                        <td>Email: </td>
                        <td><input type="text" name="txtemail"/></td>
                    </tr>
                    <tr>
                        <td>Password: </td>
                        <td><input type="password" name="txtpassword"/></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="checkbox" value="savelogin" name="savelogin"/>Stay signed in</td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="Login" name="action"/></td>
                    </tr>
                </table>
            </form>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
