package dao;

import config.DBConnection;
import model.Video;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SaveDAO {

    public boolean saveVideo(int userId, int videoId) {
        String sql = "INSERT INTO saved_videos (user_id, video_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, videoId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean unsaveVideo(int userId, int videoId) {
        String sql = "DELETE FROM saved_videos WHERE user_id = ? AND video_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, videoId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isSaved(int userId, int videoId) {
        String sql = "SELECT 1 FROM saved_videos WHERE user_id = ? AND video_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, videoId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Video> getSavedVideos(int userId) {
        List<Video> list = new ArrayList<>();
        String sql = "SELECT v.*, u.username AS uploader_username, u.profile_picture AS uploader_profile_picture, u.user_id AS uploader_user_id "
                   + "FROM saved_videos s "
                   + "JOIN videos v ON s.video_id = v.video_id "
                   + "JOIN users u ON v.user_id = u.user_id "
                   + "WHERE s.user_id = ? ORDER BY s.saved_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
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
                    list.add(video);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}