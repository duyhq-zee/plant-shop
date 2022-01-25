<%-- 
    Document   : login
    Created on : Jan 25, 2022, 2:31:43 PM
    Author     : duyhu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <header>
            <%@include file="header.jsp" %>
        </header>
        <section>
            <form action="mainController" method="post" class="formlogin">
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
