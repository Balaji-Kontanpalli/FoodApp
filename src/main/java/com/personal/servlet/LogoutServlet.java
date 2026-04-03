package com.personal.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getSession().invalidate();    // clear all session data
        resp.sendRedirect("login");       // back to login page
    }
}

/*---

## Complete Flow
```
/login  (GET)  → login.jsp
/login  (POST) → LoginServlet
                   ↓ valid Admin    → admin-dashboard.jsp
                   ↓ valid Customer → callingRestaurant
                   ↓ invalid        → login.jsp (error msg)

/signup (GET)  → signup.jsp
/signup (POST) → SignupServlet
                   ↓ success → login.jsp (success msg)
                   ↓ fail    → signup.jsp (error msg)

/logout (GET)  → session.invalidate() → login.jsp
```

---

## Package Structure
```
com.personal.servlet
    ├── RestaurantServlet.java
    ├── MenuServlet.java
    ├── LoginServlet.java      ← new
    ├── SignupServlet.java     ← new
    └── LogoutServlet.java     ← new

com.project.dao
    ├── RestaurantDao.java
    ├── MenuDao.java
    └── UserDao.java           ← new

com.project.daoimpl
    ├── RestaurantDaoImpl.java
    ├── MenuDaoImpl.java
    └── UserDaoImpl.java       ← new

com.project.model
    ├── Restaurant.java
    ├── MenuItem.java
    └── User.java              ← new

webapp/
    ├── login.jsp              ← new
    ├── signup.jsp             ← new
    ├── restaurant.jsp
    └── menu.jsp


*/