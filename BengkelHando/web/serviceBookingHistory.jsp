<%-- 
    Document   : serviceBookingHistory
    Created on : 30 Dec 2024, 22.44.28
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
    <title>History Service Kendaraan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
        <h1 class="text-center mb-4 text-custom-primary">History Service Kendaraan</h1>
        <%
            if (bookings != null && !bookings.isEmpty()) {
                int index = 1;
                for (Booking booking : bookings) {
        %>
        <div class="card mb-4 shadow-custom">
            <div class="card-header bg-custom-secondary d-flex justify-content-between align-items-center">
                <strong><%= booking.getVehicleType() %> • <%= booking.getVehicleNumber() %></strong>
                <button class="btn btn-sm btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#serviceDetails<%= index %>" aria-expanded="false" aria-controls="serviceDetails<%= index %>">
                    Details
                </button>
            </div>
            <div class="card-body">
                <h5 class="card-title">Service #<%= index++ %></h5>
                <p class="card-text">Service Type: <%= booking.getServiceType() %></p>
                <div class="collapse" id="serviceDetails<%= index - 1 %>">
                    <table class="table table-striped">
                        <thead class="bg-custom-tertiary text-white">
                            <tr>
                                <th scope="col">Vehicle Number</th>
                                <th scope="col">Engine Type</th>
                                <th scope="col">Color</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><%= booking.getVehicleNumber() %></td>
                                <td><%= booking.getEngineType() %></td>
                                <td><%= booking.getColor() %></td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="2" class="text-end">TOTAL</td>
                                <td class="fw-bold">Rp <%= booking.getCost() %></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
            <div class="card-footer text-muted text-center">
                <%= booking.getServiceDate() %>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <div class="alert alert-warning text-center">
            Tidak ada data booking atau kendaraan.
        </div>
        <%
            }
        %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Logout Button Authentication -->
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

