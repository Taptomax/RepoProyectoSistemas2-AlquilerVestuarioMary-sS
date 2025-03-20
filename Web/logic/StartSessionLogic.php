<?php
session_start();
include('../includes/Connection.php');

date_default_timezone_set('America/La_Paz');

define('MAX_LOGIN_ATTEMPTS', 3);
define('LOCKOUT_TIME', 0.5 * 60);

if (isset($_SESSION['idUser']) && isset($_SESSION['username'])) {
    $prefix = strtoupper(substr($_SESSION['idUser'], 0, 3));
    if($prefix == 'EMP'){
        header("Location: GeoMapa.php");
    }
    elseif($prefix == 'MGR'){
        header("Location: GeoMapa.php");
    }
    exit();
}

function isSystemLocked() {
    if (isset($_SESSION['lockout_time'])) {
        $time_left = $_SESSION['lockout_time'] - time();
        if ($time_left > 0) {
            return $time_left;
        } else {
            unset($_SESSION['login_attempts']);
            unset($_SESSION['lockout_time']);
            return false;
        }
    }
    return false;
}

function incrementLoginAttempts() {
    if (!isset($_SESSION['login_attempts'])) {
        $_SESSION['login_attempts'] = 1;
    } else {
        $_SESSION['login_attempts']++;
        
        if ($_SESSION['login_attempts'] >= MAX_LOGIN_ATTEMPTS) {
            $_SESSION['lockout_time'] = time() + LOCKOUT_TIME;
            return true;
        }
    }
    return false;
}

function getRemainingAttempts() {
    if (!isset($_SESSION['login_attempts'])) {
        return MAX_LOGIN_ATTEMPTS;
    }
    $remaining = MAX_LOGIN_ATTEMPTS - $_SESSION['login_attempts'];
    return max(0, $remaining);
}

$error = '';
$lockout_time_left = isSystemLocked();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($lockout_time_left) {
        $minutes = ceil($lockout_time_left / 60);
        $error = "Sistema bloqueado. Intente nuevamente en $minutes minutos.";
    } else {
        $username = filter_input(INPUT_POST, 'username', FILTER_SANITIZE_STRING);
        $password = $_POST['password'];

        if (empty($username) || empty($password)) {
            $error = "Por favor, complete todos los campos.";
        } else {
            $con = connection();
            $stmt = $con->prepare("SELECT empleadoID, usuario, Keyword  FROM UsuarioEmp WHERE usuario = ? OR correo = ?");
            $stmt->bind_param("ss", $username, $username);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows === 1) {
                $user = $result->fetch_assoc();
                if (password_verify($password, $user['password'])) {
                    unset($_SESSION['login_attempts']);
                    unset($_SESSION['lockout_time']);
                    
                    $_SESSION['idUser'] = $user['idUser'];
                    $_SESSION['username'] = $user['username'];

                    // Registrar actividad de inicio de sesión
                    $fecha_hora = date('Y-m-d H:i:s'); // Obtener la fecha y hora actual
                    $accion = 1; // 1 para inicio de sesión

                    // Inserción en la tabla de registro de actividad
                    $stmt_activity = $con->prepare("INSERT INTO RegActividad (idUser, username, fecha_hora, accion) VALUES (?, ?, ?, ?)");
                    $stmt_activity->bind_param("sssi", $_SESSION['idUser'], $_SESSION['username'], $fecha_hora, $accion);
                    $stmt_activity->execute();
                    $stmt_activity->close();

                    $stmt->close();
                    $con->close();
                    header("Location: ../views/GeoMapa.php");
                    exit();
                } else {
                    if (incrementLoginAttempts()) {
                        $error = "Sistema bloqueado por exceder el número máximo de intentos. Por favor, espere " . (LOCKOUT_TIME / 60) . " minutos.";
                    } else {
                        $remaining = getRemainingAttempts();
                        $error = "Usuario o contraseña incorrectos. ";
                    }
                }
            } else {
                if (incrementLoginAttempts()) {
                    $error = "Sistema bloqueado por exceder el número máximo de intentos. Por favor, espere " . (LOCKOUT_TIME / 60) . " minutos.";
                } else {
                    $remaining = getRemainingAttempts();
                    $error = "Usuario o contraseña incorrectos. ";
                }
            }
            $stmt->close();
            $con->close();
        }
    }
}

if ($lockout_time_left) {
    $minutes = ceil($lockout_time_left / 60);
    $error = "Sistema bloqueado. Intente nuevamente en $minutes minutos.";
}
?>
