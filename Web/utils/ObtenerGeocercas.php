<?php
include('../includes/Connection.php');
session_start();

if (!isset($_SESSION['idUser'])) {
    echo json_encode(["geocercas" => []]);
    exit();
}

$con = connection();
$idUser = $_SESSION['idUser'];

$query = "SELECT idGeocerca, color, etiqueta, (SELECT GROUP_CONCAT(CONCAT('[', longitud, ',', latitud, ']')) FROM geoVertices WHERE idGeocerca = g.idGeocerca) AS vertices 
          FROM geocercas g WHERE idUser = '$idUser'";

$result = mysqli_query($con, $query);

$geocercas = [];
while ($row = mysqli_fetch_assoc($result)) {
    $vertices = json_decode("[" . $row['vertices'] . "]");
    $geocercas[] = [
        'idGeocerca' => $row['idGeocerca'],
        'color' => $row['color'],
        'etiqueta' => $row['etiqueta'],
        'vertices' => $vertices
    ];
}

echo json_encode(["geocercas" => $geocercas]);
mysqli_close($con);
?>