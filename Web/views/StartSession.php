<?php include('../logic/StartSessionLogic.php');?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión</title>
    <link rel="icon" type="image/png" href="../Resources/imgs/ASGILogo.png">  
    <link rel="stylesheet" href="../CSS/Formularios.css">
</head>
<body>
    <div class="users-form">
        <img src="../Resources/imgs/ASGTLogo.png" alt="Company Logo">
        <h1>Iniciar Sesión</h1>
        <form action="" method="POST">
            <input type="text" name="username" placeholder="Nombre de usuario o correo">
            <input type="password" name="password" placeholder="Contraseña">
            <?php
            if (!empty($error)) {
                echo '<div class="error">' . htmlspecialchars($error) . '</div>';
            }
            ?>
            <input type="submit" value="Iniciar Sesión">
        </form>

        <div class="register-link">
            <a href="SignIn.php">¿No tienes cuenta? Regístrate</a>
        </div>
        <div class="register-link">
            <a href="RecuperarCuenta.php">¿Olvidaste tu contraseña?</a>
        </div>
    </div>
</body>
</html>