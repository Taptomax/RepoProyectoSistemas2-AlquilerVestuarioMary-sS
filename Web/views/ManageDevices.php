<?php include('../logic/ManageDevicesLogic.php'); ?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario de Geocercas</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="icon" type="image/png" href="../Resources/imgs/ASGILogo.png">  
    <link rel="stylesheet" href="../CSS/Manages.css">
</head>
<body>
    <div class="form-container">
        <div class="users-form">
            <img src="../Resources/imgs/ASGTLogo.png" alt="Logo" class="logo">
            <h1>Gestionar Dispositivos</h1>
        </div>
        <div class="form-group">
            <label for="deviceSelect">Selecciona el dispositivo:</label>
            <select id="deviceSelect">
                <option value="">Seleccionar Dispositivo</option>
                <?php if (!empty($geocercas)): ?>
                    <?php foreach ($geocercas as $geocerca): ?>
                        <option value="<?= htmlspecialchars($geocerca['idChip']); ?>" data-etiqueta="<?= htmlspecialchars($geocerca['etiqueta']); ?>" data-color="<?= htmlspecialchars($geocerca['color']); ?>">
                            <?= htmlspecialchars($geocerca['etiqueta']); ?>
                        </option>
                    <?php endforeach; ?>
                <?php else: ?>
                    <option value="">No hay geocercas disponibles</option>
                <?php endif; ?>
            </select>
        </div>

        <!-- Input para cambiar la etiqueta -->
        <div class="form-group">
            <label for="nuevaEtiqueta">Nueva Etiqueta:</label>
            <input type="text" id="nuevaEtiqueta" placeholder="Introduce nueva etiqueta">
        </div>

        <!-- Input para cambiar el color -->
        <div class="form-group">
            <label for="nuevoColor">Nuevo Color (Código Hexadecimal):</label>
            <input type="text" id="nuevoColor" placeholder="#FFFFFF" value="#ccc">
            <div class="color-preview" id="colorPreview"></div>
        </div>

        <!-- Botones alineados -->
        <div class="button-container">
            <button id="guardarCambios" class="guardar">Guardar</button>
            <button onclick="window.location.href='Reportes.php';">Generar Reporte</button>
            <button onclick="window.location.href='GeoMapa.php';">Volver</button>
        </div>
    </div>

    <script src="../JS/ManageDevices.js"></script>
</body>
</html>
