/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package duyhq.dto;

import duyhq.dao.OrderDAO;
import java.util.ArrayList;

/**
 *
 * @author duyhu
 */
public class Test {

    public static void main(String[] args) {
//        Account acc = AccountDAO.getAccount("test@gmail.com", "test");
//        if (acc != null) {
//            if (acc.getRole() == 1)
//                System.out.println("Admin");
//            else
//                System.out.println("User");
//        } else
//            System.out.println("Login fail");

//        AccountDAO.updateAccountStatus("test@gmail.com", 1);
//        System.out.println(AccountDAO.updateAccount("test@gmail.com", "newPassword", "newFullname", "123456789"));
//        System.out.println(AccountDAO.insertAccount("c@gmail.com", "newPassword", "newFullname", "123456789", 1, 0));
//        ArrayList<Account> accounts = AccountDAO.getAccounts();
//        for (Account account: accounts) {
//            System.out.println(account.getEmail() + " " + account.getFullname() + " " + account.getPassword() + " " + account.getPhone());
//        }
//        ArrayList<Plant> plants = PlantDAO.getPlants("monstera", "byname");
//        for (Plant plant : plants) {
//            System.out.println(plant.getName());
//        }
        ArrayList<OrderDetail> list = OrderDAO.getOrderDetails(1);
        for (OrderDetail o : list) {
            System.out.println(o.getPlantName());
        }
    }
}
