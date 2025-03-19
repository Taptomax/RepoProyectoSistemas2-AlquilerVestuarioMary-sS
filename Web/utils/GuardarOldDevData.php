<?php
include('../includes/Connection.php');
$con = connection();
include('../includes/VerifySession.php');

$idUser = $_SESSION['idUser'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $idChip = $_POST['idChip'];
    $nuevaEtiqueta = $_POST['nuevaEtiqueta'];
    $nuevoColor = $_POST['nuevoColor'];

    // Actualiza solo la geocerca específica en la base de datos
    $query = "UPDATE chip SET etiqueta = ?, color = ? WHERE idChip = ? AND idUser = ?";
    $stmt = $con->prepare($query);
    $stmt->bind_param("sssi", $nuevaEtiqueta, $nuevoColor, $idChip, $idUser);

    if ($stmt->execute()) {
        echo "Dispositivo actualizado correctamente.";
    } else {
        echo "Error al actualizar la dispositiva: " . $stmt->error;
    }

    $stmt->close();
}
$con->close();
header("Location: ../views/ManageDevices.php");
?>
