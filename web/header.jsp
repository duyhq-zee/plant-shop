<%-- 
    Document   : header
    Created on : Jan 25, 2022, 2:25:10 PM
    Author     : duyhu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="mycss.css" type="text/css" />
        <link rel="stylesheet" href="header.css" type="text/css" />
    </head>
    <body>
        <header class="header">
            <nav>
                <ul class="navbar">
                    <li><a href="index.jsp"><img class="logo" src="images/logo.png"></a> </li>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="registration.jsp">Register</a></li>
                    <li><a href="login.jsp" >Login</a></li>
                    <li class="search-form">
                        <form action="mainController" method="post" class="formsearch">
                            <input type="text" name="txtsearch" value="<%= request.getParameter("txtsearch") == null ? "" : request.getParameter("txtsearch") %>">
                            <select name="searchby"> <option value="byname">by name</option><option value="bycate">by category</option> </select>
                            <input class="button" type="submit" value="Search" name="action" >
                        </form>
                    </li>
                </ul>
            </nav>
        </header>
    </body>
</html>
