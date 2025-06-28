<?php
// Database connection settings
$host = 'localhost';       // Host
$dbname = 'webvex_db';     // Database name
$user = 'root';            // MySQL username
$password = '123';            // MySQL password (leave empty if not set)

// Attempt to connect to the database
$conn = new mysqli($host, $user, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("❌ Connection failed: " . $conn->connect_error);
} else {
    echo "✅ Successfully connected to the database!<br>";
    echo "Connected to database: <strong>" . $dbname . "</strong><br>";

    // Check if table 'users' exists
    $result = $conn->query("SHOW TABLES LIKE 'users'");
    if ($result->num_rows == 1) {
        echo "✅ Table <strong>users</strong> exists.<br>";
    } else {
        echo "❌ Table <strong>users</strong> does NOT exist.<br>";
    }
}

$conn->close();
?>
