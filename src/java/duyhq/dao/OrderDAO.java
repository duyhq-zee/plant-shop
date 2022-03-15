/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package duyhq.dao;

import duyhq.dto.Account;
import duyhq.dto.Order;
import duyhq.dto.OrderDetail;
import duyhq.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.sql.Date;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Set;

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

    public static ArrayList<OrderDetail> getOrderDetails(int orderID) {
        Connection cn = null;
        ArrayList<OrderDetail> list = new ArrayList<OrderDetail>();

        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "SELECT [DetailId], [OrderID], PID, PName, price, imgPath, quantity FROM OrderDetails, Plants WHERE OrderID=? AND OrderDetails.FID = Plants.PID;";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, orderID);
                ResultSet rs = pst.executeQuery();

                if (rs != null) {
                    while (rs.next()) {
                        int detailID = rs.getInt("DetailID");
                        int PlantID = rs.getInt("PID");
                        String PlanName = rs.getString("PName");
                        int price = rs.getInt("price");
                        String imgPath = rs.getString("imgPath");
                        int quantity = rs.getInt("quantity");

                        OrderDetail orderdetail = new OrderDetail(detailID, orderID, PlantID, PlanName, price, imgPath, quantity);
                        list.add(orderdetail);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return list;
    }

    public static boolean updateOrderStatus(int orderId, int value) {
        Connection cn = null;

        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "UPDATE Orders SET [status] = ? WHERE OrderID = ?;";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, value);
                pst.setInt(2, orderId);
                pst.execute();
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            return true;
        }
    }

    public static boolean insertOrder(String email, HashMap<String, Integer> cart) {
        Connection cn = null;
        boolean result = false;
        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                int accId = 0, orderId = 0;
                cn.setAutoCommit(false);

                // get accountId by email
                String sql = "SELECT accID from Accounts WHERE Accounts.email = ?;";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();

                if (rs != null && rs.next()) {
                    accId = rs.getInt("accID");
                }

                // Insert a new Order
                Date d = new Date(System.currentTimeMillis());
                sql = "INSERT Orders(OrdDate, status, accID) VALUES (?, ?, ?);";
                pst = cn.prepareStatement(sql);
                pst.setDate(1, d);
                pst.setInt(2, 1);
                pst.setInt(3, accId);

                pst.executeUpdate();

                // get orderId that is the largest number
                sql = "SELECT TOP 1 orderId FROM Orders ORDER BY orderId DESC";
                pst = cn.prepareStatement(sql);
                rs = pst.executeQuery();

                if (rs != null && rs.next()) {
                    orderId = rs.getInt("orderID");
                }

                // Insert OrderDetail
                Set<String> pids = cart.keySet();
                for (String pid : pids) {
                    sql = "INSERT OrderDetails VALUES (?, ?, ?);";
                    pst = cn.prepareStatement(sql);
                    pst.setInt(1, orderId);
                    pst.setInt(2, Integer.parseInt(pid.trim()));
                    pst.setInt(3, cart.get(pid));
                    pst.executeUpdate();
                }

                cn.commit();
                cn.setAutoCommit(true);

                return true;
            }
        } catch (Exception e) {
            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

            e.printStackTrace();
            return false;
        } finally {
            try {
                cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return result;
    }

}
