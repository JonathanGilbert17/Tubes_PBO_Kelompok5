package dao;

import config.DBConnection;
import model.Video;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VideoDAO {

    public boolean uploadVideo(Video video) {
        String sql = "INSERT INTO videos (user_id, title, description, video_path, thumbnail_path) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, video.getUserId());
            ps.setString(2, video.getTitle());
            ps.setString(3, video.getDescription());
            ps.setString(4, video.getVideoPath());
            ps.setString(5, video.getThumbnailPath());
            
            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Video> getAllVideos(String filter) {
        List<Video> list = new ArrayList<>();
        String orderBy = filter != null && filter.equals("most_viewed") 
            ? "v.views DESC" 
            : "v.upload_date DESC";
        String sql = "SELECT v.*, u.username AS uploader_username, u.profile_picture AS uploader_profile_picture, u.user_id AS uploader_user_id "
                   + "FROM videos v JOIN users u ON v.user_id = u.user_id "
                   + "ORDER BY " + orderBy;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapVideo(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Video> searchVideos(String keyword) {
        List<Video> list = new ArrayList<>();
        String sql = "SELECT v.*, u.username AS uploader_username, u.profile_picture AS uploader_profile_picture, u.user_id AS uploader_user_id \n" + "FROM videos v JOIN users u ON v.user_id = u.user_id \n" + "WHERE v.title LIKE ? OR v.description LIKE ? \n" + "ORDER BY v.upload_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Video video = new Video();                                                    // baris ini dulu
                    video.setVideoId(rs.getInt("video_id"));
                    video.setUserId(rs.getInt("user_id"));
                    video.setTitle(rs.getString("title"));
                    video.setDescription(rs.getString("description"));
                    video.setVideoPath(rs.getString("video_path"));
                    video.setThumbnailPath(rs.getString("thumbnail_path"));
                    video.setViews(rs.getInt("views"));
                    video.setUploadDate(rs.getTimestamp("upload_date"));
                    video.setUploaderUsername(rs.getString("uploader_username"));         // kalau ada
                    video.setUploaderProfilePicture(rs.getString("uploader_profile_picture")); // pindah ke sini
                    video.setUploaderUserId(rs.getInt("uploader_user_id"));               // pindah ke sini
                    list.add(video);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Video getVideoById(int videoId) {
    String sql = "SELECT v.*, u.username AS uploader_username, u.profile_picture AS uploader_profile_picture, u.user_id AS uploader_user_id \n" + "FROM videos v JOIN users u ON v.user_id = u.user_id \n" + "WHERE v.video_id = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, videoId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                Video video = new Video();                                                  
                video.setVideoId(rs.getInt("video_id"));
                video.setUserId(rs.getInt("user_id"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setVideoPath(rs.getString("video_path"));
                video.setThumbnailPath(rs.getString("thumbnail_path"));
                video.setViews(rs.getInt("views"));
                video.setUploadDate(rs.getTimestamp("upload_date"));
                video.setUploaderUsername(rs.getString("uploader_username"));
                video.setUploaderProfilePicture(rs.getString("uploader_profile_picture")); 
                video.setUploaderUserId(rs.getInt("uploader_user_id"));             
                return video;
                            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
    }
    
    public boolean incrementViews(int videoId) {
    String sql = "UPDATE videos SET views = views + 1 WHERE video_id = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, videoId);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private Video mapVideo(ResultSet rs) throws SQLException {
        Video video = new Video();
        video.setVideoId(rs.getInt("video_id"));
        video.setUserId(rs.getInt("user_id"));
        video.setTitle(rs.getString("title"));
        video.setDescription(rs.getString("description"));
        video.setVideoPath(rs.getString("video_path"));
        video.setThumbnailPath(rs.getString("thumbnail_path"));
        video.setViews(rs.getInt("views"));
        video.setUploadDate(rs.getTimestamp("upload_date"));
        video.setUploaderUsername(rs.getString("uploader_username"));
        video.setUploaderProfilePicture(rs.getString("uploader_profile_picture"));
        video.setUploaderUserId(rs.getInt("uploader_user_id"));
        return video;
    }
        
    
}