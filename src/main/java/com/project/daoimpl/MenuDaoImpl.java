package com.project.daoimpl;

import com.project.dao.MenuDao;
import com.project.model.MenuItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDaoImpl implements MenuDao {

    private static final String URL      = "jdbc:mysql://localhost:3306/jee_register";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Balaji@2003";

    private static final String SELECT_BY_RESTAURANT =
        "SELECT id, restaurant_id, item_name, description, price, " +
        "category, is_veg, image_url FROM menu WHERE restaurant_id = ? ORDER BY category";

    private static final String SELECT_BY_CATEGORY =
        "SELECT id, restaurant_id, item_name, description, price, " +
        "category, is_veg, image_url FROM menu " +
        "WHERE restaurant_id = ? AND category = ?";

    private static final String SELECT_BY_ID =
        "SELECT id, restaurant_id, item_name, description, price, " +
        "category, is_veg, image_url FROM menu WHERE id = ?";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL Driver not found", e);
        }
    }

    // ─── Helper: ResultSet row → MenuItem ────────────────────────
    private MenuItem mapRow(ResultSet rs) throws SQLException {
        return new MenuItem(
            rs.getInt("id"),
            rs.getInt("restaurant_id"),
            rs.getString("item_name"),
            rs.getString("description"),
            rs.getDouble("price"),
            rs.getString("category"),
            rs.getBoolean("is_veg"),
            rs.getString("image_url")
        );
    }

    // ─── 1. Get all items for a restaurant ───────────────────────
    @Override
    public List<MenuItem> getMenuByRestaurantId(int restaurantId) {
        List<MenuItem> list = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(SELECT_BY_RESTAURANT)) {

            pstmt.setInt(1, restaurantId);
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

    // ─── 2. Get items by category ────────────────────────────────
    @Override
    public List<MenuItem> getMenuByCategory(int restaurantId, String category) {
        List<MenuItem> list = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(SELECT_BY_CATEGORY)) {

            pstmt.setInt(1, restaurantId);
            pstmt.setString(2, category);
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

    // ─── 3. Get single item by id ────────────────────────────────
    @Override
    public MenuItem getMenuItemById(int id) {
        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(SELECT_BY_ID)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}