<%-- 
    Document   : userList
    Created on : 6 Jan 2025, 17.27.36
    Author     : USER
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

    ArrayList<User> customers = (ArrayList<User>) request.getAttribute("customers");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - List User</title>
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
                <h4>List User</h4>
            </div>
            <div class="card-body">
                <table class="table table-striped table-bordered">
                    <thead class="table-primary">
                        <tr class="text-center">
                            <th>No.</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Phone Number</th>
                            <th>Username</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int index = 1;
                            if (customers != null && !customers.isEmpty()) {
                                for (User cust : customers) {        
                        %>
                        <tr class="text-center">
                            <td><%= index++ %></td>
                            <td><%= cust.getFullName() %></td>
                            <td><%= cust.getEmail() %></td>
                            <td><%= user.getPhoneNumber() %></td>
                            <td><%= cust.getUsername() %></td>
                            <td>
                                <% if (cust != null) { %>
                                    <form method="POST" action="<%= request.getContextPath() %>/admin" style="display: inline;">
                                        <input type="hidden" name="action" value="deleteUser" />
                                        <input type="hidden" name="id" value="<%= cust.getId() %>" />
                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Apakah Anda yakin ingin menghapus user ini?');">Hapus</button>
                                    </form>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="8" class="text-center">Tidak ada data user.</td>
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