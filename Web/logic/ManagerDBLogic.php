<?php

include('../includes/Connection.php');
// Fecha actual y un mes atrás
$conn = Connection();
$hoy = date('Y-m-d');
$mesAtras = date('Y-m-d', strtotime('-1 month'));

// 1. Ganancias mensuales (sumar Total donde FechaDevuelto no es null y FechaRenta entre hace un mes y hoy)
$sqlGanancias = "SELECT SUM(Total) AS gananciasMensuales 
                 FROM Renta 
                 WHERE FechaDevuelto IS NOT NULL 
                   AND FechaRenta BETWEEN ? AND ?";
$stmt = $conn->prepare($sqlGanancias);
$stmt->bind_param("ss", $mesAtras, $hoy);
$stmt->execute();
$result = $stmt->get_result();
$gananciasMensuales = $result->fetch_assoc()['gananciasMensuales'] ?? 0;

// 2. Prendas rentadas este mes (sumar Cantidad de DetalleRenta donde Renta.FechaRenta entre hace un mes y hoy)
$sqlPrendas = "SELECT SUM(DR.Cantidad) AS prendasMensuales
               FROM DetalleRenta DR
               JOIN Renta R ON DR.RentaID = R.RentaID
               WHERE R.FechaRenta BETWEEN ? AND ?";
$stmt = $conn->prepare($sqlPrendas);
$stmt->bind_param("ss", $mesAtras, $hoy);
$stmt->execute();
$result = $stmt->get_result();
$prendasMensuales = $result->fetch_assoc()['prendasMensuales'] ?? 0;

// 3. Rentas activas aún vigentes (FechaDevuelto es null y FechaDevolucion > hoy)
$sqlActivas = "SELECT COUNT(*) AS rentasActivas
               FROM Renta
               WHERE FechaDevuelto IS NULL AND FechaDevolucion > ?";
$stmt = $conn->prepare($sqlActivas);
$stmt->bind_param("s", $hoy);
$stmt->execute();
$result = $stmt->get_result();
$rentasActivas = $result->fetch_assoc()['rentasActivas'] ?? 0;

// 4. Rentas atrasadas (FechaDevuelto es null y FechaDevolucion < hoy)
$sqlAtrasadas = "SELECT COUNT(*) AS rentasAtrasadas
                 FROM Renta
                 WHERE FechaDevuelto IS NULL AND FechaDevolucion < ?";
$stmt = $conn->prepare($sqlAtrasadas);
$stmt->bind_param("s", $hoy);
$stmt->execute();
$result = $stmt->get_result();
$rentasAtrasadas = $result->fetch_assoc()['rentasAtrasadas'] ?? 0;

// Las variables que puedes usar en el dashboard:
/// $gananciasMensuales
/// $prendasMensuales
/// $rentasActivas
/// $rentasAtrasadas
?>