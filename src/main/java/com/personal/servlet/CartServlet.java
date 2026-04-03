package com.personal.servlet;

import java.io.IOException;

import com.project.daoimpl.MenuDaoImpl;
import com.project.model.Cart;
import com.project.model.CartItem;
import com.project.model.MenuItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req,
                           HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "view";

        HttpSession session = req.getSession(true);

        switch (action) {
            case "add":    addItem(req, session);    break;
            case "update": updateItem(req, session); break;
            case "delete": deleteItem(session);      break;
            default:
                req.setAttribute("cart", session.getAttribute("cart"));
                req.getRequestDispatcher("cart.jsp").forward(req, resp);
                return; // return early — no redirect needed for view
        }

        // Redirect after add / update / delete
        if ("add".equals(action)) {
            resp.sendRedirect(getReferer(req));
        } else {
            resp.sendRedirect("cart");
        }
    }

    // ─────────────────────────────────────────────────────────
    // ADD ITEM
    // HashMap key = menuId
    // If cart null or different restaurant → new Cart
    // If key exists → increase qty
    // If key not exists → put new CartItem
    // ─────────────────────────────────────────────────────────
    private void addItem(HttpServletRequest req, HttpSession session) {

        int menuId       = Integer.parseInt(req.getParameter("menuId"));
        int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

        MenuDaoImpl dao   = new MenuDaoImpl();
        MenuItem menuItem = dao.getMenuItemById(menuId);
        if (menuItem == null) return;

        // Get cart from session
        Cart cart = (Cart) session.getAttribute("cart");

        // Cart null OR different restaurant → fresh cart
        if (cart == null || cart.getRestaurantId() != restaurantId) {
            cart = new Cart(restaurantId);
            session.setAttribute("cart", cart);
        }

        // key exists → increase quantity
        if (cart.getItems().containsKey(menuId)) {
            cart.getItems().get(menuId)
                .setQuantity(cart.getItems().get(menuId).getQuantity() + 1);

        } else {
            // key not exists → add new item
            cart.getItems().put(menuId, new CartItem(
                menuItem.getId(),
                restaurantId,
                menuItem.getItemName(),
                menuItem.getPrice(),
                1
            ));
        }
    }

    // ─────────────────────────────────────────────────────────
    // UPDATE ITEM
    // type = "increase" → qty + 1
    // type = "decrease" → qty - 1, remove if qty reaches 0
    // HashMap remove(key) — no ConcurrentModificationException
    // ─────────────────────────────────────────────────────────
    private void updateItem(HttpServletRequest req, HttpSession session) {

        int    itemId = Integer.parseInt(req.getParameter("itemId"));
        String type   = req.getParameter("type");

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) return;

        // Direct access by key — no looping needed
        CartItem item = cart.getItems().get(itemId);
        if (item == null) return;

        if ("increase".equals(type)) {
            item.setQuantity(item.getQuantity() + 1);

        } else if ("decrease".equals(type)) {
            if (item.getQuantity() <= 1) {
                cart.getItems().remove(itemId); // safe — no loop
            } else {
                item.setQuantity(item.getQuantity() - 1);
            }
        }

        // Cart empty after decrease → remove from session
        if (cart.isEmpty()) {
            session.removeAttribute("cart");
        }
    }

    // ─────────────────────────────────────────────────────────
    // DELETE — remove entire cart from session
    // session only — no req or resp needed
    // ─────────────────────────────────────────────────────────
    private void deleteItem(HttpSession session) {
        session.removeAttribute("cart");
    }

    // ── Helper ────────────────────────────────────────────────
    private String getReferer(HttpServletRequest req) {
        String referer = req.getHeader("Referer");
        return (referer != null) ? referer : "callingRestaurant";
    }
}