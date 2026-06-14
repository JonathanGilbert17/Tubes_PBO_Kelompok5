package dao;

import config.DBConnection;
import model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Video;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public boolean register(User user) {
        String sql = "INSERT INTO users (username, email, password, profile_picture, bio) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getProfilePicture());
            ps.setString(5, user.getBio());
            
            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User login(String usernameOrEmail, String password) {
        String sql = "SELECT * FROM users WHERE (username = ? OR email = ?) AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, usernameOrEmail);
            ps.setString(2, usernameOrEmail);
            ps.setString(3, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setProfilePicture(rs.getString("profile_picture"));
                    user.setBio(rs.getString("bio"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateProfile(User user) {
        String sql = "UPDATE users SET username = ?, email = ?, profile_picture = ?, bio = ? WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getProfilePicture());
            ps.setString(4, user.getBio());
            ps.setInt(5, user.getUserId());
            
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public User getUserById(int userId) {
    String sql = "SELECT * FROM users WHERE user_id = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setProfilePicture(rs.getString("profile_picture"));
                user.setBio(rs.getString("bio"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                return user;
            }
        }
    } catch (SQLException e) { e.printStackTrace(); }
    return null;
    }

    public List<Video> getVideosByUserId(int userId) {
        List<Video> list = new ArrayList<>();
        String sql = "SELECT * FROM videos WHERE user_id = ? ORDER BY upload_date DESC";
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
                    list.add(video);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}