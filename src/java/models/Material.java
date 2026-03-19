package models;

public class Material {
    private int materialId;
    private int classId;
    private int uploadedBy;
    private String filename;
    private String url;
    private java.util.Date createdAt;
    
    // Constructors
    public Material() {}
    
    public Material(int materialId, int classId, int uploadedBy, String filename, String url) {
        this.materialId = materialId;
        this.classId = classId;
        this.uploadedBy = uploadedBy;
        this.filename = filename;
        this.url = url;
        this.createdAt = new java.util.Date();
    }
    
    // Getters and Setters
    public int getMaterialId() { return materialId; }
    public void setMaterialId(int materialId) { this.materialId = materialId; }
    
    public int getClassId() { return classId; }
    public void setClassId(int classId) { this.classId = classId; }
    
    public int getUploadedBy() { return uploadedBy; }
    public void setUploadedBy(int uploadedBy) { this.uploadedBy = uploadedBy; }
    
    public String getFilename() { return filename; }
    public void setFilename(String filename) { this.filename = filename; }
    
    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }
    
    public java.util.Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(java.util.Date createdAt) { this.createdAt = createdAt; }
}
