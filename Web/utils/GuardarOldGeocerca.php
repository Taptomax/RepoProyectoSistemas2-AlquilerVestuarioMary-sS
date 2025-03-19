<?php
include('../includes/Connection.php');
$con = connection();
include('../includes/VerifySession.php');

$idUser = $_SESSION['idUser'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $idGeocerca = $_POST['idGeocerca'];
    $nuevaEtiqueta = $_POST['nuevaEtiqueta'];
    $nuevoColor = $_POST['nuevoColor'];

    // Actualiza solo la geocerca específica en la base de datos
    $query = "UPDATE geocercas SET etiqueta = ?, color = ? WHERE idGeocerca = ? AND idUser = ?";
    $stmt = $con->prepare($query);
    $stmt->bind_param("sssi", $nuevaEtiqueta, $nuevoColor, $idGeocerca, $idUser);

    if ($stmt->execute()) {
        echo "Geocerca actualizada correctamente.";
    } else {
        echo "Error al actualizar la geocerca: " . $stmt->error;
    }

    $stmt->close();
}
$con->close();
header("Location: ../views/ManageGeocercas.php");
?>
