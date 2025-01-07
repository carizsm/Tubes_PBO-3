<%-- 
    Document   : editBooking
    Created on : 5 Jan 2025, 12.45.50
    Author     : cahya
--%>
<%@page import="model.Booking"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Edit Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css"> <!-- Menggunakan styles.css yang sudah disesuaikan -->
</head>
<body>
    <%
        Booking booking = (Booking) request.getAttribute("booking");
        if (booking == null) {
    %>
        <div class="container my-5">
            <div class="alert alert-danger text-center">
                <h4>Data booking tidak ditemukan.</h4>
                <a href="booking?menu=view" class="btn btn-custom mt-3">Kembali ke Dashboard</a>
            </div>
        </div>
    <%
        } else {
    %>
    <div class="container my-5">
        <div class="card shadow">
            <div class="card-header text-dark text-center">
                <h2>Edit Booking</h2>
            </div>
            <div class="card-body">
                <form method="POST" action="booking">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" value="<%= booking.getId() %>">
                    
                    <!-- Vehicle Number Input -->
                    <div class="form-floating mb-3">
                        <input 
                            type="text" 
                            class="form-control" 
                            id="vehicleNumber" 
                            name="vehicle_no" 
                            value="<%= booking.getVehicleNumber() %>" 
                            required>
                        <label for="vehicleNumber">Nomor Kendaraan</label>
                    </div>

                    <!-- Vehicle Color Input -->
                    <div class="form-floating mb-3">
                        <input 
                            type="text" 
                            class="form-control" 
                            id="color" 
                            name="color" 
                            value="<%= booking.getColor() %>" 
                            required>
                        <label for="color">Warna Kendaraan</label>
                    </div>

                    <!-- Machine Type Input -->
                    <div class="form-floating mb-3">
                        <input 
                            type="text" 
                            class="form-control" 
                            id="engineType" 
                            name="engine_type" 
                            value="<%= booking.getEngineType() %>" 
                            required>
                        <label for="engineType">Tipe Mesin</label>
                    </div>

                    <!-- Vehicle Type Input -->
                    <div class="form-floating mb-3">
                        <select class="form-select" id="vehicle_type" name="vehicle_type" required onchange="calculateCost()">
                                <option value="">-- Select Your Vehicle --</option>
                                <option value="Car">Car</option>
                                <option value="Motorbike">Motorbike</option>
                            </select>
                        <label for="vehicleType">Tipe Kendaraan : <%= booking.getVehicleType() %></label>
                    </div>

                    <!-- Service Type Input -->
                    <div class="form-floating mb-3">
                        <select class="form-select" id="service_type" name="service_type" required onchange="calculateCost()">
                            <option value="">-- Select Service Type --</option>
                            <option value="Oil Change">Oil Change</option>
                            <option value="Engine Check">Engine Check</option>
                            <option value="Tire Replacement">Tire Replacement</option>
                        </select>
                        <label for="serviceType">Jenis Layanan : <%= booking.getServiceType() %></label>
                    </div>

                    <!-- Service Date Input -->
                    <div class="form-floating mb-3">
                        <input 
                            type="date" 
                            class="form-control" 
                            id="serviceDate" 
                            name="service_date" 
                            value="<%= booking.getServiceDate() %>" 
                            required>
                        <label for="serviceDate">Tanggal Layanan</label>
                    </div>

                    <!-- Booking Status Input -->
                    <div class="form-floating mb-3">
                        <input 
                            type="text" 
                            class="form-control" 
                            id="status" 
                            name="status" 
                            value="<%= booking.getStatus() %>" 
                            disabled>
                        <label for="status">Status</label>
                    </div>
                            

                    <!-- Estimated Cost -->
                    <div class="form-floating mb-3">
                        <input 
                            type="text" 
                            class="form-control" 
                            id="cost" 
                            name="cost" 
                            value="<%= booking.getCost() %>"
                            disabled>
                        <label for="cost">Estimated Cost</label>
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="booking?menu=view" class="btn btn-secondary-custom btn-lg">Kembali</a>
                        <button type="submit" class="btn btn-custom btn-lg" 
                            <% if ("Confirmed".equals(booking.getStatus())) { %> disabled <% } %>>
                            Simpan Perubahan
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%
        }
    %>
    
    <script>
        function calculateCost() {
            var vehicleType = document.getElementById("vehicle_type").value;
            var serviceType = document.getElementById("service_type").value;
            var cost = 0;

            // Cost calculation based on service type
            switch (serviceType) {
                case "Oil Change":
                    cost = 50000;
                    break;
                case "Engine Check":
                    cost = 100000;
                    break;
                case "Tire Replacement":
                    cost = 150000;
                    break;
                default:
                    cost = 20000;
            }

            // Add additional cost based on vehicle type
            if (vehicleType === "Car") {
                cost += 30000;
            } else if (vehicleType === "Motorbike") {
                cost += 10000;
            }

            // Display the calculated cost in the 'cost' field
            document.getElementById("cost").value = "Rp " + cost.toLocaleString();
        }
    </script>
</body>
</html>


