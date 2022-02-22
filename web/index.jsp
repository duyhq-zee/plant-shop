<%-- 
    Document   : index
    Created on : Jan 25, 2022, 2:29:44 PM
    Author     : duyhu
--%>

<%@page import="duyhq.dao.PlantDAO"%>
<%@page import="duyhq.dto.Plant"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome</title>
    </head>
    <body>
        <%@include file="header.jsp" %>
        
        <%
            String keyword = request.getParameter("txtsearch");
            String searchby = request.getParameter("searchby");
            
            ArrayList<Plant> list;
            String[] tmp = {"out of stock", "available"};
            
            if (keyword == null && searchby == null) {
                list = PlantDAO.getPlants("", "");
            } else {
                list = PlantDAO.getPlants(keyword, searchby);
            }
            
            if (list != null || !list.isEmpty()) {
                for (Plant p: list) {
                    %>
                    
                    <table class="product">
                        <tr>
                            <td><img src="<%= p.getImgpath()%>" class="plantimg" /></td>
                            <td>Product ID: <%= p.getId() %></td>
                            <td>Product name: <%= p.getName() %></td>
                            <td>Price: <%= p.getPrice() %></td>
                            <td>Status: <%= p.getStatus() %></td>
                            <td>Category: <%= p.getCatename() %></td>
                            <td><a href="">Add to cart</a></td>
                        </tr>
                    </table>
                    
                    <%
                }
            }
        %>
        
        <div class="clear"></div>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
