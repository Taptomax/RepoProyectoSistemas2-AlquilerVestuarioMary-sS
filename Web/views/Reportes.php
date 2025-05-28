<?php include('../logic/ReportesLogic.php'); ?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generar Reporte</title>
    <link rel="icon" type="image/png" href="../Resources/imgs/MarysSLogoIcon.png">  
    <link rel="stylesheet" href="../CSS/Formularios.css">
</head>
<body>
    <div class="form-container">
        <img src="../Resources/imgs/ASGTLogo.png" alt="Logo" class="logo">
        <h1>Generar Reporte</h1>

        <form id="reporteForm" method="POST" action="GenerarReporte.php" onsubmit="return validarFormulario();">
            <div class="form-group">
            <select id="chipSelect" name="chipSelect">
                <option value="">Seleccionar Dispositivo</option>
                <?php if (!empty($chips)): ?>
                    <?php foreach ($chips as $chip): ?>
                        <option value="<?= htmlspecialchars($chip['idChip']); ?>" data-etiqueta="<?= htmlspecialchars($chip['etiqueta']); ?>">
                            <?= htmlspecialchars($chip['etiqueta']); ?>
                        </option>
                    <?php endforeach; ?>
                <?php else: ?>
                    <option value="">No hay chips disponibles</option>
                <?php endif; ?>
                <option value="todos">Todos los dispositivos</option>
            </select>
            </div>

            <div class="form-group">
            <select id="intervalo" name="intervalo">
                <option value="">Selecciona un intervalo de tiempo</option>
                <option value="hoy">Hoy</option>
                <option value="semana">Última semana</option>
                <option value="mes">Último mes</option>
                <option value="manual">Manual</option>
            </select>
            </div>
            
            <div class="form-group" style="display:none;" id="fechasDiv">
                <label for="fechaInicio">Fecha Inicio:</label>
                <input type="date" id="fechaInicio" name="fechaInicio" disabled>
                <label for="fechaFin">Fecha Inicio:</label>
                <input type="date" id="fechaFin" name="fechaFin" disabled>
            </div>

            <div class="button-container">
                <a href="ManageDevices.php">Volver</a>
            <button type="submit" class="guardar">Generar Reporte</button>
            </div>
        </form>
    </div>

    <script src="../JS/Reportes.js"></script>
</body>
</html>
