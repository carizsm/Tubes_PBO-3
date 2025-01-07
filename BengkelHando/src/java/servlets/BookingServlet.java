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
import java.util.Collections;
import model.Booking;
import model.User;

@WebServlet(name = "BookingServlet", urlPatterns = {"/booking"})
public class BookingServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String menu = request.getParameter("menu");
        if (menu == null || menu.isEmpty()) {
            response.sendRedirect("/booking?menu=view");
            return;
        }

        Booking bookingModel = new Booking();

        switch (menu) {
            case "view" -> {
                int userId = ((User) session.getAttribute("user")).getId();
                // Booking Data with "Pending" status
                ArrayList<Booking> pendingBookings = bookingModel.where("user_id", userId)
                                                                 .where("status", "Pending")
                                                                 .get();
                // Booking Data with "Confirmed" status
                ArrayList<Booking> confirmedBookings = bookingModel.where("user_id", userId)
                                                                   .where("status", "Confirmed")
                                                                   .get();
                pendingBookings.addAll(confirmedBookings);

                Collections.sort(pendingBookings, (Booking b1, Booking b2) -> Integer.compare(b1.getId(), b2.getId()));
                request.setAttribute("bookings", pendingBookings);
                request.getRequestDispatcher("/userDashboard.jsp").forward(request, response);
            }
            case "add" -> request.getRequestDispatcher("/serviceBooking.jsp").forward(request, response);
            case "edit" -> {
                String id = request.getParameter("id");
                Booking booking = bookingModel.find(id);

                if (booking != null && booking.getUserId() == user.getId()) {
                    request.setAttribute("booking", booking);
                    request.getRequestDispatcher("/editBooking.jsp").forward(request, response);
                } else {
                    response.sendRedirect("booking?menu=view");
                }
            }
            case "history" -> {
                int userId = ((User) session.getAttribute("user")).getId();
                ArrayList<Booking> bookings = bookingModel.where("user_id", userId).where("status", "Completed").get(); // Gunakan method where yang baru
                request.setAttribute("bookings", bookings);
                request.getRequestDispatcher("/serviceBookingHistory.jsp").forward(request, response);
            }
            
            default -> response.sendRedirect("booking?menu=view");
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
        Booking bookingModel = new Booking();

        if (null != action) switch (action) {
            case "add" -> {
                bookingModel.setUserId(user.getId());
                bookingModel.setVehicleNumber(request.getParameter("vehicle_no"));
                bookingModel.setColor(request.getParameter("color"));
                bookingModel.setEngineType(request.getParameter("engine_type"));
                bookingModel.setVehicleType(request.getParameter("vehicle_type"));
                bookingModel.setServiceType(request.getParameter("service_type"));
                bookingModel.setServiceDate(request.getParameter("service_date"));
                bookingModel.setStatus("Pending");
                bookingModel.insert();
            }
            case "edit" -> {
                String id = request.getParameter("id");
                Booking booking = bookingModel.find(id);
                if (booking != null && booking.getUserId() == user.getId()) {
                    booking.setVehicleNumber(request.getParameter("vehicle_no"));
                    booking.setColor(request.getParameter("color"));
                    booking.setEngineType(request.getParameter("engine_type"));
                    booking.setVehicleType(request.getParameter("vehicle_type"));
                    booking.setServiceType(request.getParameter("service_type"));
                    booking.setServiceDate(request.getParameter("service_date"));
                    booking.setCost(100000);
                    booking.update();
                }
            }
            case "delete" -> {
                String id = request.getParameter("id");
                Booking booking = bookingModel.find(id);
                if (booking != null && booking.getUserId() == user.getId()) {
                    bookingModel.setId(Integer.parseInt(id));
                    bookingModel.delete();
                }
            }
            default -> {
            }
        }
        response.sendRedirect(request.getContextPath() + "/booking?menu=view");
    }
}
