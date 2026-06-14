package config;

import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {
        Connection conn = DBConnection.getConnection();
        if (conn != null) {
            System.out.println("Koneksi ke database vtube_db BERHASIL!");
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("Koneksi ke database vtube_db GAGAL!");
        }
    }
}