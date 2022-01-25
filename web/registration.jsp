<%-- 
    Document   : registration
    Created on : Jan 25, 2022, 2:57:11 PM
    Author     : duyhu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
    </head>
    <body>
        <header>
            <%@include file="header.jsp" %>
        </header>
        <section>
            <form class="form" action="mainController" method="post">
                <h1>Register</h1>
                <table>
                    <tr>
                        <td>Email: </td>
                        <td><input type="text" name="txtemail" required=""/></td>
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
