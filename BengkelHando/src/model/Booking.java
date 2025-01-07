/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Booking extends Model<Booking>{
    private int id;
    private int user_id; 
    private String vehicle_no;
    private String color;
    private String engine_type;
    private String vehicle_type;
    private String service_type;
    private String service_date;
    private double cost;
    private String status; // Pending, Confirmed, Completed

    public Booking() {
        this.table = "booking";
        this.primaryKey = "id";
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getVehicleNumber() {
        return vehicle_no;
    }

    public void setVehicleNumber(String vehicle_number) {
        this.vehicle_no = vehicle_number;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getEngineType() {
        return engine_type;
    }

    public void setEngineType(String engine_type) {
        this.engine_type = engine_type;
    }

    public String getVehicleType() {
        return vehicle_type; 
    }

    public void setVehicleType(String vehicle_type) {
        this.vehicle_type = vehicle_type; 
    }

    public int getUserId() {
        return user_id;
    }

    public void setUserId(int userId) {
        this.user_id = userId;
    }
    
    public String getServiceType() {
        return service_type;
    }

    public void setServiceType(String serviceType) {
        this.service_type = serviceType;
    }

    public String getServiceDate() {
        return service_date;
    }

    public void setServiceDate(String serviceDate) {
        this.service_date = serviceDate;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = calculateServiceCost(getServiceType(), getVehicleType());
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    private double calculateServiceCost(String serviceType, String vehicleType) {
        double totalCost = switch (serviceType) {
            case "Oil Change" -> 50000;
            case "Engine Check" -> 100000;
            case "Tire Replacement" -> 150000;
            default -> 20000;
        };        
        if ("Car".equals(vehicleType)) {
            totalCost += 30000;
        } else if ("Motorbike".equals(vehicleType)) {
            totalCost += 10000;
        }
        return totalCost;
    }
    
    @Override
    Booking toModel(ResultSet rs) {
        Booking booking = new Booking();
        try {
            booking.setId(rs.getInt("id"));
            booking.setUserId(rs.getInt("user_id"));
            booking.setVehicleNumber(rs.getString("vehicle_no"));
            booking.setColor(rs.getString("color"));
            booking.setEngineType(rs.getString("engine_type"));
            booking.setVehicleType(rs.getString("vehicle_type"));
            booking.setServiceType(rs.getString("service_type"));
            booking.setServiceDate(rs.getString("service_date"));
            booking.setCost(rs.getDouble("cost"));
            booking.setStatus(rs.getString("status"));
        } catch (SQLException e) {
            System.out.println("Error in toModel (Booking): " + e.getMessage());
        }
        return booking;
    }   
}
