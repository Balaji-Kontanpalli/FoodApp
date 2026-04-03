<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.User,
                 com.project.model.Cart,
                 com.project.model.CartItem,
                 java.util.Collection"%>

<%
  // ── As per lecture: check session for logged user ──────────
  User user = (User) session.getAttribute("loggedUser");
  Cart cart = (Cart) session.getAttribute("cart");

  // If not logged in → redirect to login
  if (user == null) {
      response.sendRedirect("login");
      return;
  }

  // If cart empty → redirect to restaurants
  if (cart == null || cart.isEmpty()) {
      response.sendRedirect("callingRestaurant");
      return;
  }

  Collection<CartItem> items = cart.getItems().values();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Checkout – FoodApp</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet"/>
  <style>
    :root {
      --orange:#FF5200; --orange-lt:#FF7A3D;
      --dark:#0D0D0D; --dark2:#1A1A1A; --dark3:#252525;
      --card-bg:#1E1E1E; --text:#F5F5F5; --muted:#999;
      --green:#48C774; --red:#fc8181; --white:#FFFFFF;
      --radius:14px;
      --font-head:'Syne',sans-serif;
      --font-body:'DM Sans',sans-serif;
    }
    *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
    body{
      background:var(--dark);color:var(--text);
      font-family:var(--font-body);min-height:100vh;
    }
    a{text-decoration:none;color:inherit}

    /* NAV */
    nav{
      position:sticky;top:0;z-index:100;
      display:flex;align-items:center;justify-content:space-between;
      padding:0 5%;height:64px;
      background:rgba(13,13,13,0.95);backdrop-filter:blur(14px);
      border-bottom:1px solid rgba(255,82,0,0.12);
    }
    .nav-logo{font-family:var(--font-head);font-size:1.4rem;font-weight:800;color:var(--orange)}
    .nav-logo span{color:var(--white)}
    .back-btn{
      display:flex;align-items:center;gap:8px;
      font-size:0.875rem;font-weight:600;color:var(--muted);
      border:1.5px solid rgba(255,255,255,0.1);
      padding:7px 16px;border-radius:8px;transition:all 0.2s;
    }
    .back-btn:hover{border-color:var(--orange);color:var(--orange)}

    /* PAGE */
    .page{
      max-width:1000px;margin:0 auto;
      padding:40px 5% 80px;
      display:grid;
      grid-template-columns:1fr 360px;
      gap:32px;align-items:start;
    }

    /* CARD */
    .section-card{
      background:var(--dark2);
      border:1px solid rgba(255,255,255,0.07);
      border-radius:var(--radius);padding:28px;
      margin-bottom:20px;
    }
    .section-card-title{
      font-family:var(--font-head);font-size:1rem;
      font-weight:800;margin-bottom:20px;
      padding-bottom:14px;
      border-bottom:1px solid rgba(255,255,255,0.06);
      display:flex;align-items:center;gap:10px;
    }

    /* USER INFO */
    .user-info-row{
      display:flex;align-items:center;gap:12px;
      background:var(--dark3);border-radius:10px;
      padding:14px 16px;
      border:1px solid rgba(255,255,255,0.05);
    }
    .user-avatar{
      width:42px;height:42px;border-radius:50%;
      background:rgba(255,82,0,0.15);
      border:2px solid rgba(255,82,0,0.3);
      display:flex;align-items:center;justify-content:center;
      font-size:1.1rem;flex-shrink:0;
    }
    .user-name{font-family:var(--font-head);font-weight:700;font-size:0.95rem}
    .user-email{font-size:0.78rem;color:var(--muted)}

    /* FORM */
    .form-group{margin-bottom:16px}
    .form-group label{
      display:block;font-size:0.78rem;font-weight:600;
      color:var(--muted);text-transform:uppercase;
      letter-spacing:0.8px;margin-bottom:8px;
    }
    .form-group textarea,
    .form-group select,
    .form-group input{
      width:100%;background:var(--dark3);
      border:1.5px solid rgba(255,255,255,0.07);
      border-radius:10px;padding:12px 14px;
      font-family:var(--font-body);font-size:0.9rem;
      color:var(--text);outline:none;
      transition:border-color 0.2s;
      resize:vertical;
    }
    .form-group textarea:focus,
    .form-group select:focus,
    .form-group input:focus{ border-color:var(--orange) }
    .form-group textarea::placeholder,
    .form-group input::placeholder{ color:#444 }
    .form-group select option{ background:var(--dark3) }

    /* Alert */
    .alert-error{
      background:rgba(229,62,62,0.12);
      border:1px solid rgba(229,62,62,0.3);
      color:var(--red);padding:12px 16px;
      border-radius:10px;font-size:0.84rem;
      margin-bottom:20px;
    }

    /* ORDER SUMMARY */
    .summary-card{
      background:var(--dark2);
      border:1px solid rgba(255,255,255,0.07);
      border-radius:var(--radius);padding:28px;
      position:sticky;top:84px;
    }
    .summary-title{
      font-family:var(--font-head);font-size:1.1rem;font-weight:800;
      margin-bottom:20px;padding-bottom:14px;
      border-bottom:1px solid rgba(255,255,255,0.06);
    }
    .summary-item{
      display:flex;justify-content:space-between;
      font-size:0.85rem;color:var(--muted);
      margin-bottom:10px;
    }
    .summary-item .name{color:var(--text)}
    .summary-divider{
      height:1px;background:rgba(255,255,255,0.06);
      margin:14px 0;
    }
    .summary-row{
      display:flex;justify-content:space-between;
      font-size:0.875rem;color:var(--muted);
      margin-bottom:10px;
    }
    .summary-row.total{
      font-family:var(--font-head);font-weight:800;
      font-size:1.15rem;color:var(--white);
      margin-top:14px;padding-top:14px;
      border-top:1px solid rgba(255,255,255,0.06);
    }
    .place-order-btn{
      width:100%;background:var(--orange);color:#fff;
      border:none;border-radius:10px;padding:15px;
      font-family:var(--font-head);font-size:1rem;font-weight:700;
      cursor:pointer;transition:background 0.2s,transform 0.15s;
      margin-top:18px;
    }
    .place-order-btn:hover{
      background:var(--orange-lt);transform:translateY(-1px);
    }
    .secure-note{
      display:flex;align-items:center;justify-content:center;
      gap:6px;font-size:0.75rem;color:#555;margin-top:14px;
    }

    @media(max-width:768px){
      .page{grid-template-columns:1fr}
      .summary-card{position:static}
    }
  </style>
</head>
<body>

<!-- NAV -->
<nav>
  <a href="callingRestaurant" class="nav-logo">Food<span>App</span></a>
  <a href="cart" class="back-btn">← Back to Cart</a>
</nav>

<div class="page">

  <!-- LEFT: CHECKOUT FORM -->
  <div>

    <!-- Error message -->
    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
      <div class="alert-error">⚠ <%= error %></div>
    <% } %>

    <!-- Logged User Info -->
    <div class="section-card">
      <div class="section-card-title">👤 Delivering to</div>
      <div class="user-info-row">
        <div class="user-avatar">👋</div>
        <div>
          <div class="user-name"><%= user.getUsername() %></div>
          <div class="user-email"><%= user.getEmail() %></div>
        </div>
      </div>
    </div>

    <!-- Checkout Form -->
    <div class="section-card">
      <div class="section-card-title">📦 Delivery Details</div>

      <form action="checkout" method="post" id="checkoutForm">

        <!-- Delivery Address -->
        <div class="form-group">
          <label>Delivery Address</label>
          <textarea name="deliveryAddress" rows="3"
                    placeholder="Enter your full delivery address..."
                    required><%= user.getAddress() %></textarea>
        </div>

        <!-- Payment Mode -->
        <div class="form-group">
          <label>Payment Mode</label>
          <select name="paymentMode" required>
            <option value="Cash on Delivery">💵 Cash on Delivery</option>
            <option value="UPI">📱 UPI</option>
            <option value="Credit Card">💳 Credit Card</option>
            <option value="Debit Card">💳 Debit Card</option>
            <option value="Net Banking">🏦 Net Banking</option>
          </select>
        </div>

      </form>
    </div>

  </div>

  <!-- RIGHT: ORDER SUMMARY -->
  <div class="summary-card">
    <div class="summary-title">🧾 Order Summary</div>

    <!-- Cart Items -->
    <% for (CartItem item : items) { %>
      <div class="summary-item">
        <span class="name">
          <%= item.getItemName() %> × <%= item.getQuantity() %>
        </span>
        <span>₹<%= (int) item.getSubtotal() %></span>
      </div>
    <% } %>

    <div class="summary-divider"></div>

    <!-- Totals -->
    <div class="summary-row">
      <span>Subtotal</span>
      <span>₹<%= (int) cart.getTotalPrice() %></span>
    </div>
    
    <!-- Place Order Button — submits the form -->
    <button class="place-order-btn"
            onclick="document.getElementById('checkoutForm').submit()">
      🛒 Place Order →
    </button>

    <div class="secure-note">🔒 Secure checkout · 100% safe payments</div>
  </div>

</div>
</body>
</html>