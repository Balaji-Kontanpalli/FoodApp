package com.project.daoimpl;

import com.project.dao.RestaurantDao;
import com.project.model.Restaurant;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDaoImpl implements RestaurantDao {

    private static final String URL      = "jdbc:mysql://localhost:3306/jee_register";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Balaji@2003";

    // ─── SQL Queries ─────────────────────────────────────────────
    private static final String SELECT_ALL =
        "SELECT id, name, category, location, rating, price_for_two, " +
        "distance_km, offer, image_url FROM restaurants";

    private static final String SELECT_BY_CATEGORY =
        "SELECT id, name, category, location, rating, price_for_two, " +
        "distance_km, offer, image_url FROM restaurants WHERE category = ?";

    private static final String SELECT_BY_LOCATION =
        "SELECT id, name, category, location, rating, price_for_two, " +
        "distance_km, offer, image_url FROM restaurants WHERE location = ?";

    private static final String SELECT_BY_ID =
        "SELECT id, name, category, location, rating, price_for_two, " +
        "distance_km, offer, image_url FROM restaurants WHERE id = ?";

    // ─── Load Driver Once ─────────────────────────────────────────
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL Driver not found", e);
        }
    }

    // ─── Helper: map a ResultSet row → Restaurant object ─────────
    private Restaurant mapRow(ResultSet rs) throws SQLException {
        return new Restaurant(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("category"),
            rs.getString("location"),
            rs.getDouble("rating"),
            rs.getInt("price_for_two"),
            rs.getDouble("distance_km"),
            rs.getString("offer"),
            rs.getString("image_url")
        );
    }

    // ─── 1. Get All Restaurants ───────────────────────────────────
    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> list = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            System.out.println("=== SQL ERROR ===");
            System.out.println("Message : " + e.getMessage());   // ← exact error
            System.out.println("SQLState: " + e.getSQLState());  // ← error code
            e.printStackTrace();
        }
        return list;
    }

    // ─── 2. Get By Category ───────────────────────────────────────
    @Override
    public List<Restaurant> getRestaurantsByCategory(String category) {
        List<Restaurant> list = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(SELECT_BY_CATEGORY)) {

            pstmt.setString(1, category);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─── 3. Get By Location ───────────────────────────────────────
    @Override
    public List<Restaurant> getRestaurantsByLocation(String location) {
        List<Restaurant> list = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(SELECT_BY_LOCATION)) {

            pstmt.setString(1, location);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─── 4. Get By ID ─────────────────────────────────────────────
    @Override
    public Restaurant getRestaurantById(int id) {
        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(SELECT_BY_ID)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}