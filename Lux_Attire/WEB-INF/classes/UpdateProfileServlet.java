import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.annotation.MultipartConfig;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/UpdateProfileServlet")
@MultipartConfig(maxFileSize = 16177215) // upload file's size up to 16MB
public class UpdateProfileServlet extends HttpServlet {

  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int userId = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");
    // Part imagePart = request.getPart("image");

    // validate input
    if (name.isEmpty() || address.isEmpty() || phone.isEmpty()) {
      response.sendRedirect("/Lux_Attire/View/user/userprofile.jsp?error=Please fill in all required fields.");
      return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    InputStream imageStream = null;

    try {
      // connect to the database
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "root");

      // prepare SQL statement
      String sql = "UPDATE users SET name=?, address=?, phone=?, image=? WHERE id=?";
      stmt = conn.prepareStatement(sql);
      stmt.setString(1, name);
      stmt.setString(2, address);
      stmt.setString(3, phone);

      // handle image upload
    //   if (imagePart != null && imagePart.getSize() > 0) {
    //     imageStream = imagePart.getInputStream();
    //     stmt.setBlob(4, imageStream);
    //   } else {
    //     stmt.setNull(4, java.sql.Types.BLOB);
    //   }

        stmt.setNull(4, java.sql.Types.VARCHAR);




    stmt.setInt(5, userId);

      // execute SQL statement
      int rowsAffected = stmt.executeUpdate();

      if (rowsAffected > 0) {
        response.sendRedirect("/Lux_Attire/View/user/userprofile.jsp");
      } else {
        response.sendRedirect("/Lux_Attire/View/user/userprofile.jsp?error=Unable to update profile.");
      }

    } catch (ClassNotFoundException e) {
      e.printStackTrace();
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      try {
        if (stmt != null) {
          stmt.close();
        }
        if (conn != null) {
          conn.close();
        }
        if (imageStream != null) {
          imageStream.close();
        }
      } catch (SQLException e) {
        e.printStackTrace();
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }
}
