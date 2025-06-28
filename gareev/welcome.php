<?php
session_start();

if (!isset($_SESSION['username'])) {
    header("Location: authorization.html");
    exit();
}

echo "<h2>Добро пожаловать, " . htmlspecialchars($_SESSION['username']) . "!</h2>";
echo "<a href='logout.php'>Выйти</a>";
?>
