<%-- 
    Document   : header_loginedAdmin
    Created on : Mar 16, 2022, 4:57:25 PM
    Author     : duyhu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="mycss.css" type="text/css" />
        <link rel="stylesheet" href="header_loginedAdmin.css" type="text/css" />
    </head>
    <body>
        <header class="header">
            <nav>
                <ul class="navbar">
                    <li><a href="adminIndex.jsp"><img class="logo" src="images/logo.png"></a> </li>
                    <li><a href="adminIndex.jsp">Home</a></li>
                    <li><a href="manageAccounts.jsp">Accounts</a></li>
                    <li><a href="manageOrders.jsp">Orders</a></li>
                    <li><a href="managePlants.jsp">Plants</a></li>
                    <li><a href="manageCategories.jsp">Categories</a></li>
                    <li><a href="mainController?action=Logout">Logout</a></li>
                </ul>
            </nav>
        </header>
    </body>
</html>
