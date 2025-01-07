/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Booking;
import model.User;

@WebServlet(name = "AdminServlet", urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("admin");
        if (user == null || !user.getRole().equals("ADMIN")) { 
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String menu = request.getParameter("menu");
        if (menu == null || menu.isEmpty()) {
            response.sendRedirect("/admin?menu=view");
            return;
        }
        
        switch (menu) {
            case "view" -> {
                if (user == null) {
                    request.setAttribute("error", "Data pengguna tidak tersedia.");
                } else {
                    request.setAttribute("admin", user);
                }
                Booking bookingModel = new Booking();
                List<Booking> bookings = bookingModel.getAll();
                request.setAttribute("bookings", bookings);
                request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
            }
            case "userList" -> {
                User userModel = new User();
                List<User> customers = userModel.where("role", "CUSTOMER").get();
                
                if (customers == null || customers.isEmpty()) {
                    
                } else {
                    request.setAttribute("customers", customers);
                }
                request.getRequestDispatcher("/adminUserList.jsp").forward(request, response);
            }
            default -> response.sendRedirect("admin?menu=view");
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("admin");
        if (user == null || !user.getRole().equals("ADMIN")) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            String bookingId = request.getParameter("booking_id");
            String newStatus = request.getParameter("status");

            Booking bookingModel = new Booking();
            Booking booking = bookingModel.find(bookingId);

            if (booking != null) {
                booking.setStatus(newStatus);
                booking.update();
            }
            response.sendRedirect(request.getContextPath() + "/admin?menu=view");
        } else if ("deleteUser".equals(action)) {
            String id = request.getParameter("id");
            if (user != null) {
                user.setId(Integer.parseInt(id));
                user.delete();
            }
            response.sendRedirect(request.getContextPath() + "/admin?menu=userList");
        }
    }
}
