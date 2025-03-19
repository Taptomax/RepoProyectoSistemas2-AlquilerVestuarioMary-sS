<?php
include('../includes/Connection.php');
$con = connection();
include('../includes/VerifySession.php');

$idUser = $_SESSION['idUser'];

// Consulta para obtener los chips relacionados al usuario
$query = "SELECT idChip, etiqueta FROM chip WHERE idUser = ?";
$stmt = $con->prepare($query);
$stmt->bind_param("i", $idUser);
$stmt->execute();
$result = $stmt->get_result();

$chips = [];
while ($row = $result->fetch_assoc()) {
    $chips[] = $row;
}
?>