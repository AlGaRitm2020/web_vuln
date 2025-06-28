<?php
session_start();

// Проверяем сессию
if (isset($_SESSION['username'])) {
    $username = htmlspecialchars($_SESSION['username']);
} 
// Если сессии нет — проверяем куки
elseif (isset($_COOKIE['user'])) {
    $username = htmlspecialchars($_COOKIE['user']);
} else {
    echo "<h1>Доступ запрещён!</h1>";
    echo "<p><a href='authorization.html'>Войдите</a>, чтобы получить доступ.</p>";
    exit();
}
?>

<h1>Привет, <?php echo $username; ?>!</h1>
<p>Вы успешно авторизованы.</p>
<a href="logout.php">Выйти</a>
