<?php
include('../includes/Connection.php');
$con = connection();
include('../includes/VerifySession.php');


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['idGeocerca'])) {
        $idGeocerca = $_POST['idGeocerca'];
        $idUser = $_SESSION['idUser'];

        // Asegúrate de que el ID de la geocerca pertenezca al usuario
        $query = "DELETE FROM geocercas WHERE idGeocerca = ? AND idUser = ?";
        $stmt = $con->prepare($query);
        $stmt->bind_param("si", $idGeocerca, $idUser); // Asegúrate de usar el tipo correcto
        $result = $stmt->execute();

        if ($result) {
            echo "Geocerca eliminada exitosamente.";
        } else {
            echo "Error al eliminar la geocerca.";
        }

        $stmt->close();
    } else {
        echo "ID de geocerca no recibido.";
    }
}

$con->close();
?>
