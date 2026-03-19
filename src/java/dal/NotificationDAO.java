package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Notification;

public class NotificationDAO extends DBContext {
    
    // CREATE
    public boolean createNotification(Notification notification) {
        String sql = "INSERT INTO notifications (user_id, type, message, is_read_flag, created_at) "
                   + "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, notification.getUserId());
            ps.setString(2, notification.getType());
            ps.setString(3, notification.getMessage());
            ps.setString(4, notification.getReadFlag());
            ps.setTimestamp(5, notification.getCreatedAt() != null ? new Timestamp(notification.getCreatedAt().getTime()) : new Timestamp(System.currentTimeMillis()));
            
            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    notification.setNotificationId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // READ - Single
    public Notification getNotificationById(int notificationId) {
        String sql = "SELECT * FROM notifications WHERE notification_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, notificationId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToNotification(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // READ - All
    public List<Notification> getAllNotifications() {
        String sql = "SELECT * FROM notifications ORDER BY created_at DESC";
        List<Notification> notifications = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                notifications.add(mapResultSetToNotification(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }
    
    // UPDATE
    public boolean updateNotification(Notification notification) {
        String sql = "UPDATE notifications SET user_id = ?, type = ?, message = ?, is_read_flag = ? "
                   + "WHERE notification_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, notification.getUserId());
            ps.setString(2, notification.getType());
            ps.setString(3, notification.getMessage());
            ps.setString(4, notification.getReadFlag());
            ps.setInt(5, notification.getNotificationId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // DELETE
    public boolean deleteNotification(int notificationId) {
        String sql = "DELETE FROM notifications WHERE notification_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, notificationId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // JOIN METHODS
    
    /**
     * Get notifications by user
     */
    public List<Notification> getNotificationsByUserId(int userId) {
        String sql = "SELECT n.*, u.name as user_name, u.email as user_email "
                   + "FROM notifications n "
                   + "JOIN users u ON n.user_id = u.user_id "
                   + "WHERE n.user_id = ? "
                   + "ORDER BY n.created_at DESC";
        List<Notification> notifications = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                notifications.add(mapResultSetToNotificationWithUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }
    
    /**
     * Get unread notifications by user
     */
    public List<Notification> getUnreadNotificationsByUserId(int userId) {
        String sql = "SELECT n.*, u.name as user_name, u.email as user_email "
                   + "FROM notifications n "
                   + "JOIN users u ON n.user_id = u.user_id "
                   + "WHERE n.user_id = ? AND n.is_read_flag = 0 "
                   + "ORDER BY n.created_at DESC";
        List<Notification> notifications = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                notifications.add(mapResultSetToNotificationWithUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }
    
    /**
     * Get notifications by type
     */
    public List<Notification> getNotificationsByType(String type) {
        String sql = "SELECT n.*, u.name as user_name, u.email as user_email "
                   + "FROM notifications n "
                   + "JOIN users u ON n.user_id = u.user_id "
                   + "WHERE n.type = ? "
                   + "ORDER BY n.created_at DESC";
        List<Notification> notifications = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, type);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                notifications.add(mapResultSetToNotificationWithUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }
    
    /**
     * Mark notification as read
     */
    public boolean markAsRead(int notificationId) {
        String sql = "UPDATE notifications SET is_read_flag = 1 WHERE notification_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, notificationId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Mark all notifications as read for user
     */
    public boolean markAllAsReadForUser(int userId) {
        String sql = "UPDATE notifications SET is_read_flag = 1 WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get notification count by user
     */
    public int getNotificationCountByUser(int userId) {
        String sql = "SELECT COUNT(*) FROM notifications WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    /**
     * Get unread notification count by user
     */
    public int getUnreadNotificationCountByUser(int userId) {
        String sql = "SELECT COUNT(*) FROM notifications WHERE user_id = ? AND is_read_flag = 0";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    /**
     * Get recent notifications (last 7 days)
     */
    public List<Notification> getRecentNotifications() {
        String sql = "SELECT n.*, u.name as user_name, u.email as user_email "
                   + "FROM notifications n "
                   + "JOIN users u ON n.user_id = u.user_id "
                   + "WHERE n.created_at >= DATEADD(day, -7, GETDATE()) "
                   + "ORDER BY n.created_at DESC";
        List<Notification> notifications = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                notifications.add(mapResultSetToNotificationWithUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }
    
    // Helper methods
    
    private Notification mapResultSetToNotification(ResultSet rs) throws SQLException {
        Notification notification = new Notification();
        notification.setNotificationId(rs.getInt("notification_id"));
        notification.setUserId(rs.getInt("user_id"));
        notification.setType(rs.getString("type"));
        notification.setMessage(rs.getString("message"));
        notification.setReadFlag(rs.getString("is_read_flag"));
        notification.setCreatedAt(rs.getTimestamp("created_at"));
        return notification;
    }
    
    private Notification mapResultSetToNotificationWithUser(ResultSet rs) throws SQLException {
        Notification notification = mapResultSetToNotification(rs);
        // Additional user info can be stored or returned as needed
        return notification;
    }
}
