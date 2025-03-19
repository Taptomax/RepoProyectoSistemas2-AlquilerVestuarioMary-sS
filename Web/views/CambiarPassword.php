<?php include("../logic/CambiarPasswordLogic.php");?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cambiar Contraseña</title>
    <link rel="icon" type="image/png" href="../Resources/imgs/ASGILogo.png">
    <link rel="stylesheet" href="../CSS/Formularios.css">
</head>
<body>
    <div class="users-form">
        <img src="../Resources/imgs/ASGTLogo.png" alt="Company Logo">
        <h1>Nueva Contraseña</h1>
        <form action="" method="POST" id="passwordChangeForm">
            <input type="password" name="password" id="password" placeholder="Nueva contraseña" required>
            <div class="password-requirements">
                <div class="requirement" id="length">Mínimo 8 caracteres</div>
                <div class="requirement" id="uppercase">Al menos una mayúscula</div>
                <div class="requirement" id="lowercase">Al menos una minúscula</div>
                <div class="requirement" id="number">Al menos un número</div>
                <div class="requirement" id="special">Al menos un carácter especial (!@#$%^&*)</div>
            </div>
            <input type="password" name="ConPassword" id="confirmPassword" placeholder="Confirmar contraseña" required>
            <div class="requirement" id="match">Las contraseñas coinciden</div>
            <?php
            if (!empty($error)) {
                echo '<div class="error">' . htmlspecialchars($error) . '</div>';
            }
            ?>
            <input type="submit" value="Cambiar Contraseña">
        </form>
    </div>

    <script src="../JS/CambiarPassword.js"></script>

</body>
</html>