<%-- 
    Document   : userDashboard
    Created on : 30 Dec 2024, 22.39.52
    Author     : cahya
--%>
<%@page import="model.Booking"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    ArrayList<Booking> bookings = (ArrayList<Booking>) request.getAttribute("bookings");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard User - List Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-custom-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">User Dashboard</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="booking?menu=view">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="booking?menu=history">History</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="user?menu=edit">Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" id="logoutButton">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h1 class="mb-4">List Booking</h1>

        <!-- Add New Booking Button -->
        <div class="mb-4">
            <a href="<%= request.getContextPath() %>/booking?menu=add" class="btn btn-custom btn-lg">Add New Booking</a>
        </div>
        
        <!-- Booking Cards -->
        <div class="row">
            <%
                if (bookings != null && !bookings.isEmpty()) {
                    int index = 1;
                    for (Booking booking : bookings) {
                        boolean isConfirmed = "Confirmed".equals(booking.getStatus());
            %>
            <div class="col-md-4 mb-4">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title">Booking ID: BK<%= booking.getId() %></h5>
                        <h6 class="card-subtitle mb-2 text-muted">Vehicle: <%= booking.getVehicleType() + " (" + booking.getVehicleNumber() + ")" %></h6>
                        <p class="card-text">Date: <%= booking.getServiceDate() %></p>
                        <p class="card-text">Service Type: <%= booking.getServiceType() %></p>
                        <p class="card-text">Estimated Cost: Rp <%= booking.getCost() %></p>
                        <p class="card-text">Status: <%= booking.getStatus() %></p>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <a href="<%= request.getContextPath() %>/booking?menu=edit&id=<%= booking.getId() %>" class="btn btn-warning btn-sm" <% if (isConfirmed) { %> disabled <% } %>>Edit</a>
                            <% if (!isConfirmed) { %>
                            <form method="POST" action="<%= request.getContextPath() %>/booking" style="display: inline;">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="id" value="<%= booking.getId() %>" />
                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Apakah Anda yakin ingin menghapus pesanan ini?');">Hapus</button>
                            </form>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="col-12">
                <div class="alert alert-warning text-center">
                    Tidak ada data booking atau kendaraan.
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
    
    <!-- Logout Button Authentication -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById("logoutButton").addEventListener("click", function (e) {
            e.preventDefault();
            fetch("<%= request.getContextPath() %>/AuthServlet", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                body: "action=logout",
            })
            .then(response => {
                if (response.redirected) {
                    window.location.href = response.url;
                }
            })
            .catch(error => console.error("Logout failed:", error));
        });
    </script>
</body>
</html>


