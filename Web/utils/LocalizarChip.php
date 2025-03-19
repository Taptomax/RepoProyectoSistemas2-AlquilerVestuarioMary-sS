<?php
include('../includes/Connection.php');
include('../includes/VerifySession.php');

$idChip = isset($_GET['idChip']) ? $_GET['idChip'] : '';

if (empty($idChip)) {
    echo json_encode(['success' => false, 'message' => 'ID del chip no proporcionado']);
    exit;
}

$con = connection();

$query = mysqli_prepare($con, "SELECT latitud, longitud FROM coordenadas WHERE idChip = ? ORDER BY fechaHora DESC LIMIT 1");
mysqli_stmt_bind_param($query, "s", $idChip);
mysqli_stmt_execute($query);
$result = mysqli_stmt_get_result($query);

if ($row = mysqli_fetch_assoc($result)) {
    echo json_encode([
        'success' => true,
        'latitud' => $row['latitud'],
        'longitud' => $row['longitud']
    ]);
} else {
    echo json_encode(['success' => false, 'message' => 'No se encontraron coordenadas para el chip especificado']);
}

mysqli_close($con);
?>