<?php
session_start();

$host = 'localhost';
$dbname = 'webvex_db';
$user = 'root';
$password = '';

$conn = new mysqli($host, $user, $password, $dbname);

if ($conn->connect_error) {
    die("Ошибка подключения: " . $conn->connect_error);
}

$username = $_POST['username'];
$password = $_POST['password'];

// Поиск пользователя по логину
$sql = "SELECT id, username, password FROM users WHERE username='$username'";
$result = $conn->query($sql);

if ($result->num_rows == 1) {
    $row = $result->fetch_assoc();
    if (password_verify($password, $row['password'])) {
        // Пароль совпадает
        $_SESSION['username'] = $username;
        header("Location: welcome.php");
        exit();
    } else {
        echo "Неверный пароль. <a href='authorization.html'>Попробовать снова</a>";
    }
} else {
    echo "Пользователь не найден. <a href='registration.html'>Зарегистрироваться?</a>";
}

$conn->close();
?>
