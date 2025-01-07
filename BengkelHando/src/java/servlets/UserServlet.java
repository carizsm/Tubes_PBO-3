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
import model.User;

@WebServlet(name = "UserServlet", urlPatterns = {"/user"})
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("/index.jsp");
            return;
        }

        String menu = request.getParameter("menu");
        if (menu == null || menu.isEmpty()) {
            response.sendRedirect("/user?menu=view");
            return;
        }
        
        switch (menu) {
            case "view" -> {
                if (user == null) {
                    request.setAttribute("error", "Data pengguna tidak tersedia.");
                } else {
                    request.setAttribute("user", user);
                }
                request.getRequestDispatcher("/userSettings.jsp").forward(request, response); 
            }
            default -> response.sendRedirect("user?menu=view");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String action = request.getParameter("action");

        if (null != action) {
            if (action.equals("edit")) {
                
                if (user != null) {
                    user.setFullName(request.getParameter("full_name"));
                    user.setEmail(request.getParameter("email"));
                    user.setPhoneNumber(request.getParameter("phone_number"));
                    user.update();
                }
            }
        }
        response.sendRedirect(request.getContextPath() + "/user?menu=view");
    }
}
