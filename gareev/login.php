<?php
session_start();

$host = 'localhost';
$dbname = 'webvex_db';
$user = 'root';
$password_db = '123'; // Пароль от БД

$conn = new mysqli($host, $user, $password_db, $dbname);

if ($conn->connect_error) {
    die("Ошибка подключения: " . $conn->connect_error);
}

// Получаем данные из формы
$username = $_POST['username'];
/* $password = $_POST['password']; */
$password = password_hash($_POST['password'], PASSWORD_DEFAULT); 



$sql = "SELECT id FROM users WHERE username='$username' AND password='$password'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $_SESSION['username'] = $username;

    // Устанавливаем cookie на 1 час
    setcookie('user', $username, time() + 3600, '/');

    header("Location: welcome.php");
    exit();
} else {
    echo "Неверные имя пользователя или пароль. <a href='authorization.html'>Попробовать снова</a>";
}

$conn->close();
?>
