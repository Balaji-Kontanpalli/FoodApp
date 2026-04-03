 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.Cart, com.project.model.CartItem,
                 com.project.model.User, java.util.Collection"%>

<%
  Cart cart         = (Cart) session.getAttribute("cart");
  User loggedUser   = (User) session.getAttribute("loggedUser");
  // Use .values() to get CartItems from HashMap
  Collection<CartItem> items = (cart != null)
                               ? cart.getItems().values()
                               : null;%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Your Cart – FoodApp</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet"/>
  <style>
    :root {
      --orange:#FF5200; --orange-lt:#FF7A3D;
      --dark:#0D0D0D; --dark2:#1A1A1A; --dark3:#252525;
      --card-bg:#1E1E1E; --text:#F5F5F5; --muted:#999;
      --green:#48C774; --red:#fc8181; --white:#FFFFFF;
      --radius:14px;
      --font-head:'Syne',sans-serif; --font-body:'DM Sans',sans-serif;
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

    /* LAYOUT */
    .page{
      max-width:1100px;margin:0 auto;padding:40px 5% 80px;
      display:grid;grid-template-columns:1fr 340px;
      gap:32px;align-items:start;
    }

    /* TITLE */
    .section-title{
      font-family:var(--font-head);font-size:1.5rem;font-weight:800;
      letter-spacing:-0.5px;margin-bottom:24px;
      display:flex;align-items:center;gap:12px;
    }
    .item-count{
      background:var(--orange);color:#fff;
      font-size:0.75rem;font-weight:700;
      padding:2px 10px;border-radius:100px;
    }

    /* EMPTY */
    .empty-state{
      text-align:center;padding:80px 20px;
      background:var(--dark2);border-radius:var(--radius);
      border:1px solid rgba(255,255,255,0.05);
    }
    .empty-state .emoji{font-size:4rem;margin-bottom:16px}
    .empty-state h3{font-family:var(--font-head);font-size:1.3rem;font-weight:800;margin-bottom:10px}
    .empty-state p{font-size:0.875rem;color:var(--muted);margin-bottom:28px}
    .btn-primary{
      display:inline-block;background:var(--orange);color:#fff;
      padding:12px 28px;border-radius:10px;
      font-family:var(--font-head);font-weight:700;
      transition:background 0.2s,transform 0.15s;
    }
    .btn-primary:hover{background:var(--orange-lt);transform:translateY(-1px)}

    /* CART ITEMS */
    .cart-items{display:flex;flex-direction:column;gap:14px}
    .cart-item{
      background:var(--card-bg);
      border:1px solid rgba(255,255,255,0.05);
      border-radius:var(--radius);padding:18px 20px;
      display:flex;align-items:center;gap:16px;
      transition:border-color 0.2s;
    }
    .cart-item:hover{border-color:rgba(255,82,0,0.15)}

    .item-details{flex:1}
    .item-name{
      font-family:var(--font-head);font-size:0.95rem;
      font-weight:700;margin-bottom:4px;
    }
    .item-unit-price{font-size:0.8rem;color:var(--muted)}

    /* QTY CONTROLS */
    .qty-controls{
      display:flex;align-items:center;
      background:var(--dark3);border-radius:8px;
      border:1px solid rgba(255,255,255,0.08);overflow:hidden;
    }
    .qty-btn{
      background:transparent;border:none;
      color:var(--orange);font-size:1.1rem;font-weight:700;
      width:36px;height:36px;cursor:pointer;
      display:flex;align-items:center;justify-content:center;
      transition:background 0.2s;
    }
    .qty-btn:hover{background:rgba(255,82,0,0.12)}
    .qty-num{
      min-width:32px;text-align:center;
      font-family:var(--font-head);font-weight:700;font-size:0.95rem;
    }

    .item-subtotal{
      font-family:var(--font-head);font-size:1rem;
      font-weight:800;min-width:70px;text-align:right;
    }

    /* CLEAR CART */
    .clear-btn{
      background:transparent;
      border:1.5px solid rgba(229,62,62,0.3);
      color:var(--red);padding:8px 18px;border-radius:8px;
      font-size:0.82rem;font-weight:600;cursor:pointer;
      transition:all 0.2s;margin-top:20px;
    }
    .clear-btn:hover{background:rgba(229,62,62,0.1);border-color:var(--red)}

    /* SUMMARY CARD */
    .summary-card{
      background:var(--dark2);
      border:1px solid rgba(255,255,255,0.07);
      border-radius:var(--radius);padding:28px;
      position:sticky;top:84px;
    }
    .summary-title{
      font-family:var(--font-head);font-size:1.1rem;font-weight:800;
      margin-bottom:20px;padding-bottom:16px;
      border-bottom:1px solid rgba(255,255,255,0.06);
    }
    .summary-row{
      display:flex;justify-content:space-between;
      align-items:center;font-size:0.875rem;
      color:var(--muted);margin-bottom:12px;
    }
    .summary-row.total{
      font-family:var(--font-head);font-weight:800;
      font-size:1.1rem;color:var(--white);
      margin-top:16px;padding-top:16px;
      border-top:1px solid rgba(255,255,255,0.06);
    }
    .savings-badge{
      background:rgba(72,199,116,0.1);
      border:1px solid rgba(72,199,116,0.2);
      color:var(--green);font-size:0.78rem;font-weight:600;
      padding:6px 12px;border-radius:8px;
      text-align:center;margin-bottom:18px;
    }
    .checkout-btn{
      width:100%;background:var(--orange);color:#fff;
      border:none;border-radius:10px;padding:15px;
      font-family:var(--font-head);font-size:1rem;font-weight:700;
      cursor:pointer;transition:background 0.2s,transform 0.15s;
    }
    .checkout-btn:hover{background:var(--orange-lt);transform:translateY(-1px)}
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
  <a href="javascript:history.back()" class="back-btn">← Continue Shopping</a>
</nav>

<div class="page">

  <!-- LEFT: CART ITEMS -->
  <div>
    <div class="section-title">
      Your Cart
      <span class="item-count">
        <%= cart != null ? cart.getTotalCount() : 0 %> items
      </span>
    </div>

    <% if (cart == null || cart.isEmpty()) { %>

      <div class="empty-state">
        <div class="emoji">🛒</div>
        <h3>Your cart is empty</h3>
        <p>Looks like you haven't added anything yet.<br/>
           Explore restaurants and add your favourites!</p>
        <a href="callingRestaurant" class="btn-primary">Browse Restaurants</a>
      </div>

    <% } else { %>

      <div class="cart-items">
      <% for (CartItem item : items) { %>

        <div class="cart-item">

          <!-- Item info -->
          <div class="item-details">
            <div class="item-name"><%= item.getItemName() %></div>
            <div class="item-unit-price">₹<%= (int) item.getPrice() %> each</div>
          </div>

          <!-- Qty controls — decrease -->
          <div class="qty-controls">
            <a href="cart?action=update&type=decrease&itemId=<%= item.getId() %>">
              <button class="qty-btn">−</button>
            </a>
            <span class="qty-num"><%= item.getQuantity() %></span>
            <!-- Qty controls — increase -->
            <a href="cart?action=update&type=increase&itemId=<%= item.getId() %>">
              <button class="qty-btn">+</button>
            </a>
          </div>

          <!-- Subtotal -->
          <div class="item-subtotal">₹<%= (int) item.getSubtotal() %></div>

        </div>

      <% } %>
      </div>

      <!-- Delete entire cart -->
      <a href="cart?action=delete">
        <button class="clear-btn">🗑 Clear Entire Cart</button>
      </a>

    <% } %>
  </div>

  <!-- RIGHT: ORDER SUMMARY -->
  <div class="summary-card">
    <div class="summary-title">🧾 Order Summary</div>

    <% if (cart != null && !cart.isEmpty()) { %>

      <% for (CartItem item : items) { %>
        <div class="summary-row">
          <span><%= item.getItemName() %> × <%= item.getQuantity() %></span>
          <span>₹<%= (int) item.getSubtotal() %></span>
        </div>
      <% } %>


     
      <div class="summary-row total">
        <span>Total</span>
        <span>₹<%= (int)(cart.getTotalPrice() + 5) %></span>
      </div>
	

      <a href="checkout">
  		<button class="checkout-btn">
   			 Proceed to Checkout →
  		</button>
	 </a>

    <% } else { %>
      <p style="color:var(--muted);font-size:0.85rem;">
        Add items to see your order summary
      </p>
    <% } %>

    <div class="secure-note">🔒 Secure checkout · 100% safe payments</div>
  </div>

</div>
</body>
</html>