package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Role;
import models.User;
import service.PasswordService;

/**
 *
 * @author lethe
 */
public class UserDAO extends DBContext {

    /**
     * Tìm kiếm user dựa trên tham số email và trả về user
     *
     * @param email
     * @return User
     */
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                String name = rs.getString("name");
                String userEmail = rs.getString("email");
                String password = rs.getString("password_hash");
                String roleStr = rs.getString("role");
                Role role = Role.valueOf(roleStr.toLowerCase());
                String phone = rs.getString("phone");
                String active = rs.getString("active");
                java.sql.Timestamp created_at = rs.getTimestamp("created_at");

                User user = new User(userId, name, userEmail, password, role, phone, active);
                user.setCreatedAt(created_at);
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Xác thực user với email và password
     *
     * @param email
     * @param password
     * @return User
     */
    public User authenticate(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND active = 'ACTIVE'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password_hash");
                // Use static PasswordService for proper password verification
                if (PasswordService.verifyPassword(password, storedHash)) {
                    int userId = rs.getInt("user_id");
                    String name = rs.getString("name");
                    String userEmail = rs.getString("email");
                    String roleStr = rs.getString("role");
                    Role role = Role.valueOf(roleStr.toLowerCase());
                    String phone = rs.getString("phone");
                    String active = rs.getString("active");
                    java.sql.Timestamp created_at = rs.getTimestamp("created_at");

                    User user = new User(userId, name, userEmail, storedHash, role, phone, active);
                    user.setCreatedAt(created_at);
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Cập nhật thông tin user
     *
     * @param user
     */
    public void update(User user) {
        String sql = "UPDATE users SET name = ?, phone = ?, active = ? WHERE email = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, user.getName());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getActive());
            ps.setString(4, user.getEmail());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Tạo tài khoản user
     *
     * @param user
     */
    public void createAccount(User user) {
        String sql = "INSERT INTO users (name, email, password_hash, role, phone, active) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPasswordHash());
            ps.setString(4, user.getRole().name());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getActive());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Lấy tất cả users
     *
     * @return List<User>
     */
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                int userId = rs.getInt("user_id");
                String name = rs.getString("name");
                String userEmail = rs.getString("email");
                String password = rs.getString("password_hash");
                String roleStr = rs.getString("role");
                Role role = Role.valueOf(roleStr.toLowerCase());
                String phone = rs.getString("phone");
                String active = rs.getString("active");
                java.sql.Timestamp created_at = rs.getTimestamp("created_at");

                User user = new User(userId, name, userEmail, password, role, phone, active);
                user.setCreatedAt(created_at);
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    /**
     * Lấy user theo ID
     *
     * @param id
     * @return User
     */
    public User findById(int id) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                String userEmail = rs.getString("email");
                String password = rs.getString("password_hash");
                String roleStr = rs.getString("role");
                Role role = Role.valueOf(roleStr.toLowerCase());
                String phone = rs.getString("phone");
                String active = rs.getString("active");
                java.sql.Timestamp created_at = rs.getTimestamp("created_at");

                User user = new User(id, name, userEmail, password, role, phone, active);
                user.setCreatedAt(created_at);
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Xóa user theo ID
     *
     * @param id
     */
    public void delete(int id) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Lấy users theo role
     *
     * @param role
     * @return List<User>
     */
    public List<User> findByRole(Role role) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = ? ORDER BY created_at DESC";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, role.name());
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                int userId = rs.getInt("user_id");
                String name = rs.getString("name");
                String userEmail = rs.getString("email");
                String password = rs.getString("password_hash");
                String roleStr = rs.getString("role");
                Role userRole = Role.valueOf(roleStr.toLowerCase());
                String phone = rs.getString("phone");
                String active = rs.getString("active");
                java.sql.Timestamp created_at = rs.getTimestamp("created_at");

                User user = new User(userId, name, userEmail, password, userRole, phone, active);
                user.setCreatedAt(created_at);
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }
    
    /**
     * Cập nhật profile user (bao gồm cả password nếu có)
     *
     * @param user
     * @return boolean
     */
    public boolean updateProfile(User user) {
        String sql = "UPDATE users SET name = ?, phone = ?";
        if (user.getPasswordHash() != null && !user.getPasswordHash().isEmpty()) {
            sql += ", password_hash = ?";
        }
        sql += " WHERE user_id = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;
            
            ps.setString(paramIndex++, user.getName());
            ps.setString(paramIndex++, user.getPhone());
            
            if (user.getPasswordHash() != null && !user.getPasswordHash().isEmpty()) {
                ps.setString(paramIndex++, user.getPasswordHash());
            }
            
            ps.setInt(paramIndex, user.getUserId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Kiểm tra email đã tồn tại chưa
     *
     * @param email
     * @return boolean
     */
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Cập nhật trạng thái active của user
     *
     * @param userId
     * @param active
     * @return boolean
     */
    public boolean updateStatus(int userId, String active) {
        String sql = "UPDATE users SET active = ? WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, active);
            ps.setInt(2, userId);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
