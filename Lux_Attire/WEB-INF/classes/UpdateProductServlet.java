import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletResponse;
import java.nio.file.Files;
import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;
import java.io.InputStream;
import java.nio.file.Paths;

@MultipartConfig(maxFileSize = 16177215) // upload file's size up to 16MB
public class UpdateProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the form data
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            Part imagePart = request.getPart("image");
            InputStream image = imagePart.getInputStream();

            String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString(); // Get the filename
            Files.copy(image, Paths.get("../../View/Images/Uploads/" + fileName)); 
 

            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            String dbUrl = "jdbc:mysql://localhost:3306/mydatabase";
            String dbUser = "root";
            String dbPassword = "root";
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Update the product in the "products" table
            String query = "UPDATE products SET name=?, price=?, quantity=?, image=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, name);
            stmt.setDouble(2, price);
            stmt.setInt(3, quantity);
            stmt.setString(4, fileName);
            stmt.setInt(5, id);
            stmt.executeUpdate();

            // Close the statement and connection
            stmt.close();
            conn.close();

            // Redirect to the product details page with the updated product
            response.sendRedirect("/Lux_Attire/View/admin/productlist.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
