<%-- 
    Document   : adminDashboard
    Created on : 30 Dec 2024, 22.34.22
    Author     : cahya
--%>
<%@page import="model.User"%>
<%@page import="model.Booking"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession userSession = request.getSession(false);
    User user = (User) userSession.getAttribute("admin");
    if (userSession == null || userSession.getAttribute("admin") == null || !user.getRole().equals("ADMIN")) {
        response.sendRedirect("../index.jsp");
        return;
    }

    ArrayList<Booking> bookings = (ArrayList<Booking>) request.getAttribute("bookings");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - List Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Admin Dashboard</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="admin?menu=view">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin?menu=userList">User List</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" id="logoutButton">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <div class="container mt-5">
        <h1 class="text-center mb-4">Admin Dashboard</h1>
        <div class="card mb-5">
            <div class="card-header">
                <h4>List Booking</h4>
            </div>
            <div class="card-body">
                <table class="table table-striped table-bordered">
                    <thead class="table-primary">
                        <tr class="text-center">
                            <th>#</th>
                            <th>Cust ID</th>
                            <th>Vehicle Number</th>
                            <th>Book Date</th>
                            <th>Service Type</th>
                            <th>Estimate Cost</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (bookings != null && !bookings.isEmpty()) {
                                for (Booking booking : bookings) {
                        %>
                        <tr class="text-center">
                            <td><%= booking.getId() %></td>
                            <td><%= booking.getUserId() %></td>
                            <td><%= booking.getVehicleNumber() %></td>
                            <td><%= booking.getServiceDate() %></td>
                            <td><%= booking.getServiceType() %></td>
                            <td><%= "Rp " + booking.getCost() %></td>
                            <td>
                                <span class="badge 
                                    <%= booking.getStatus().equals("Pending") ? "bg-warning" : 
                                        (booking.getStatus().equals("Confirmed") ? "bg-primary" : "bg-success") %>">
                                    <%= booking.getStatus() %>
                                </span>
                            </td>
                            <td>
                                <form action="<%= request.getContextPath() %>/admin" method="POST" class="d-flex">
                                    <input type="hidden" name="action" value="updateStatus">
                                    <input type="hidden" name="booking_id" value="<%= booking.getId() %>">
                                    <select name="status" class="form-select form-select-sm me-2" required>
                                        <option value="" disabled selected>Update Status</option>
                                        <option value="Pending">Pending</option>
                                        <option value="Confirmed">Confirmed</option>
                                        <option value="Completed">Completed</option>
                                    </select>
                                    <button type="submit" class="btn btn-primary btn-sm">Update</button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="8" class="text-center">Tidak ada data booking atau kendaraan.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>


                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Logout Button Authentication -->
    <script>
        document.getElementById("logoutButton").addEventListener("click", function (e) {
            e.preventDefault(); // Mencegah default action dari link
            fetch("<%= request.getContextPath() %>/AuthServlet", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                body: "action=logout", // Data yang dikirimkan dalam permintaan POST
            })
            .then(response => {
                if (response.redirected) {
                    // Jika servlet mengarahkan ulang, ikuti redirect-nya
                    window.location.href = response.url;
                }
            })
            .catch(error => console.error("Logout failed:", error));
        });
    </script>
</body>
</html>
