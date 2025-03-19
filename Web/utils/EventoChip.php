<?php 
include('../includes/VerifySession.php');

include('../includes/Connection.php');
$con = connection();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Verificar si el dato 'evento' está presente en la solicitud
    if (isset($_POST['evento'])) {
        // Obtener el array enviado desde el JavaScript
        $evento = $_POST['evento'];

        // Asegúrate de que $evento es un array
        if (is_array($evento)) {
            // Mostrar el contenido del array

            echo "Evento recibido:<br>";
            echo "Chip ID: " . htmlspecialchars($evento[0]) . "<br>";
            echo "Chip: " . htmlspecialchars($evento[1]) . "<br>";
            echo "Geocerca ID: " . htmlspecialchars($evento[2]) . "<br>";
            echo "Geocerca: " . htmlspecialchars($evento[3]) . "<br>";
            echo "Acción: " . htmlspecialchars($evento[4]) . "<br>";
            echo "Longitud: " . htmlspecialchars($evento[5]) . "<br>";
            echo "Latitud: " . htmlspecialchars($evento[6]) . "<br>";
        } else {
            echo "Datos no válidos.";
        }
    } else {
        echo "No se recibió ningún evento.";
    }
} else {
    echo "Método de solicitud no permitido.";
}

$geocerca_sql = "INSERT INTO reportes VALUES ('$evento[0]', '$evento[1]', '$evento[2]', '$evento[3]', '$evento[4]', $evento[5], $evento[6], NOW())";
if (!mysqli_query($con, $geocerca_sql)) {
    die("Error al insertar el reporte: " . mysqli_error($con));
}
?>
