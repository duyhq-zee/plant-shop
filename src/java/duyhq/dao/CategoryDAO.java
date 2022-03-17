/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package duyhq.dao;

import duyhq.dto.Category;
import duyhq.utils.DBUtils;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author duyhu
 */
public class CategoryDAO {

    public static ArrayList<Category> getCategories() {
        Connection cn = null;
        ArrayList<Category> categories = new ArrayList<Category>();
        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {

                String sql = "SELECT CateID, CateName FROM Categories";

                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);

                if (rs != null) {
                    while (rs.next()) {
                        int cateID = rs.getInt("CateID");
                        String cateName = rs.getString("CateName");

                        Category newCate = new Category(cateID, cateName);

                        categories.add(newCate);
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

        return categories;
    }
}
