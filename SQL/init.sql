CREATE DATABASE IF NOT EXISTS webvex_db;

USE webvex_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);
-- user: test, password: 123
INSERT INTO users (username, password) VALUES ('test', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9LLC6xZ0f7FKQE6TcG5PIHZGOm');
