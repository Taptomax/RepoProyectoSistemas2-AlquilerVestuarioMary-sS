<?php 

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

if (!isset($_SESSION['idUser']) && !isset($_SESSION['username'])) {
    header("Location: ../views/StartSession.php?expired=1");
}

if (isset($_SESSION['expire_time']) && time() > $_SESSION['expire_time']) {
    session_unset();
    session_destroy();
    header("Location: ../views/StartSession.php?expired=1");
    exit();
}
?>