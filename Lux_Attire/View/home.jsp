<%@ page import="java.sql.*" %>
<%@ include file="verify.jsp" %>

<!DOCTYPE html>
<html>

<head>
  <title>Home Page</title>

  <style>
    body, h1, h2, h3, p {
        margin: 0;
        padding: 0;
}

body {
    background-color: #171616;
		font-family: Arial, sans-serif;
		margin: 0;
		padding: 0;
		}

header {
      background-color: #333;
		  color: #fff;
		  padding: 20px;
		  text-align: center;
}

h1 {
      font-family: "Times New Roman", serif;
		  margin: 0;
		  font-size: 36px;
      animation: fadeIn 2s ease-in-out forwards;
}

nav {
			background-color: #333;
			color: #fff;
			display: flex;
			justify-content: space-between;
			align-items: center;
			padding: 10px;
		}
		nav ul {
			list-style: none;
			margin: 0;
			padding: 0;
			display: flex;
		}
		nav ul li {
			margin: 0 10px;
		}
		nav ul li a {
			color: #fff;
			text-decoration: none;
			padding: 5px;
		}
		nav ul li a:hover {
			background-color: #fff;
			color: #333;
			border-radius: 5px;
		}
/* Welcome section */
#welcome {
  background-image: url(Images/img2.jpeg);
  background-size: cover;
  text-align: center;
  padding: 50px;
}

#welcome h1 {
  font-size: 38px;
  margin-bottom: 30px;
  animation: fadeIn 2s ease-in-out forwards;
}

#welcome p {
  font-size: 19px;
  margin-bottom: 30px;
  animation: fadeIn 3s ease-in-out forwards;
}

#welcome .btn {
  display: inline-block;
  padding: 15px 20px;
  color: #333;
  background-color: rgb(243, 243, 236);
  text-decoration: none;
  font-size: 17px;
  border-radius: 15px;
  transition: background-color 0.3s ease-in-out;
}

#welcome .btn:hover {
  background-color: #eee6e6;
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

/* Product section */
#products {
  padding: 75px;
  color: #fff;
  text-align: center;
}

#products h2 {
  font-size: 32px;
  margin-bottom: 40px;
  animation: fadeIn 4s ease-in-out forwards;
}

.product-container {
  display: flex;
  justify-content: center;
}

.product {
  max-width: 300px;
  margin:  20px;
  padding: 20px;
  background-color:  #171616;
  text-align: center;
}

.product img {
  max-width: 100%;
  height: 290px;
  width: 290px;
  object-fit: cover;
  margin-bottom: 20px;
}

.product img:hover{
    transform: scale(1.1);
    transition: all 0.3s ease-in-out;
  
}

.product h3 {
  font-size: 18px;
  font-family: "Arial", serif;
  margin-bottom: 10px;
  animation: fadeIn 6s ease-in-out forwards;

}


.product .btn {
  margin-top: 10px;
  display: inline-block;
  padding: 15px 20px;
  color: #333;
  background-color: rgb(243, 243, 236);
  text-decoration: none;
  font-size: 17px;
  border-radius: 10px;
  transition: background-color 0.3s ease-in-out;
}

.product .btn:hover {
    background-color: #eee6e6;
    transform: scale(1.1);
    transition: all 0.3s ease-in-out;
}

/* About section */
#about {
  background-color: #333;
  padding: 75px;
  color: #fff;
  text-align: center;
}

#about h2 {
  margin: auto;
  font-size: 32px;
  margin-bottom: 40px;
  animation: fadeIn 4s ease-in-out forwards;
}
#about p {
  font-size: 18px;
  margin-bottom: 40px;
  animation: fadeIn 5s ease-in-out forwards;
}

footer{
    color: #fff;
    text-align: center;
    margin-top: 10px;
    margin-bottom: 10px;
    animation: fadeIn 10s ease-in-out forwards;
}

  </style>>
</head>

<body>
  <header>
    <h1>Lux Attire</h1>
  </header>
  <nav>
    <ul>
        <li><a href="#">Home</a></li>
        <li><a href="product.jsp">Products</a></li>
        <li><a href="about.jsp">About Us</a></li>
        <%
        if(userId != 0){
          %>
          <li><a href="<%= dashboardUrl %>">Dashboard</a></li>
    			<li><a href="/Lux_Attire/clearSessionServlet">logout</a></li>

          <%
        }else{
          %>
          <li><a href="login.html">Login</a></li>
          <%
        }
        %>
        
    </ul>
</nav>
  <section id="welcome">
    <h1>Welcome to Lux Attire</h1>
    <p> <i> Get 20% off on latest collections. </i> </p>
    <a href="product.jsp" class="btn">Shop Now</a>
  </section>
  <section id="products">
    <h2>Our Products</h2>
    <div class="product-container">




      
      <%
      // Establish database connection
      String url = "jdbc:mysql://localhost:3306/mydatabase";
      String username = "root";
      String password = "root";
      Connection connection = DriverManager.getConnection(url, username, password);

      // Execute SQL query to fetch products
      String query = "SELECT * FROM products limit 0, 3";
      PreparedStatement statement = connection.prepareStatement(query);
      ResultSet resultSet = statement.executeQuery();

      // Loop through the result set and display products
      while (resultSet.next()) {
          int id = resultSet.getInt("id");
          String name = resultSet.getString("name");
          double price = resultSet.getDouble("price");
          int quantity = resultSet.getInt("quantity");
          String image = resultSet.getString("image");
      %>
     
        <form method="POST" action="/Lux_Attire/addToCartServlet">
          <input type="hidden" name="user_id" value="<%= userId %>">
          <input type="hidden" name="product_id" value="<%= id %>">
          <input type="hidden" name="quantity" value="1">
          <div class="product">
            <img src="/Lux_Attire/View/Images/Uploads/<%= image %>" alt="<%= name %>">
            <span><%= name %></span>
            <br/>
                    <% 
                    if(userId != 0){
                        %>
                        <input type="submit" class="btn" value="Add to Cart">
                        <%
                    }else{
                        %>
                        <input type="submit" class="btn" disabled value="Login to access cart">
                        <%
                    }
                    %>
          </div>
        </form>
      <%
      }

      // Close database connection
      connection.close();
      statement.close();
      resultSet.close();
  %>
    </div>

  </section>
  <section id="about">
    <div class="about-container">
    <h2> Experience the Premium Fabrics</h2>
    <p> <i> Premium quality Silk Blend, Cotton Twill, Wool Twill, Linen, Worsted Wool, Polyester-Viscose Windowpane and other high quality 
      fibrics designed and manufactured in Nepal. A new leading pair of collection to your wardrobe. Get over 2 years of warranty on products 
      in case of any damage and get a new one. </i> </p>
    </div>
    </section>
  <footer>
    <p>&copy; 2023 Lux Attire. All rights reserved.</p>
  </footer>
</body>

</html>