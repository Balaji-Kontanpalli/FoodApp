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

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("signup.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ── 1. Get inputs ─────────────────────────────────────
        String username = sanitize(req.getParameter("username"));
        String email    = sanitize(req.getParameter("email"));
        String address  = sanitize(req.getParameter("address"));
        String password = sanitize(req.getParameter("password"));
        String confirm  = sanitize(req.getParameter("confirmPassword"));
        String role     = "Customer"; // always Customer from signup

        // ── 2. Empty check ────────────────────────────────────
        if (username.isEmpty() || email.isEmpty() ||
            address.isEmpty()  || password.isEmpty()) {
            forward(req, resp, "All fields are required.");
            return;
        }

        // ── 3. Username: 3–20 chars, alphanumeric ─────────────
        if (username.length() < 3 || username.length() > 20) {
            forward(req, resp, "Username must be between 3 and 20 characters.");
            return;
        }
        if (!username.matches("[a-zA-Z0-9]+")) {
            forward(req, resp, "Username can only contain letters and numbers.");
            return;
        }

        // ── 4. Email format ───────────────────────────────────
        if (!email.matches("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            forward(req, resp, "Please enter a valid email address.");
            return;
        }

        // ── 5. Password: min 6, uppercase, number ─────────────
        if (password.length() < 6) {
            forward(req, resp, "Password must be at least 6 characters.");
            return;
        }
        if (!password.matches(".*[A-Z].*")) {
            forward(req, resp, "Password must contain at least one uppercase letter.");
            return;
        }
        if (!password.matches(".*[0-9].*")) {
            forward(req, resp, "Password must contain at least one number.");
            return;
        }

        // ── 6. Confirm password ───────────────────────────────
        if (!password.equals(confirm)) {
            forward(req, resp, "Passwords do not match.");
            return;
        }

        // ── 7. SQL Injection check ────────────────────────────
        if (isSqlInjection(username) || isSqlInjection(email) ||
            isSqlInjection(address)  || isSqlInjection(password)) {
            forward(req, resp, "Invalid characters detected.");
            return;
        }

        // ── 8. Check username/email already exists ────────────
        UserDaoImpl dao = new UserDaoImpl();
        if (dao.usernameExists(username)) {
            forward(req, resp, "Username '" + username + "' is already taken.");
            return;
        }
        if (dao.emailExists(email)) {
            forward(req, resp, "Email '" + email + "' is already registered.");
            return;
        }

        // ── 9. Hash password using BCrypt ─────────────────────
        // BCrypt.hashpw(plainPassword, BCrypt.gensalt(12))
        // 12 = number of rounds (how many times it encrypts)
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));

        // ── 10. Create user object with hashed password ───────
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(hashedPassword); // store hashed, NOT plain
        newUser.setEmail(email);
        newUser.setAddress(address);
        newUser.setRole(role);

        // ── 11. Save to DB ────────────────────────────────────
        int result = dao.signup(newUser);

        if (result == 1) {
            // Success → add to session → redirect to restaurant page
            HttpSession session = req.getSession(true);
            session.setAttribute("loggedUser", newUser);
            session.setAttribute("username",   newUser.getUsername());
            session.setAttribute("role",       newUser.getRole());

            resp.sendRedirect("callingRestaurant");
        } else {
            forward(req, resp, "Signup failed. Please try again.");
        }
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
        req.getRequestDispatcher("signup.jsp").forward(req, resp);
    }
}