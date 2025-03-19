<?php
session_start();
include('includes/Connection.php');

date_default_timezone_set('America/La_Paz');

if (isset($_SESSION['idUser']) && isset($_SESSION['username'])) {
    $con = connection();

    // Registrar actividad de cierre de sesión
    $fecha_hora = date('Y-m-d H:i:s'); // Obtener la fecha y hora actual
    $accion = 0; // 0 para cierre de sesión

    // Inserción en la tabla de registro de actividad
    $stmt_activity = $con->prepare("INSERT INTO RegActividad (idUser, username, fecha_hora, accion) VALUES (?, ?, ?, ?)");
    $stmt_activity->bind_param("sssi", $_SESSION['idUser'], $_SESSION['username'], $fecha_hora, $accion);
    $stmt_activity->execute();
    $stmt_activity->close();

    // Destruir la sesión
    session_destroy();
}

// Redirigir a la página de inicio
header("Location: index.php");
exit();
?>
