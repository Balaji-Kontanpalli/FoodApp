package com.project.daoimpl;

import com.project.dao.OrderDao;
import com.project.model.Order;
import com.project.model.OrderItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDaoImpl implements OrderDao {

    private static final String URL      = "jdbc:mysql://localhost:3306/jee_register";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Balaji@2003";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver not found", e);
        }
    }

    // ── 1. Save Order — returns generated orderId ─────────────
    // As per lecture: store in orders table FIRST
    // then use the generated orderId for order_items
    @Override
    public int saveOrder(Order order) {
        String sql = "INSERT INTO orders " +
                     "(userId, restaurantId, totalAmount, " +
                     "status, paymentMode, deliveryAddress) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(
                 sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt   (1, order.getUserId());
            pstmt.setInt   (2, order.getRestaurantId());
            pstmt.setDouble(3, order.getTotalAmount());
            pstmt.setString(4, order.getStatus());
            pstmt.setString(5, order.getPaymentMode());
            pstmt.setString(6, order.getDeliveryAddress());

            pstmt.executeUpdate();

            // Get the auto-generated orderId
            ResultSet rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // return generated orderId
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // failed
    }

    // ── 2. Save Order Item ────────────────────────────────────
    @Override
    public void saveOrderItem(OrderItem item) {
        String sql = "INSERT INTO order_items " +
                     "(orderId, menuId, quantity, totalPrice) " +
                     "VALUES (?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt   (1, item.getOrderId());
            pstmt.setInt   (2, item.getMenuId());
            pstmt.setInt   (3, item.getQuantity());
            pstmt.setDouble(4, item.getTotalPrice());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── 3. Get Orders By User ─────────────────────────────────
    @Override
    public List<Order> getOrdersByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE userId = ? ORDER BY orderDate DESC";

        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getInt("orderId"));
                    o.setUserId(rs.getInt("userId"));
                    o.setRestaurantId(rs.getInt("restaurantId"));
                    o.setOrderDate(rs.getTimestamp("orderDate"));
                    o.setTotalAmount(rs.getDouble("totalAmount"));
                    o.setStatus(rs.getString("status"));
                    o.setPaymentMode(rs.getString("paymentMode"));
                    o.setDeliveryAddress(rs.getString("deliveryAddress"));
                    list.add(o);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}