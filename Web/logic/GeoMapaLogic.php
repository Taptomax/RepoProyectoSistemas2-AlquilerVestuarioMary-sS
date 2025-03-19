<?php 
    include('../includes/Connection.php');
    include('../includes/VerifySession.php');
    $message = "Bienvenido " . $_SESSION['username'] . ".";
    $con = connection();
    $idUser = $_SESSION['idUser'];
    $queryChips = mysqli_query($con, "SELECT idChip, etiqueta FROM chip WHERE idUser='$idUser'");
?>