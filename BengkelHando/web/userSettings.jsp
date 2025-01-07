<%-- 
    Document   : userSettings
    Created on : 30 Dec 2024, 22.41.56
    Author     : cahya
--%>
<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    User user = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pengaturan Profil</title>
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
                        <a class="nav-link" href="booking?menu=history">History</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="user?menu=edit">Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" id="logoutButton">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container mt-5">
        <h1 class="text-center mb-4 text-custom-primary">Pengaturan Profil</h1>

        <!-- Profile Information Card -->
        <div class="card shadow-custom mb-4">
            <div class="card-header bg-custom-secondary">
                Informasi Profil
            </div>
            <% if (user != null) { %>
            <div class="card-body">
                <p><strong>Nama Lengkap:</strong> <%= user.getFullName() %></p>
                <p><strong>Email:</strong> <%= user.getEmail() %></p>
                <p><strong>Nomor Telepon:</strong> <%= user.getPhoneNumber() %></p>
            </div>
            <% } else { %>
            <div class="card-body">
                <p class="text-center text-danger">Data profil tidak tersedia.</p>
            </div>
            <% } %>
        </div>

        <!-- Form for Change Profile -->
        <form action="user" method="post" class="shadow-custom p-4 bg-light rounded mb-5">
            <input type="hidden" name="action" value="edit">
            <div class="mb-3">
                <label for="namaLengkap" class="form-label text-custom-primary">Nama Lengkap</label>
                <input type="text" class="form-control" id="namaLengkap" name="full_name" value="<%= user != null ? user.getFullName() : "" %>" placeholder="Masukkan nama lengkap">
            </div>
            <div class="mb-3">
                <label for="email" class="form-label text-custom-primary">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= user != null ? user.getEmail() : "" %>" placeholder="Masukkan email">
            </div>
            <div class="mb-3">
                <label for="nomorTelepon" class="form-label text-custom-primary">Nomor Telepon</label>
                <input type="text" class="form-control" id="nomorTelepon" name="phone_number" value="<%= user != null ? user.getPhoneNumber() : "" %>" placeholder="Masukkan nomor telepon">
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-custom">Simpan Perubahan</button>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
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
