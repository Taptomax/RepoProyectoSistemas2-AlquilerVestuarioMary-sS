<?php include('../logic/RecuperarCuentaLogic.php'); ?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recuperar Cuenta</title>
    <link rel="icon" type="image/png" href="../Resources/imgs/ASGILogo.png">
    <link rel="stylesheet" href="../CSS/Formularios.css">
</head>
<body>
    <div class="users-form">
        <img src="../Resources/imgs/ASGTLogo.png" alt="Company Logo">
        <h1>Recuperar Cuenta</h1>
        <div class="description">
            Ingresa tu correo electrónico y el código de recuperación de 6 dígitos.
        </div>
        <form action="" method="POST">
            <input type="email" name="correo" placeholder="Correo electrónico" required>
            <input type="number" 
                   name="codigo" 
                   placeholder="Código de recuperación"
                   min="100000"
                   max="999999"
                   required
                   oninput="javascript: if (this.value.length > 6) this.value = this.value.slice(0, 6)">
            <?php
            if (!empty($error)) {
                echo '<div class="error">' . htmlspecialchars($error) . '</div>';
            }
            ?>
            <input type="submit" value="Continuar">
        </form>
    </div>
</body>
</html>