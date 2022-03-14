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
        <link rel="stylesheet" href="header_loginedUser.css" type="text/css" />
    </head>
    <body>
        <header class="header">
            <nav>
                <ul class="navbar">
                    <li><a href="index.jsp"><img class="logo" src="images/logo.png"></a> </li>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="viewCart.jsp">Cart</a></li>
                    <li><a href="personalPage.jsp">Profile</a></li>
                    <!--<li><a href="">Change profile</a></li>-->
                    <!--<li><a href="">Completed orders</a></li>
                    <li><a href="">Canceled orders</a></li>
                    <li><a href="">Processing orders</a></li>-->
                    <li></li>
                    <li>
                        From <input type="date" name="from"/> to <input type="date" name="to"/>
                        <input type="submit" value="Search"/>
                    </li>
                </ul>
            </nav>
        </header>
    </body>
</html>
