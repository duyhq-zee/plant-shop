/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dto;

import duyhq.dao.AccountDAO;
import duyhq.dto.Account;

/**
 *
 * @author duyhu
 */
public class Test {
    public static void main(String[] args) {
        Account acc = AccountDAO.getAccount("test@gmail.com", "test");
        if (acc != null) {
            if (acc.getRole() == 1)
                System.out.println("Admin");
            else
                System.out.println("User");
        } else
            System.out.println("Login fail");
    }
}
