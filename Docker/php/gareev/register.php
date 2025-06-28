<?php
$host = 'localhost';
$dbname = 'webvex_db'; 
$user = 'root';
$password = '123'; 

// Подключение к БД
$conn = new mysqli($host, $user, $password, $dbname);

if ($conn->connect_error) {
    die("Ошибка подключения: " . $conn->connect_error);
}

$username = $_POST['username'];
$password = password_hash($_POST['password'], PASSWORD_DEFAULT); // Хэшируем пароль

// Вставка пользователя в БД
$sql = "INSERT INTO users (username, password) VALUES ('$username', '$password')";

if ($conn->query($sql) === TRUE) {
    echo "Регистрация успешна! <a href='authorization.html'>Войти</a>";
} else {
    if ($conn->errno == 1062) { // 1062 - дублирование уникального поля (username)
        echo "Пользователь с таким логином уже существует. <a href='registration.html'>Попробовать снова</a>";
    } else {
        echo "Ошибка: " . $sql . "<br>" . $conn->error;
    }
}

$conn->close();
?>
