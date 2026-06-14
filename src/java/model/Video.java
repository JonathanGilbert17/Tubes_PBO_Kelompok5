package model;

import java.sql.Timestamp;

public class Video {

    private int videoId;
    private int userId;
    private String title;
    private String description;
    private String videoPath;
    private String thumbnailPath;
    private int views;
    private Timestamp uploadDate;
    private String uploaderUsername;
    private int likeCount;
    private boolean likedByCurrentUser;
    private String uploaderProfilePicture;
    private int uploaderUserId;

    public Video() {
    }

    public int getVideoId() {
        return videoId;
    }

    public void setVideoId(int videoId) {
        this.videoId = videoId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getVideoPath() {
        return videoPath;
    }

    public void setVideoPath(String videoPath) {
        this.videoPath = videoPath;
    }

    public String getThumbnailPath() {
        return thumbnailPath;
    }

    public void setThumbnailPath(String thumbnailPath) {
        this.thumbnailPath = thumbnailPath;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public Timestamp getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Timestamp uploadDate) {
        this.uploadDate = uploadDate;
    }
    
    public String getUploaderUsername() {
    return uploaderUsername;
    }

    public void setUploaderUsername(String uploaderUsername) {
        this.uploaderUsername = uploaderUsername;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public boolean isLikedByCurrentUser() {
        return likedByCurrentUser;
    }

    public void setLikedByCurrentUser(boolean likedByCurrentUser) {
        this.likedByCurrentUser = likedByCurrentUser;
    }
    
    public String getUploaderProfilePicture() { 
        return uploaderProfilePicture; 
    }
    
    public void setUploaderProfilePicture(String uploaderProfilePicture) { 
        this.uploaderProfilePicture = uploaderProfilePicture; 
    }

    public int getUploaderUserId() { 
        return uploaderUserId; 
    }
    
    public void setUploaderUserId(int uploaderUserId) { 
        this.uploaderUserId = uploaderUserId; 
    }

}