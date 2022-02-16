<%-- 
    Document   : header_loginedUser
    Created on : Jan 25, 2022, 4:08:13 PM
    Author     : duyhu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="mycss.css" type="text/css" />
    </head>
    <body>
        <nav>
            <li><a href="index.jsp"></a>Home</li>
            <li><a href="">Change profile</a></li>
            <li><a href="">Completed orders</a></li>
            <li><a href="">Canceled orders</a></li>
            <li><a href="">Processing orders</a></li>
            <li>
                From <input type="date" name="from"/> to <input type="date" name="to"/>
                <input type="submit" value="Search"/>
            </li>
        </nav>
    </body>
</html>
