<%@ include file="verify.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>About Us</title>
    <style>
    body {
        background-color: #171616;
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }
    
    .container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
    }
    
    header {
        background-color: #333;
        color: #fff;
        text-align: center;
        padding: 20px;
    }
    
    h1 {
        animation: fadeIn 1.5s ease-in-out forwards;
        font-size: 36px;
        margin: 0;
    }
    
    h2 {
        animation: fadeIn 2s ease-in-out forwards;
        font-size: 24px;
        margin-top: 40px;
    }

    @keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

    h1, h2, p{
        color: #f8f9fa;
    }
    
    p {
        animation: fadeIn 4s ease-in-out forwards;
        font-size: 16px;
        line-height: 1.5;
        margin-top: 20px;
    }

    footer {
        background-color: #333;
        color: #333;
        text-align: center;
        padding: 10px;
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
            color: #171616;
            font-family: "Times New Roman", serif;
            font-size: 38px;
            margin-bottom: 30px;
            animation: fadeIn 2s ease-in-out forwards;
        }

        #welcome p {
            color: #171616;
            font-size: 19px;
            margin-bottom: 30px;
            animation: fadeIn 3s ease-in-out forwards;
        }

		footer{
			color: #fff;
			text-align: center;
			margin-bottom: 10px;
			animation: fadeIn 5s ease-in-out forwards;
}

    </style>
</head>
<body>
    <header>
        <h1 style = "font-family: Times New Roman, serif;"> Lux Attire </h1>
    </header>
    <nav>
		<ul>
			<li><a href=home.jsp">Home</a></li>
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
        <p> <i> Since 2022 </i> </p>
      </section>
        <div class="container">
            <h2>About Lux Attire</h2>
            <p>
                Lux Attire is a brand of Nepal, located in the heart of the city, Kathmandu.
                Here at Lux Attire, we deliver you the finest quality of fabrics, designed and produced by World class
                designers and clothing producers.
                With years of experience in the industry, we aim to reach the customer's expectations and
                satisfaction.
            </p>
            <h2>Our Team</h2>
            <p>
                Our team consists of World class designers and clothing producers working together with a particular objective
                to meet customers requirements and receive full satisfaction.
                Our team contains a group of professionals from all over the Nepal with years of experience on clothing industry.
                
            </p>
        </div>
    <footer>
        <p>Contact Us: Luxattire@gmail.com | Phone: 51-5282889</p>
        <p>&copy; 2023 Lux Attire. All rights reserved.</p>

    </footer>
</body>
</html>