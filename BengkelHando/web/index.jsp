<%-- 
    Document   : index
    Created on : 5 Jan 2025, 15.22.40
    Author     : cahya
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Bengkel Hando</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
    <!-- Welcome Section -->
    <div class="welcome-section">
        <h1 class="display-3">Welcome to Bengkel Hando</h1>
        <p class="lead">Your trusted vehicle service provider. Book your service today!</p>
        <div class="d-flex justify-content-center mt-4">
            <a href="login.jsp" class="btn btn-custom btn-lg mx-3">Login</a>
            <a href="register.jsp" class="btn btn-light btn-lg mx-3">Register</a>
        </div>
    </div>
    
    <!-- Service Cards -->
    <div class="container mt-5">
        <div class="row text-center">
            <div class="col-lg-4 col-md-6">
                <div class="card mb-4" style="background-color: #ff7e5f;"> <!-- Warna pertama -->
                    <div class="card-body">
                        <h5 class="card-title text-white">Oil Change</h5>
                        <p class="card-text text-white">Keep your engine running smoothly with our professional oil change service.</p>
                    </div>
                    <div class="card-footer">
                        <a href="login.jsp" class="btn btn-custom">Book Now</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="card mb-4" style="background-color: #feb47b;"> <!-- Warna kedua -->
                    <div class="card-body">
                        <h5 class="card-title text-dark">Engine Check</h5>
                        <p class="card-text text-dark">Our experts will thoroughly check your engine for any issues.</p>
                    </div>
                    <div class="card-footer">
                        <a href="login.jsp" class="btn btn-custom">Book Now</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="card mb-4" style="background-color: #f8f9fa;"> <!-- Warna ketiga -->
                    <div class="card-body">
                        <h5 class="card-title text-dark">Tire Replacement</h5>
                        <p class="card-text text-dark">Need new tires? We offer fast and reliable tire replacement services.</p>
                    </div>
                    <div class="card-footer">
                        <a href="login.jsp" class="btn btn-custom">Book Now</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
