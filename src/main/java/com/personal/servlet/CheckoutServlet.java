package com.personal.servlet;

import java.io.IOException;
import java.util.Collection;

import com.project.daoimpl.OrderDaoImpl;
import com.project.model.Cart;
import com.project.model.CartItem;
import com.project.model.Order;
import com.project.model.OrderItem;
import com.project.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    // GET — show checkout page
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("checkout.jsp").forward(req, resp);
    }

    // POST — place the order
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(true);

        // ── 1. Get logged user from session ───────────────────
        User user = (User) session.getAttribute("loggedUser");

        // If not logged in → redirect to login
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        // ── 2. Get cart from session ──────────────────────────
        Cart cart = (Cart) session.getAttribute("cart");

        // If cart is empty → back to restaurants
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect("callingRestaurant");
            return;
        }

        // ── 3. Get delivery address & payment mode from form ──
        String deliveryAddress = req.getParameter("deliveryAddress").trim();
        String paymentMode     = req.getParameter("paymentMode").trim();

        if (deliveryAddress.isEmpty()) {
            req.setAttribute("error", "Please enter a delivery address.");
            req.getRequestDispatcher("checkout.jsp").forward(req, resp);
            return;
        }

        // ── 4. Build Order object ─────────────────────────────
        Order order = new Order(
            user.getUserID(),           // userId from session
            cart.getRestaurantId(),     // restaurantId from cart
            cart.getTotalPrice(),       // totalAmount calculated
            "Pending",                  // status hardcoded
            paymentMode,                // from form
            deliveryAddress             // from form
        );

        // ── 5. Save Order FIRST — get generated orderId ───────
        // As per lecture: orders table must be stored FIRST
        // because order_items needs the orderId as foreign key
        OrderDaoImpl orderDao = new OrderDaoImpl();
        int orderId = orderDao.saveOrder(order);

        if (orderId == -1) {
            req.setAttribute("error", "Order failed. Please try again.");
            req.getRequestDispatcher("checkout.jsp").forward(req, resp);
            return;
        }

        // ── 6. Save each cart item as OrderItem ───────────────
        Collection<CartItem> items = cart.getItems().values();

        for (CartItem item : items) {
            OrderItem orderItem = new OrderItem(
                orderId,                              // from step 5
                item.getId(),                         // menuId
                item.getQuantity(),                   // quantity
                item.getPrice() * item.getQuantity()  // totalPrice
            );
            orderDao.saveOrderItem(orderItem);
        }

        // ── 7. Clear cart from session after order placed ─────
        session.removeAttribute("cart");

        // ── 8. Show success page ──────────────────────────────
        req.setAttribute("orderId", orderId);
        req.setAttribute("totalAmount", cart.getTotalPrice());
        req.getRequestDispatcher("order-success.jsp").forward(req, resp);
    }
}