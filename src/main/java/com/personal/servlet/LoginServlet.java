package com.personal.servlet;

import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;
import com.project.daoimpl.UserDaoImpl;
import com.project.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ── 1. Get inputs ─────────────────────────────────────
        String username = sanitize(req.getParameter("username"));
        String password = sanitize(req.getParameter("password"));
        String role     = req.getParameter("role");

        // ── 2. Basic validation ───────────────────────────────
        if (username.isEmpty() || password.isEmpty()) {
            forward(req, resp, "Username and password cannot be empty.");
            return;
        }
        if (username.length() < 3 || username.length() > 20) {
            forward(req, resp, "Username must be between 3 and 20 characters.");
            return;
        }
        if (!username.matches("[a-zA-Z0-9]+")) {
            forward(req, resp, "Username can only contain letters and numbers.");
            return;
        }
        if (password.length() < 6) {
            forward(req, resp, "Password must be at least 6 characters.");
            return;
        }
        if (!password.matches(".*[A-Z].*")) {
            forward(req, resp, "Password must have at least one uppercase letter.");
            return;
        }
        if (!password.matches(".*[0-9].*")) {
            forward(req, resp, "Password must have at least one number.");
            return;
        }
        if (isSqlInjection(username) || isSqlInjection(password)) {
            forward(req, resp, "Invalid characters detected.");
            return;
        }

        // ── 3. Fetch user from DB by username ─────────────────
        UserDaoImpl dao = new UserDaoImpl();
        User user = dao.getUserByUsername(username);

        // User not found
        if (user == null) {
            forward(req, resp, "Invalid username or password.");
            return;
        }

        // ── 4. BCrypt password check ──────────────────────────
        // BCrypt.checkpw(plainPassword, hashedPasswordFromDB)
        // It reads the salt from hashedPassword automatically
        // Returns true if they match, false otherwise
        boolean passwordMatch = BCrypt.checkpw(password, user.getPassword());

        if (!passwordMatch) {
            forward(req, resp, "Invalid username or password.");
            return;
        }

        // ── 5. Role check ─────────────────────────────────────
        if (role != null && !role.isEmpty() && !role.equals(user.getRole())) {
            forward(req, resp,
                "You selected '" + role + "' but your account role is '"
                + user.getRole() + "'. Please select the correct role.");
            return;
        }

        // ── 6. Login success → update lastLogin → set session ─
        dao.updateLastLogin(user.getUserID());

        HttpSession session = req.getSession(true);
        session.setAttribute("loggedUser", user);
        session.setAttribute("username",   user.getUsername());
        session.setAttribute("role",       user.getRole());
        session.setMaxInactiveInterval(30 * 60); // 30 min timeout

        // Redirect everyone to restaurant page
        resp.sendRedirect("callingRestaurant");
    }

    // ── Sanitize ──────────────────────────────────────────────
    private String sanitize(String input) {
        if (input == null) return "";
        return input.trim().replaceAll("<[^>]*>", "");
    }

    // ── SQL Injection check ───────────────────────────────────
    private boolean isSqlInjection(String input) {
        if (input == null) return false;
        String lower = input.toLowerCase();
        String[] patterns = {
            "'", ";", "--", "/*", "*/",
            "drop ", "delete ", "insert ",
            "select ", "union ", "exec ",
            "update ", "alter ", "truncate "
        };
        for (String p : patterns) {
            if (lower.contains(p)) return true;
        }
        return false;
    }

    // ── Forward with error ────────────────────────────────────
    private void forward(HttpServletRequest req,
                         HttpServletResponse resp, String error)
            throws ServletException, IOException {
        req.setAttribute("error", error);
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }
}