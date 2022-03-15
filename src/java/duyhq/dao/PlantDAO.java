/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package duyhq.dao;

import duyhq.dto.Plant;
import duyhq.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author duyhu
 */
public class PlantDAO {

    public static ArrayList<Plant> getPlants(String keyword, String searchBy) {
        ArrayList<Plant> list = new ArrayList<Plant>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();

            if (cn != null && searchBy != null) {
                String sql = "SELECT PID, PName, price, imgPath, [description], [status], Plants.CateID AS CateID, CateName FROM Plants JOIN Categories on Plants.CateID = Categories.CateID";

                if (searchBy.equalsIgnoreCase("byname")) {
                    sql += " WHERE PName LIKE ?";
                } else {
                    sql += " WHERE CateName LIKE ?";
                }

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
                ResultSet rs = pst.executeQuery();

                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("PID");
                        String name = rs.getString("PName");
                        int price = rs.getInt("price");
                        String imgpath = rs.getString("imgPath");
                        String description = rs.getString("description");
                        int status = rs.getInt("status");
                        int cateid = rs.getInt("CateID");
                        String catename = rs.getString("CateName");
                        Plant plant = new Plant(id, name, price, imgpath, description, status, cateid, catename);
                        list.add(plant);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static Plant getPlant(String PID) {
        ArrayList<Plant> list = new ArrayList<Plant>();
        Connection cn = null;
        Plant plant = null;

        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "SELECT PID, PName, price, imgPath, [description], [status], Plants.CateID AS CateID, CateName FROM Plants JOIN Categories on Plants.CateID = Categories.CateID WHERE PID = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, PID);
                ResultSet rs = pst.executeQuery();

                if (rs != null && rs.next()) {
                    int id = rs.getInt("PID");
                    String name = rs.getString("PName");
                    int price = rs.getInt("price");
                    String imgpath = rs.getString("imgPath");
                    String description = rs.getString("description");
                    int status = rs.getInt("status");
                    int cateid = rs.getInt("CateID");
                    String catename = rs.getString("CateName");
                    plant = new Plant(id, name, price, imgpath, description, status, cateid, catename);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return plant;
    }
}
