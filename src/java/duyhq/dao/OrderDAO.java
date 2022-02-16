/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package duyhq.dao;

import duyhq.dto.Account;
import duyhq.dto.Order;
import duyhq.utils.DBUtils;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author duyhu
 */
public class OrderDAO {
    public static ArrayList<Order> getOrders(String email) {
        Connection cn = null;
        ArrayList<Order> orders = new ArrayList<Order>();
        try {
            cn = DBUtils.makeConnection();
            
            if (cn != null) {
                Account acc = AccountDAO.getAccountByEmail(email);
                int accID = acc.getAccId();
                
                String sql = "SELECT orderID, ordDate, shipDate, status, accID FROM Orders WHERE accID = " + accID;
                
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);
                
                if (rs != null) {
                    while (rs.next()) {
                        int orderID = rs.getInt("orderID");
                        String orderDate = rs.getString("ordDate");
                        String shipDate = rs.getString("shipDate");
                        int status = rs.getInt("status");
                        
                        Order newOrder = new Order(orderID, orderDate, shipDate, status, accID);
                        
                        orders.add(newOrder);
                    }
                }
            }
        } catch (Exception e) {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e1) {
                    e1.printStackTrace();
                }
            }
        }
        
        return orders;
    }
    
//    public static ArrayList<Order> getOrderDetails() {
//        Connection cn = null;
//        ArrayList<OrderDetail> orderDetails = new ArrayList<OrderDetail>();
//        
//        
//        return orderDetails;
//    }
    
    
}
