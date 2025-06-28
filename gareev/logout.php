<?php
session_start();

// Удаляем сессию
if (isset($_SESSION['username'])) {
    unset($_SESSION['username']);
}

// Удаляем куки
if (isset($_COOKIE['user'])) {
    setcookie('user', '', time() - 3600, '/');
}

session_destroy();

echo "<h1>Вы вышли из системы</h1>";
echo "<a href='authorization.html'>Войти снова</a>";
?>
