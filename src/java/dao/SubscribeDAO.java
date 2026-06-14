package dao;

import config.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SubscribeDAO {

    public boolean subscribe(int subscriberId, int creatorId) {
        String sql = "INSERT INTO subscriptions (subscriber_id, creator_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, subscriberId);
            ps.setInt(2, creatorId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean unsubscribe(int subscriberId, int creatorId) {
        String sql = "DELETE FROM subscriptions WHERE subscriber_id = ? AND creator_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, subscriberId);
            ps.setInt(2, creatorId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isSubscribed(int subscriberId, int creatorId) {
        String sql = "SELECT 1 FROM subscriptions WHERE subscriber_id = ? AND creator_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, subscriberId);
            ps.setInt(2, creatorId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getSubscriberCount(int creatorId) {
        String sql = "SELECT COUNT(*) FROM subscriptions WHERE creator_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, creatorId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}