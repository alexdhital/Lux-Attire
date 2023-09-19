<%@ include file="verify.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <title>Add Product</title>
  <style>
    body {
        font-family: Arial, sans-serif;
      display: flex;
      background: linear-gradient(90deg,#0b0b0b , #505050);
      background-color: #f5f5f5;
    }
    .nav {
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
            padding:10px;
        }
        nav ul li a:hover {
            background-color: #fff;
            color: #333;
            border-radius: 5px;
        }

    .add-product {
        color: #fff;
        margin-top: 60px;
        margin-left: 120px;
      background-color: #353232;
      max-width: 400px;
      padding: 40px;
      border-radius: 5px;
    }

    h1, h2{
        text-align: center;
      margin-top: 0; 
    }


    .add-product h2 {
        font-size: 22px;
      text-align: center;
      margin-top: 0;
    }
    .add-product label{
        font-size: 18px;
        padding: 3px;
    }

    .add-product input {
      display: block;
      width: 100%;
      padding: 9px;
      margin-bottom: 10px;
      border: 1px solid #9e9999;
      border-radius: 5px;
    }

    .add-product button {
      display: block;
      width: 100%;
      padding: 10px;
      background-color: #007bff;
      color: #fff;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .add-product button:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
    <nav>
		<ul>
            <li><a href="addproduct.jsp">Add Product</a></li>
			<li><a href="productlist.jsp">Product List</a></li>
			<li><a href="/Lux_Attire/View/home.jsp">Home</a></li>
			<li><a href="orderlist.jsp">Orders</a></li>
			<li><a href="/Lux_Attire/clearSessionServlet">logout</a></li>
		</ul>
	</nav>
    <section id = "add-products">


      <% 
        // Establish database connection
        int id = Integer.parseInt(request.getParameter("id"));
        
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "root");
      
        // Fetch data from the "products" table
        String query = "SELECT * FROM products WHERE id = ?";
        PreparedStatement statement = conn.prepareStatement(query);
        statement.setInt(1, id);
        ResultSet productResultSet = statement.executeQuery();

        // Loop through the result set and display data in the table
        if (productResultSet.next()) {
          int productId = productResultSet.getInt("id");
          String name = productResultSet.getString("name");
          double price = productResultSet.getDouble("price");
          int quantity = productResultSet.getInt("quantity");
      %>
  <div class="add-product">
    <h1>Welcome, Admin.</h1>
    <h2>Add Products</h1>
    <form method="POST" action="/Lux_Attire/updateProductServlet" enctype='multipart/form-data'>

      <label for="name">Product Name:</label>
      <input type="text" value="<% out.print(name); %>" id="name" name="name" placeholder="Enter product name">
      
      <input type="hidden" name="id" value="<%=productId%>">

      <label for="price">Product Price:</label>
      <input type="number" id="price" value="<% out.print(price); %>" name="price" placeholder="Enter product price">

      <label for="quantity">Product Quantity:</label>
      <input type="number" id="quantity" name="quantity" value="<% out.print(quantity); %>" placeholder="Enter product quantity">
      <label for="image">Product Image:</label>
      <input type="file" id="image" name="image" accept="image/*">

      <button type="submit">Edit Product</button>
      <% } %>
    </form>
  </div>
</section>
</body>
</html>