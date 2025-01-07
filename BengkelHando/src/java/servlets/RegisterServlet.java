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
import model.User;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet { 
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = new User();
        user.setUsername(request.getParameter("username"));
        user.setPassword(request.getParameter("password"));
        user.setFullName(request.getParameter("full_name"));
        user.setEmail(request.getParameter("email"));
        user.setPhoneNumber(request.getParameter("phone_number"));
        user.setRole("CUSTOMER");
        user.insert();

        if (user.getMessage().equals("info insert: 1 rows affected")) {
            response.sendRedirect("login.jsp");
        } else {
            response.getWriter().println("Registration failed: " + user.getMessage());
        }
    }
}