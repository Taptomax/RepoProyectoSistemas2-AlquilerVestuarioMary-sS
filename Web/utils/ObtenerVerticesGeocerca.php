<?php
include('../includes/Connection.php');
$con = connection();

$idUser = isset($_GET['idUser']) ? $_GET['idUser'] : '';
$idGeocerca = isset($_GET['idGeocerca']) ? $_GET['idGeocerca'] : '';

if (empty($idUser) || empty($idGeocerca)) {
    die(json_encode(['error' => 'Se requieren idUser e idGeocerca']));
}

$stmt = $con->prepare("SELECT longitud, latitud FROM geoVertices WHERE idGeocerca = ?");
$stmt->bind_param("s", $idGeocerca);
$stmt->execute();
$result = $stmt->get_result();

if($result==null){
    die("pasaron cositas.");
}

$vertices = [];
while ($row = $result->fetch_assoc()) {
    $vertices[] = [$row['longitud'], $row['latitud']];
}

echo json_encode(['vertices' => $vertices]);

$stmt->close();
$con->close();
?>
