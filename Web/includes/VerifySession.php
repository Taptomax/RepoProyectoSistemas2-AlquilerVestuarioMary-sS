<?php 
session_start();
if (!isset($_SESSION['idUser']) && !isset($_SESSION['username'])) {
    Header("Location: ../views/StartSession.php");
}
?>