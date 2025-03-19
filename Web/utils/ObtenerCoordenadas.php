<?php
include('../includes/Connection.php');

function executeQuery($con, $query, $params = []) {
    $stmt = $con->prepare($query);
    if ($params) {
        $stmt->bind_param(str_repeat('s', count($params)), ...$params);
    }
    $stmt->execute();
    $result = $stmt->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);
    $stmt->close();
    return $data;
}

$idUser = isset($_GET['idUser']) ? $_GET['idUser'] : '';

if (empty($idUser)) {
    header('Content-Type: application/json');
    die(json_encode(['error' => 'Se requiere idUser']));
}

$debug_info = ['idUser' => $idUser, 'query' => ''];

try {
    $con = connection();

    $query = "CALL obtenerCoordenadaChip(?)";
    $debug_info['query'] = $query;
    
    $chipsData = executeQuery($con, $query, [$idUser]);
    $debug_info['chips_count'] = count($chipsData);
    
    $chips = array_map(function($row) {
        return [
            'idChip' => $row['idChip'],
            'etiqueta' => $row['etiqueta'],
            'longitud' => floatval($row['longitud']),
            'latitud' => floatval($row['latitud']),
            'fechaHora' => $row['fechaHora'],
            'color' => $row['color']
        ];
    }, $chipsData);
    
    $con->close();
    
    header('Content-Type: application/json');
    echo json_encode(['chips' => $chips, 'debug_info' => $debug_info]);
} catch (Exception $e) {
    error_log("Database error: " . $e->getMessage());
    header('Content-Type: application/json');
    die(json_encode(['error' => 'Error en la base de datos. Por favor, contacte al administrador.', 'debug_info' => $debug_info]));
}
?>