import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.nio.file.Files;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

@WebServlet("/AddProductServlet")
@MultipartConfig(maxFileSize = 16177215) // upload file's size up to 16MB
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // MySQL database connection settings
    private final String dbURL = "jdbc:mysql://localhost:3306/mydatabase";
    private final String dbUser = "root";
    private final String dbPass = "root";
    
    // SQL statement to create the table if it doesn't exist
    private final String createTableSQL = "CREATE TABLE IF NOT EXISTS products (\n" + 
                                           "id INT NOT NULL AUTO_INCREMENT,\n" +
                                           "name VARCHAR(50) NOT NULL,\n" +
                                           "price DECIMAL(10, 2) NOT NULL,\n" +
                                           "quantity INT NOT NULL,\n" +
                                           "image VARCHAR(255),\n" +
                                           "PRIMARY KEY (id)\n" +
                                           ");";
    
    // SQL statement to insert data into the table
    private final String insertSQL = "INSERT INTO products (name, price, quantity, image) VALUES (?, ?, ?, ?)";
    
    // Method to establish a database connection
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(dbURL, dbUser, dbPass);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response content type
        response.setContentType("text/html");
        
        // Get form data from request
        String name = request.getParameter("product-name");
        double price = Double.parseDouble(request.getParameter("product-price"));
        int quantity = Integer.parseInt(request.getParameter("product-quantity"));
        Part imagePart = request.getPart("product-image");
        InputStream image = imagePart.getInputStream();

        String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString(); // Get the filename

        response.getWriter().println(Paths.get("../../View/Images/Uploads/" + fileName));
        //Files.copy(image, Paths.get("../../" + fileName)); // Save the file to the specified path
        Files.copy(image, Paths.get("../../View/Images/Uploads/" + fileName)); // Save the file to the specified path


        try {
            // Create table if it doesn't exist
            try (Connection conn = getConnection(); PreparedStatement createTableStmt = conn.prepareStatement(createTableSQL)) {
                createTableStmt.executeUpdate();
            }
            
            // Insert data into table
            try (Connection conn = getConnection(); PreparedStatement insertStmt = conn.prepareStatement(insertSQL)) {
                insertStmt.setString(1, name);
                insertStmt.setDouble(2, price);
                insertStmt.setInt(3, quantity);
                insertStmt.setString(4, fileName);
                insertStmt.executeUpdate();

            }
            
            // Redirect back to the main page
            response.sendRedirect("/Lux_Attire/View/admin/productlist.jsp");
        } catch (SQLException ex) {
            ex.printStackTrace();
            response.getWriter().println("Failed to insert product into database.");
        }
    }
}
