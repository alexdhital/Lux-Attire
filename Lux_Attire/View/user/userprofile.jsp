<%@ include file="verify.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <title>User Profile</title>
  <style>
    body {
        color: #f5f5f5;
        font-family: Arial, sans-serif;
      padding: 25px;
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

h1 {
  margin-top: 30px;
}

.profile-form,
.password-form{
    margin-top: 40px;
  margin-bottom: 20px;
}

form {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

label,
input,
button {
  margin-bottom: 10px;
}

button {
    padding: 10px;
    background-color: #007bff;
    border: none;
    cursor: pointer;
    border-radius: 5px;
}
button:hover{
    background-color: #0056b3;
}


  h1{
    font-size: 30px;
      color: #fff;
      padding-left: 0px;
  }
  
  </style>
</head>
<body>
  
    <div class="navbar">
        <nav>
            <ul>
                <li><a href="userprofile.jsp">Edit Profile</a></li>
                <li><a href="userorder.jsp">My Orders</a></li>
                <li><a href="/Lux_Attire/View/home.jsp">Home</a></li>
			          <li><a href="/Lux_Attire/clearSessionServlet">logout</a></li>
            </ul>
        </nav>
    </div>
  <h1>User Profile</h1>
  
  <div class="profile-form">
    <form method="POST" action="/Lux_Attire/updateProfileServlet" id="profileForm"  enctype='multipart/form-data'>
      <label for="name">Name:</label>
      <input type="hidden" name="id" value="<% out.print(userId); %>">
      <input type="text" id="name" name="name" value="<% out.print(username); %>" placeholder="Name" ><br>
      <label for="address">Address:</label>
      <input type="text" id="address" name="address" value="<% out.print(address); %>" placeholder="Address"><br>
      <label for="phone">Phone:</label>
      <input type="text" id="phone" name="phone" value="<% out.print(phone); %>" placeholder="Phone"><br>
      <label for="image">Image:</label>
      <input type="file" id="image" name="image"><br>
      <button type="submit">Save</button>
    </form>
  </div>
  <div class="password-form">
    <h2>Change Password</h2>
    <form method="POST" action="/Lux_Attire/changePasswordServlet" id="passwordForm">
      <input type="hidden" name="id" value="<% out.print(userId); %>">
      <label for="currentPassword">Current Password:</label>
      <input type="password" id="currentPassword" name="currentPassword", placeholder="Current Password"><br>
      <label for="newPassword">New Password:</label>
      <input type="password" id="newPassword" name="newPassword", placeholder="New Password"><br>
      <label for="confirmPassword">Confirm Password:</label>
      <input type="password" id="confirmPassword" name="confirmPassword", placeholder="Confirm Password"><br>
      <button type="submit">Change Password</button>
    </form>
  </div>
</body>
</html>