package com.project.dao;

import com.project.model.Order;
import com.project.model.OrderItem;
import java.util.List;

public interface OrderDao {

    // Save order → returns generated orderId
    int saveOrder(Order order);

    // Save each order item
    void saveOrderItem(OrderItem orderItem);

    // Get all orders by user
    List<Order> getOrdersByUser(int userId);
}