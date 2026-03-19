package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Payment;

public class PaymentDAO extends DBContext {
    
    // CREATE
    public boolean processPayment(Payment payment) {
        String sql = "INSERT INTO payments (enrollment_id, amount, method, status, paid_at) "
                   + "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, payment.getEnrollmentId());
            ps.setDouble(2, payment.getAmount());
            ps.setString(3, payment.getMethod());
            ps.setString(4, payment.getStatus());
            ps.setTimestamp(5, payment.getPaidAt() != null ? new Timestamp(payment.getPaidAt().getTime()) : new Timestamp(System.currentTimeMillis()));
            
            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    payment.setPayId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // READ - Single
    public Payment getPaymentById(int paymentId) {
        String sql = "SELECT * FROM payments WHERE payment_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, paymentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToPayment(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // READ - All
    public List<Payment> getAllPayments() {
        String sql = "SELECT * FROM payments ORDER BY payment_date DESC";
        List<Payment> payments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                payments.add(mapResultSetToPayment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
    
    // UPDATE
    public boolean updatePayment(Payment payment) {
        String sql = "UPDATE payments SET enrollment_id = ?, amount = ?, method = ?, "
                   + "status = ?, paid_at = ? WHERE pay_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, payment.getEnrollmentId());
            ps.setDouble(2, payment.getAmount());
            ps.setString(3, payment.getMethod());
            ps.setString(4, payment.getStatus());
            ps.setTimestamp(5, payment.getPaidAt() != null ? new Timestamp(payment.getPaidAt().getTime()) : null);
            ps.setInt(6, payment.getPayId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // DELETE
    public boolean deletePayment(int paymentId) {
        String sql = "DELETE FROM payments WHERE pay_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, paymentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // JOIN METHODS
    
    /**
     * Get payments by student
     */
    public List<Payment> getPaymentsByStudentId(int studentId) {
        String sql = "SELECT p.*, e.class_id, c.title as course_title, u.name as student_name "
                   + "FROM payments p "
                   + "JOIN enrollments e ON p.enrollment_id = e.enrollment_id "
                   + "JOIN classes cl ON e.class_id = cl.class_id "
                   + "JOIN courses c ON cl.course_id = c.course_id "
                   + "JOIN students s ON e.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE e.student_id = ? "
                   + "ORDER BY p.paid_at DESC";
        List<Payment> payments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                payments.add(mapResultSetToPaymentWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
    
    /**
     * Get payments by enrollment
     */
    public List<Payment> getPaymentsByEnrollmentId(int enrollmentId) {
        String sql = "SELECT p.*, e.class_id, c.title as course_title, u.name as student_name "
                   + "FROM payments p "
                   + "JOIN enrollments e ON p.enrollment_id = e.enrollment_id "
                   + "JOIN classes cl ON e.class_id = cl.class_id "
                   + "JOIN courses c ON cl.course_id = c.course_id "
                   + "JOIN students s ON e.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE p.enrollment_id = ? "
                   + "ORDER BY p.paid_at DESC";
        List<Payment> payments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, enrollmentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                payments.add(mapResultSetToPaymentWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
    
    /**
     * Get payments with full details (enrollment + student + course)
     */
    public List<Payment> getPaymentsWithDetails() {
        String sql = "SELECT p.*, e.class_id, c.title as course_title, u.name as student_name, u.email as student_email "
                   + "FROM payments p "
                   + "JOIN enrollments e ON p.enrollment_id = e.enrollment_id "
                   + "JOIN classes cl ON e.class_id = cl.class_id "
                   + "JOIN courses c ON cl.course_id = c.course_id "
                   + "JOIN students s ON e.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "ORDER BY p.paid_at DESC";
        List<Payment> payments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                payments.add(mapResultSetToPaymentWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
    
    /**
     * Get successful payments
     */
    public List<Payment> getSuccessfulPayments() {
        String sql = "SELECT p.*, e.class_id, c.title as course_title, u.name as student_name "
                   + "FROM payments p "
                   + "JOIN enrollments e ON p.enrollment_id = e.enrollment_id "
                   + "JOIN classes cl ON e.class_id = cl.class_id "
                   + "JOIN courses c ON cl.course_id = c.course_id "
                   + "JOIN students s ON e.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE p.status = 'SUCCESS' "
                   + "ORDER BY p.paid_at DESC";
        List<Payment> payments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                payments.add(mapResultSetToPaymentWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
    
    /**
     * Get failed payments
     */
    public List<Payment> getFailedPayments() {
        String sql = "SELECT p.*, e.class_id, c.title as course_title, u.name as student_name "
                   + "FROM payments p "
                   + "JOIN enrollments e ON p.enrollment_id = e.enrollment_id "
                   + "JOIN classes cl ON e.class_id = cl.class_id "
                   + "JOIN courses c ON cl.course_id = c.course_id "
                   + "JOIN students s ON e.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE p.status = 'FAILED' "
                   + "ORDER BY p.paid_at DESC";
        List<Payment> payments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                payments.add(mapResultSetToPaymentWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
    
    /**
     * Get payment count by student
     */
    public int getPaymentCountByStudent(int studentId) {
        String sql = "SELECT COUNT(*) FROM payments p "
                   + "JOIN enrollments e ON p.enrollment_id = e.enrollment_id "
                   + "WHERE e.student_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, studentId);
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
     * Get total revenue by date range
     */
    public double getTotalRevenueByDateRange(java.util.Date startDate, java.util.Date endDate) {
        String sql = "SELECT SUM(p.amount) as total_revenue FROM payments p "
                   + "WHERE p.status = 'SUCCESS' "
                   + "AND p.payment_date BETWEEN ? AND ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTimestamp(1, startDate != null ? new Timestamp(startDate.getTime()) : null);
            ps.setTimestamp(2, endDate != null ? new Timestamp(endDate.getTime()) : null);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total_revenue");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }
    
    /**
     * Search payments by student name or transaction ID
     */
    public List<Payment> searchPayments(String keyword) {
        String sql = "SELECT p.*, e.class_id, c.title as course_title, u.name as student_name "
                   + "FROM payments p "
                   + "JOIN enrollments e ON p.enrollment_id = e.enrollment_id "
                   + "JOIN classes cl ON e.class_id = cl.class_id "
                   + "JOIN courses c ON cl.course_id = c.course_id "
                   + "JOIN students s ON e.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE u.name LIKE ? "
                   + "ORDER BY p.paid_at DESC";
        List<Payment> payments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                payments.add(mapResultSetToPaymentWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
    
    /**
     * Get recent payments (last 30 days)
     */
    public List<Payment> getRecentPayments() {
        String sql = "SELECT p.*, e.class_id, c.title as course_title, u.name as student_name "
                   + "FROM payments p "
                   + "JOIN enrollments e ON p.enrollment_id = e.enrollment_id "
                   + "JOIN classes cl ON e.class_id = cl.class_id "
                   + "JOIN courses c ON cl.course_id = c.course_id "
                   + "JOIN students s ON e.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE p.paid_at >= DATEADD(day, -30, GETDATE()) "
                   + "ORDER BY p.paid_at DESC";
        List<Payment> payments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                payments.add(mapResultSetToPaymentWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
    
    // Helper methods
    
    private Payment mapResultSetToPayment(ResultSet rs) throws SQLException {
        Payment payment = new Payment();
        payment.setPayId(rs.getInt("payment_id"));
        payment.setEnrollmentId(rs.getInt("enrollment_id"));
        payment.setAmount(rs.getDouble("amount"));
        payment.setMethod(rs.getString("method"));
        payment.setStatus(rs.getString("status"));
        payment.setPaidAt(rs.getTimestamp("paid_at"));
        return payment;
    }
    
    private Payment mapResultSetToPaymentWithDetails(ResultSet rs) throws SQLException {
        Payment payment = mapResultSetToPayment(rs);
        // Additional enrollment, course, and student info can be stored or returned as needed
        return payment;
    }
}
