<?php
session_start();

// Verificar si hay datos de registro en la sesión
if (!isset($_SESSION['temp_registration'])) {
    header("Location: ../Views/SignIn.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['codigo_recuperacion'])) {
        $codigo = $_POST['codigo_recuperacion'];
        
        // Recuperar los datos temporales de registro
        $datos_registro = $_SESSION['temp_registration'];
        
        // Conectar a la base de datos
        include('../includes/Connection.php');
        $con = connection();
        
        // Generar ID de usuario
        $nuevoId = $datos_registro['nuevoId'];
        $username = $datos_registro['username'];
        $correo = $datos_registro['correo'];
        $hashed_password = $datos_registro['hashed_password'];
        
        // Insertar nuevo usuario con código de recuperación
        $stmt = $con->prepare("INSERT INTO usuario (idUser, username, correo, password, CRecuperacion) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("sssss", $nuevoId, $username, $correo, $hashed_password, $codigo);
        //echo "<script>console.log('$nuevoId, $username, $correo, $hashed_password, $codigo')</script>";

        if ($stmt->execute()) {
            // Limpiar datos temporales
            unset($_SESSION['temp_registration']);
            
            // Crear sesión con el id y username
            $_SESSION['idUser'] = $nuevoId;
            $_SESSION['username'] = $username;
            
            $stmt->close();
            $con->close();
            
            header("Location: ../views/GeoMapa.php");
            exit();
        } else {
            $error = 'Hubo un error al registrar el usuario';
            $stmt->close();
            $con->close();
        }
    }
}
?>