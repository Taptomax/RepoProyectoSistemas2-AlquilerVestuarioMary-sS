<?php include('../includes/VerifySession.php'); ?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mapa con Geocercas y Seguimiento de Chips</title>
    <link href="https://api.mapbox.com/mapbox-gl-js/v3.2.0/mapbox-gl.css" rel="stylesheet">
    <script src="https://api.mapbox.com/mapbox-gl-js/v3.2.0/mapbox-gl.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="icon" type="image/png" href="../Resources/imgs/ASGILogo.png">  
    <link rel="stylesheet" href="../CSS/AnadirGeorcerca.css">
</head>
<body>
    <div id="global">
        <div id="header">
            <img src="../Resources/imgs/ASGTLogo.png" alt="Logo de la app" />
        </div>
        <div id="menuIzquierdo"><br><br>
            <div><b>Seleccione en orden los vétices del polígono.</b> <br>
                Límite max: 10; min: 3
            </div>
            <div id="contador">Puntos en el mapa: 0 / 10</div>
            <button id="volver" style="margin-bottom: 10px;">Volver</button>
            <button id="guardarDatos" style="margin-bottom: 10px;">Guardar</button>
            <button id="eliminarTodo" style="margin-bottom: 10px;">Eliminar Todos los Puntos</button>
            <br>
            <div id="productosDiv"></div>
        </div>
        <div id="map"></div>
        <div id="footer"></div>
    </div>

    <script src="../JS/AnadirGeocerca.js"></script>

</body>
</html>
