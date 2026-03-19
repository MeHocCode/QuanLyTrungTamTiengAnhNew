package models;

public class Payment {
    private int payId;
    private int enrollmentId;
    private double amount;
    private String method;
    private String status;
    private java.util.Date paidAt;
    private java.util.Date createdAt;
    
    // Constructors
    public Payment() {}
    
    public Payment(int payId, int enrollmentId, double amount, String method, String status) {
        this.payId = payId;
        this.enrollmentId = enrollmentId;
        this.amount = amount;
        this.method = method;
        this.status = status;
        this.paidAt = new java.util.Date();
        this.createdAt = new java.util.Date();
    }
    
    // Getters and Setters
    public int getPayId() { return payId; }
    public void setPayId(int payId) { this.payId = payId; }
    
    public int getEnrollmentId() { return enrollmentId; }
    public void setEnrollmentId(int enrollmentId) { this.enrollmentId = enrollmentId; }
    
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    
    public String getMethod() { return method; }
    public void setMethod(String method) { this.method = method; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public java.util.Date getPaidAt() { return paidAt; }
    public void setPaidAt(java.util.Date paidAt) { this.paidAt = paidAt; }
    
    public java.util.Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(java.util.Date createdAt) { this.createdAt = createdAt; }
}
