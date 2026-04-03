<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.User"%>

<%
  User user = (User) session.getAttribute("loggedUser");
  if (user == null) {
      response.sendRedirect("login");
      return;
  }
  int    orderId     = (int)    request.getAttribute("orderId");
  double totalAmount = (double) request.getAttribute("totalAmount");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Order Placed! – FoodApp</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet"/>
  <style>
    :root{
      --orange:#FF5200;--dark:#0D0D0D;--dark2:#1A1A1A;
      --text:#F5F5F5;--muted:#999;--green:#48C774;--white:#fff;
      --font-head:'Syne',sans-serif;--font-body:'DM Sans',sans-serif;
    }
    *{box-sizing:border-box;margin:0;padding:0}
    body{
      min-height:100vh;background:var(--dark);
      display:flex;align-items:center;justify-content:center;
      font-family:var(--font-body);color:var(--text);
      background-image:radial-gradient(ellipse 60% 60% at 50% 0%,
        rgba(72,199,116,0.08) 0%,transparent 65%);
    }
    a{text-decoration:none;color:inherit}
    .success-card{
      background:var(--dark2);
      border:1px solid rgba(72,199,116,0.2);
      border-radius:20px;padding:48px 40px;
      max-width:480px;width:100%;text-align:center;
      box-shadow:0 24px 64px rgba(0,0,0,0.5);
    }
    .check-icon{
      width:80px;height:80px;border-radius:50%;
      background:rgba(72,199,116,0.12);
      border:2px solid rgba(72,199,116,0.3);
      display:flex;align-items:center;justify-content:center;
      font-size:2.2rem;margin:0 auto 24px;
      animation:pop 0.4s ease;
    }
    @keyframes pop{
      0%  {transform:scale(0)}
      80% {transform:scale(1.1)}
      100%{transform:scale(1)}
    }
    h1{
      font-family:var(--font-head);font-size:1.8rem;
      font-weight:800;letter-spacing:-0.5px;margin-bottom:10px;
    }
    .sub{font-size:0.9rem;color:var(--muted);margin-bottom:28px;line-height:1.7}
    .order-details{
      background:#151515;border-radius:12px;
      padding:18px 20px;margin-bottom:28px;
      border:1px solid rgba(255,255,255,0.05);
      text-align:left;
    }
    .order-row{
      display:flex;justify-content:space-between;
      font-size:0.85rem;padding:6px 0;
      border-bottom:1px solid rgba(255,255,255,0.04);
    }
    .order-row:last-child{border-bottom:none}
    .order-row .label{color:var(--muted)}
    .order-row .value{font-weight:600;color:var(--text)}
    .order-row .value.green{color:var(--green)}
    .btn-home{
      display:inline-block;background:var(--orange);color:#fff;
      padding:13px 32px;border-radius:10px;
      font-family:var(--font-head);font-weight:700;font-size:0.95rem;
      transition:background 0.2s,transform 0.15s;margin-right:10px;
    }
    .btn-home:hover{background:#FF7A3D;transform:translateY(-1px)}
    .btn-outline{
      display:inline-block;
      border:1.5px solid rgba(255,255,255,0.12);color:var(--muted);
      padding:13px 24px;border-radius:10px;
      font-family:var(--font-head);font-weight:700;font-size:0.95rem;
      transition:all 0.2s;
    }
    .btn-outline:hover{border-color:var(--orange);color:var(--orange)}
  </style>
</head>
<body>
<div class="success-card">

  <div class="check-icon">✓</div>

  <h1>Order Placed! 🎉</h1>
  <p class="sub">
    Thank you, <strong><%= user.getUsername() %></strong>!<br/>
    Your order has been placed successfully and is being prepared.
  </p>

  <div class="order-details">
    <div class="order-row">
      <span class="label">Order ID</span>
      <span class="value">#<%= orderId %></span>
    </div>
    <div class="order-row">
      <span class="label">Total Paid</span>
      <span class="value">₹<%= (int)(totalAmount + 5) %></span>
    </div>
    <div class="order-row">
      <span class="label">Status</span>
      <span class="value green">● Pending</span>
    </div>
    <div class="order-row">
      <span class="label">Estimated Time</span>
      <span class="value">30 – 45 minutes</span>
    </div>
  </div>

  <a href="callingRestaurant" class="btn-home">Back to Home</a>
  <a href="callingRestaurant" class="btn-outline">Order More</a>

</div>
</body>
</html>