/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import model.User;

@WebServlet(name = "AuthServlet", urlPatterns = {"/AuthServlet"})
public class AuthServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "login" -> {
                System.out.println("##Passed##");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                System.out.println("##Passed 2##");
                User userModel = new User();
                userModel.where("username = '" + username + "' AND password = '" + password + "'");
                ArrayList<User> users = userModel.get();

                if (!users.isEmpty()) {
                    User user = users.get(0);

                    HttpSession session = request.getSession();
                    System.out.println("##Passed 3##");
                    if ("ADMIN".equals(user.getRole())) {
                        session.setAttribute("admin", user);
                        response.sendRedirect(request.getContextPath() + "/admin?menu=view.jsp");
                    } else {
                        session.setAttribute("user", user);
                        System.out.println("##Passed User##");
                        response.sendRedirect(request.getContextPath() + "/booking?menu=view.jsp");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/login.jsp?error=1");
                }
                System.out.println("##Passed OUT##");
            }
            case "logout" -> {
                System.out.println("##Passed LOGOUT##");
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                System.out.println("##Passed LOGOUT 2##");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                System.out.println("##Passed LOGOUT OUT##");
            }
        }
        
    }
}
