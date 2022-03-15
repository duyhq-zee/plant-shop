<%-- 
    Document   : registration
    Created on : Jan 25, 2022, 2:57:11 PM
    Author     : duyhu
--%>

<%@page import="duyhq.dto.Account"%>
<%@page import="duyhq.dao.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
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
            <form class="form" action="mainController" method="post">
                <h1>Register</h1>
                <table>
                    <tr>
                        <td>Email: </td>
                        <td><input type="text" name="txtemail" required="" pattern="^(\\w)+@(a-zA-Z)+([.](\\w)+){1,2}"/></td>
                    </tr>
                    <tr>
                        <td>Full name: </td>
                        <td><input type="text" name="txtfullname" required=""/></td>
                    </tr>
                    <tr>
                        <td>Password: </td>
                        <td><input type="password" name="txtpassword" required=""/></td>
                    </tr>
                    <tr>
                        <td>Phone: </td>
                        <td><input type="text" name="txtphone"/></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="Register" name="action"/></td>
                    </tr>
                </table>
            </form>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
