package com.personal.servlet;

import java.io.IOException;
import java.util.List;

import com.project.daoimpl.MenuDaoImpl;
import com.project.daoimpl.RestaurantDaoImpl;
import com.project.model.MenuItem;
import com.project.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get restaurant id from URL: /menu?id=1
        int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

        // Fetch restaurant details
        RestaurantDaoImpl restaurantDao = new RestaurantDaoImpl();
        Restaurant restaurant = restaurantDao.getRestaurantById(restaurantId);

        // Fetch menu items
        MenuDaoImpl menuDao = new MenuDaoImpl();
        List<MenuItem> menuItems = menuDao.getMenuByRestaurantId(restaurantId);

        // Set attributes and forward to JSP
        req.setAttribute("restaurant", restaurant);
        req.setAttribute("menuItems", menuItems);

        RequestDispatcher rd = req.getRequestDispatcher("menu.jsp");
        rd.forward(req, resp);
    }
}