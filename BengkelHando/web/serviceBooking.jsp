<%-- 
    Document   : serviceBooking
    Created on : 30 Dec 2024, 22.43.00
    Author     : cahya
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-body">
                        <h2 class="text-center mb-4">Service Booking</h2>
                        <form action="booking" method="POST">
                            <input type="hidden" name="action" value="add">

                            <!-- Vehicle Selection -->
                            <div class="mb-3">
                                <label for="vehicle_type" class="form-label">Vehicle</label>
                                <select class="form-select" id="vehicle_type" name="vehicle_type" required onchange="calculateCost()">
                                    <option value="">-- Select Your Vehicle --</option>
                                    <option value="Car">Car</option>
                                    <option value="Motorbike">Motorbike</option>
                                </select>
                            </div>

                            <!-- Vehicle Details -->
                            <div class="mb-3">
                                <label for="vehicle_no" class="form-label">Vehicle Number (No Pol)</label>
                                <input type="text" class="form-control" id="vehicle_no" name="vehicle_no" placeholder="Enter vehicle number" required>
                            </div>

                            <div class="mb-3">
                                <label for="color" class="form-label">Vehicle Color</label>
                                <input type="text" class="form-control" id="color" name="color" placeholder="Enter vehicle color" required>
                            </div>

                            <div class="mb-3">
                                <label for="engine_type" class="form-label">Engine Type</label>
                                <input type="text" class="form-control" id="engine_type" name="engine_type" placeholder="Enter engine type" required>
                            </div>

                            <!-- Service Type -->
                            <div class="mb-3">
                                <label for="service_type" class="form-label">Service Type</label>
                                <select class="form-select" id="service_type" name="service_type" required onchange="calculateCost()">
                                    <option value="">-- Select Service Type --</option>
                                    <option value="Oil Change">Oil Change</option>
                                    <option value="Engine Check">Engine Check</option>
                                    <option value="Tire Replacement">Tire Replacement</option>
                                </select>
                            </div>

                            <!-- Service Date -->
                            <div class="mb-3">
                                <label for="service_date" class="form-label">Preferred Service Date</label>
                                <input type="date" class="form-control" id="service_date" name="service_date" required>
                            </div>

                            <!-- Estimated Cost -->
                            <div class="mb-3">
                                <label for="cost" class="form-label">Estimated Cost</label>
                                <input type="text" class="form-control" id="cost" name="cost" placeholder="Auto-calculated or user input" disabled>
                            </div>

                            <!-- Submit Button -->
                            <div class="d-flex justify-content-between">
                                <a href="booking?menu=view" class="btn btn-secondary-custom">Back</a>
                                <button type="submit" class="btn btn-custom">Book Service</button>
                            </div>
                        </form>
                        <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger mt-3 text-center">
                                Error occurred!
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Cost Calculation Logic -->
    <script>
        function calculateCost() {
            var vehicleType = document.getElementById("vehicle_type").value;
            var serviceType = document.getElementById("service_type").value;
            var cost = 0;

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

            // Additional cost based on vehicle type
            if (vehicleType === "Car") {
                cost += 30000;
            } else if (vehicleType === "Motorbike") {
                cost += 10000;
            }
            document.getElementById("cost").value = "Rp " + cost.toLocaleString();
        }
    </script>
</body>
</html>
