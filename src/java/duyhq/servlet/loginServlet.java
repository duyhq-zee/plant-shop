/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package duyhq.servlet;

import duyhq.dao.AccountDAO;
import duyhq.dto.Account;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author duyhu
 */
public class loginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String email = request.getParameter("txtemail");
            String password = request.getParameter("txtpassword");
            String save = request.getParameter("savelogin");
            Account acc = null;

            try {
                if (email == null || email.equals("") || password == null || password.equals("")) {
                    Cookie[] c = request.getCookies();
                    String token = "";

                    if (c != null) {
                        for (Cookie aCookie : c) {
                            if (aCookie.getName().equals("selector")) {
                                token = aCookie.getValue();
                            }
                        }
                    }

                    if (!token.equals("")) {
                        response.sendRedirect("personalPage.jsp");
                    }
                    response.sendRedirect("errorpage.html");
                } else {
                    acc = AccountDAO.getAccount(email, password);

                    if (acc == null) {
                        response.sendRedirect("error.html");
                        return;
                    }

                    if (acc.getRole() == 1) {
                        // Redirect to admin page
                    } else {
                        // Redirect to welcome page
//                    response.sendRedirect("welcome.html");

                        HttpSession session = request.getSession(true);
                        if (session != null) {
                            session.setAttribute("name", acc.getFullname());
                            session.setAttribute("email", email);

                            if (save != null) {
                                // Generate random string
                                int leftLimit = 97; // letter 'a'
                                int rightLimit = 122; // letter 'z'
                                int targetStringLength = 10;
                                Random random = new Random();
                                StringBuilder buffer = new StringBuilder(targetStringLength);
                                for (int i = 0; i < targetStringLength; i++) {
                                    int randomLimitedInt = leftLimit + (int) (random.nextFloat() * (rightLimit - leftLimit + 1));
                                    buffer.append((char) randomLimitedInt);
                                }
                                String generatedString = buffer.toString();

                                String token = generatedString;
                                AccountDAO.updateToken(token, email);
                                Cookie cookie = new Cookie("selector", token);
                                cookie.setMaxAge(60 * 2);
                                response.addCookie(cookie);
                            }
                            response.sendRedirect("personalPage.jsp");
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
