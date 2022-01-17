/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package duyhq.dao;

import duyhq.dto.Account;
import duyhq.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author duyhu
 */
public class AccountDAO {
    public static ArrayList<Account> getAccounts() {
        Connection cn = null;
        ArrayList<Account> accounts = new ArrayList<Account>();
        try {
            cn = DBUtils.makeConnection();
            
            if (cn != null) {
                String sql = "SELECT accId, email, password, fullname, phone, status, role FROM Accounts";
                
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);
                
                if (rs != null) {
                    while (rs.next()) {
                        int accId = rs.getInt("accId");
                        String email = rs.getString("email");
                        String password = rs.getString("password");
                        String fullname = rs.getString("fullname");
                        String phone = rs.getString("phone");
                        int status = rs.getInt("status");
                        int role = rs.getInt("role");
                        Account acc = new Account(accId, email, password, fullname, status, phone, role);
                        
                        accounts.add(acc);
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
        
        return accounts;
    }
    
    public static Account getAccount(String email, String password) {
        Connection cn = null;
        Account acc = null;
        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "SELECT accId, email, password, fullname, phone, status, role FROM Accounts WHERE status = 1 AND email = ? AND password = ? COLLATE Latin1_General_CS_AS";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                pst.setString(2, password);
                ResultSet rs = pst.executeQuery();

                if (rs != null && rs.next()){
                    int accId = rs.getInt("accId");
                    String fullname = rs.getString("fullname");
                    String phone = rs.getString("phone");
                    int status = rs.getInt("status");
                    int role = rs.getInt("role");
                    acc = new Account(accId, email, password, fullname, status, phone, role);
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return acc;
    }
    
    public static boolean updateAccountStatus(String email, int status) {
        Connection cn = null;
        int result = 0;
        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "UPDATE Accounts SET [status] = ? WHERE email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, status);
                pst.setString(2, email);
                result = pst.executeUpdate();
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        
        return result > 0;
    }
    
    public static boolean updateAccount(String email, String newPassword, String newFullname, String newPhone){
        Connection cn = null;
        int result = 0;
        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "UPDATE Accounts SET password = ?, fullname = ?, phone = ? WHERE email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, newPassword);
                pst.setString(2, newFullname);
                pst.setString(3, newPhone);
                pst.setString(4, email);
                result = pst.executeUpdate();
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        
        return result > 0;
    }
    
    public static boolean insertAccount(String newEmail, String newPassword, String newFullname, String newPhone, int newStatus,int newRole) {
        Connection cn = null;
        int result = 0;
        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "INSERT INTO Accounts (email, [password], fullname, phone, [status], [role]) VALUES (?, ?, ?, ?, ?, ?);";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, newEmail);
                pst.setString(2, newPassword);
                pst.setString(3, newFullname);
                pst.setString(4, newPhone);
                pst.setInt(5, newStatus);
                pst.setInt(6, newRole);
                
                result = pst.executeUpdate();
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        
        return result > 0;
    }

    
}
