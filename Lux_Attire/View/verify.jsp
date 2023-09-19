<%@ page import="java.sql.*" %>
<%
// retrieve the username attribute from the session
String dashboardUrl = "/Lux_Attire/View/user/userprofile.jsp";
int userId = 0;
try{
    userId = (int) session.getAttribute("userId");
}catch(Exception e){
}

Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "root");
    
    String query = "SELECT user_type FROM users WHERE id = ?";
    stmt = conn.prepareStatement(query);
    stmt.setInt(1, userId);
    rs = stmt.executeQuery();
    
    if (rs.next()) {
        int userType = rs.getInt("user_type");
        if (userType == 2) {
            dashboardUrl = "/Lux_Attire/View/admin/addproduct.jsp";
        }
    }

} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace();
} finally {
    try {
        if (rs != null) {
            rs.close();
        }
        if (stmt != null) {
            stmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>
