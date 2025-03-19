<?php
include('../includes/Connection.php');
include('../includes/VerifySession.php');
$con = connection();

$idUser = $_SESSION['idUser'];
$coordenadas = json_decode($_POST['coordenadas'], true); // Convertir las coordenadas de JSON a array

// Generar un ID único para la geocerca
function generarIdGeocerca($con) {
    $sql = "SELECT MAX(idGeocerca) AS ultimo_id FROM geocercas";
    $result = mysqli_query($con, $sql);
    $lastId = "GCR-000";

    if ($result && mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        $lastId = $row['ultimo_id'];

        $lastDigit = intval(substr($lastId, 4)) + 1;
        $newId = str_pad($lastDigit, 3, '0', STR_PAD_LEFT);
        return 'GCR-' . $newId;
    }
    return $lastId;
}

$idGeocerca = generarIdGeocerca($con);

// Insertar geocerca
$geocerca_sql = "INSERT INTO geocercas (idUser, idGeocerca) VALUES ('$idUser', '$idGeocerca')";
if (!mysqli_query($con, $geocerca_sql)) {
    die("Error al insertar la geocerca: " . mysqli_error($con));
}

// Insertar vértices
$primerVertice = null; // Para almacenar el primer vértice
foreach ($coordenadas as $index => $coordenada) {
    $longitud = $coordenada[0];
    $latitud = $coordenada[1];

    if ($index == 0) {
        $primerVertice = $coordenada; // Guardar el primer vértice
    }

    $vertices_sql = "INSERT INTO geoVertices (idGeocerca, longitud, latitud) VALUES ('$idGeocerca', '$longitud', '$latitud')";
    if (!mysqli_query($con, $vertices_sql)) {
        die("Error al insertar los vértices: " . mysqli_error($con));
    }
}

// Insertar nuevamente el primer vértice para cerrar el polígono
if ($primerVertice) {
    $longitud = $primerVertice[0];
    $latitud = $primerVertice[1];

    $primerVertice_sql = "INSERT INTO geoVertices (idGeocerca, longitud, latitud) VALUES ('$idGeocerca', '$longitud', '$latitud')";
    if (!mysqli_query($con, $primerVertice_sql)) {
        die("Error al insertar el primer vértice nuevamente: " . mysqli_error($con));
    }
}

header("Location: ../views/ManageGeocercas.php");
?>
