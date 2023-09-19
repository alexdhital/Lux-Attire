<%@ include file="verify.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <title>Product List</title>
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

.admin-panel {
    
  max-width: 900px;
  margin: auto;
  padding: 40px;
}

#admin{
text-align: center;
}

table {

  border-collapse: collapse;
  width: 100%;
}

h1{
    color: #fff;
}

th, td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}
td{
    color: #fff;
}

th {
  background-color: #f2f2f2;
}


.edit-btn, .delete-btn{
  padding: 6px 12px;
  margin-right: 7px;
  background-color: #007bff;
  color: #fff;
  border: none;
  cursor: pointer;
}

.edit-btn:hover, .delete-btn:hover{
  background-color: #0056b3;
}

</style>
</head>
<body>
    <div class="navbar">
    <nav>
		<ul>
            <li><a href="addproduct.jsp">Add Product</a></li>
			<li><a href="productlist.jsp">Product List</a></li>
			<li><a href="/Lux_Attire/View/home.jsp">Home</a></li>
			<li><a href="orderlist.jsp">Orders</a></li>
			<li><a href="/Lux_Attire/clearSessionServlet">logout</a></li>
		</ul>
	</nav>
</div>
<section id="admin"> 
  <div class="admin-panel">
    <h1>Products List</h1>
    <table>
      <tr>
        <th>S.N</th>
        <th>Product Name</th>
        <th>Price</th>
        <th>Stock Quantity</th>
        <th>Action</th>
      </tr>
      



      <% 
        // Establish database connection

        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "root");
      
        // Fetch data from the "products" table
        String query = "SELECT * FROM products";
        Statement statement = conn.createStatement();
        rs = statement.executeQuery(query);

        // Loop through the result set and display data in the table
        while (rs.next()) {
          int id = rs.getInt("id");
          String name = rs.getString("name");
          double price = rs.getDouble("price");
          int quantity = rs.getInt("quantity");
      %>
        <tr>
          <td><%= id %></td>
          <td><%= name %></td>
          <td><%= price %></td>
          <td><%= quantity %></td>
          <td>
            <form action="editproduct.jsp">
              <input type="hidden" name="id" value="<%= id %>">
              <input type="submit" value="Edit">
            </form>
            <form action="/Lux_Attire/deleteProductServlet">
              <input type="hidden" name="id" value="<%= id %>">
              <input type="submit" value="Delete">
            </form>
          </td>
        </tr>
      <% } %>
      


    </table>
    <% 
    // Close database connection
    rs.close();
    statement.close();
    conn.close();
  %>
  </div>
</section>
</body>
</html>