<?php
include('../includes/Connection.php');
$con = connection();
include('../includes/VerifySession.php');

$idUser = $_SESSION['idUser'];

// Consulta para obtener las geocercas relacionadas al usuario
$query = "SELECT idChip, etiqueta, color FROM chip WHERE idUser = ?";
$stmt = $con->prepare($query);
$stmt->bind_param("i", $idUser);
$stmt->execute();
$result = $stmt->get_result();

$geocercas = [];
while ($row = $result->fetch_assoc()) {
    $geocercas[] = $row;
}

$stmt->close();
$con->close();
?>