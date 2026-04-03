package com.project.daoimpl;

import com.project.dao.UserDao;
import com.project.model.User;

import java.sql.*;

public class UserDaoImpl implements UserDao {

    private static final String URL      = "jdbc:mysql://localhost:3306/jee_register";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Balaji@2003";

    private static final String SIGNUP =
        "INSERT INTO user (username, password, email, address, role, createdDate) " +
        "VALUES (?, ?, ?, ?, 'Customer', NOW())";

    private static final String CHECK_USERNAME =
        "SELECT userID FROM user WHERE username = ?";

    private static final String CHECK_EMAIL =
        "SELECT userID FROM user WHERE email = ?";

    private static final String UPDATE_LOGIN =
        "UPDATE user SET lastLoginDate = NOW() WHERE userID = ?";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver not found", e);
        }
    }

 // ── Login — PreparedStatement prevents SQL injection ─────────
    @Override
    public User login(String username, String password) {
        // "?" placeholders — values NEVER concatenated into SQL string
        String LOGIN = "SELECT * FROM user WHERE username = ? AND password = ?";

        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(LOGIN)) {

            // Values set SEPARATELY — cannot break the SQL structure
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserID(rs.getInt("userID"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setAddress(rs.getString("address"));
                    user.setRole(rs.getString("role"));
                    user.setCreatedDate(rs.getTimestamp("createdDate"));
                    user.setLastLoginDate(rs.getTimestamp("lastLoginDate"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
 // get user by username
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM user WHERE username = ?";
        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, username);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserID(rs.getInt("userID"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password")); // hashed password
                    user.setEmail(rs.getString("email"));
                    user.setAddress(rs.getString("address"));
                    user.setRole(rs.getString("role"));
                    user.setCreatedDate(rs.getTimestamp("createdDate"));
                    user.setLastLoginDate(rs.getTimestamp("lastLoginDate"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ─── Signup ───────────────────────────────────────────────
    @Override
    public int signup(User user) {
        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(SIGNUP)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getAddress());

            return pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ─── Check username exists ────────────────────────────────
    @Override
    public boolean usernameExists(String username) {
        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(CHECK_USERNAME)) {

            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ─── Check email exists ───────────────────────────────────
    @Override
    public boolean emailExists(String email) {
        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(CHECK_EMAIL)) {

            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ─── Update last login ────────────────────────────────────
    @Override
    public void updateLastLogin(int userID) {
        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(UPDATE_LOGIN)) {

            pstmt.setInt(1, userID);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}