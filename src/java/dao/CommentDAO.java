package dao;

import config.DBConnection;
import model.Comment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    public boolean addComment(Comment comment) {
        String sql = "INSERT INTO comments (video_id, user_id, comment) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, comment.getVideoId());
            ps.setInt(2, comment.getUserId());
            ps.setString(3, comment.getComment());
            
            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Comment> getCommentsByVideoId(int videoId) {
        List<Comment> list = new ArrayList<>();
        String sql = "SELECT c.*, u.username FROM comments c JOIN users u ON c.user_id = u.user_id WHERE c.video_id = ? ORDER BY c.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, videoId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Comment comment = new Comment();
                    comment.setCommentId(rs.getInt("comment_id"));
                    comment.setVideoId(rs.getInt("video_id"));
                    comment.setUserId(rs.getInt("user_id"));
                    comment.setUsername(rs.getString("username"));
                    comment.setComment(rs.getString("comment"));
                    comment.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(comment);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}