<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mary'sS - Dashboard Administrativo</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="../Resources/imgs/MarysSLogoIcon.png">
    <link rel="stylesheet" href="../CSS/ManagerDB.css">
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <div class="sidebar-header">
                <a href="../index.php">
                    <img src="../Resources/imgs/MarysSLogoST.png" alt="Logo" class="MarysSLogo"/>
                    <h1>Mary'sS</h1>
                </a>
            </div>
            <div class="sidebar-nav">
                <div class="nav-item active" id="menu-dashboard">
                    <i class="fas fa-home"></i>
                    <span>Home</span>
                </div>
                <div class="nav-item" id="menu-reportes">
                    <i class="fas fa-chart-bar"></i>
                    <span>Reportes</span>
                </div>
                <div class="nav-item" id="menu-rentactiva">
                    <i class="fas fa-hourglass-half"></i>
                    <span>Rentas Activas</span>
                </div>
                <div class="nav-item" id="menu-rentatrasada">
                    <i class="fas fa-clock"></i>
                    <span>Rentas Atrasadas</span>
                </div>
                <div class="nav-item" id="menu-registrorentas">
                    <i class="bi bi-journal-bookmark-fill"></i>
                    <span>Registro de Rentas</span>
                </div>
                <div class="nav-item" id="menu-lote">
                    <i class="fas fa-box"></i>
                    <span>Registrar Lote</span>
                </div>
                <div class="nav-item" id="menu-renta">
                    <i class="fas fa-money-bill-wave"></i>
                    <span>Registrar Renta</span>
                </div>
                <div class="nav-item" id="menu-empleados">
                    <i class="fas fa-users-cog"></i>
                    <span>Gestionar Empleados</span>
                </div>
                <div class="nav-item" id="menu-productos">
                    <i class="fas fa-tshirt"></i>
                    <span>Gestionar Productos</span>
                </div>
                <div class="nav-item" id="menu-proveedores">
                    <i class="bi bi-truck-front-fill"></i>
                    <span>Gestionar Proveedores</span>
                </div>
            </div>
            <div class="sidebar-footer">
                <div class="nav-item" id="menu-logout">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Cerrar Sesión</span>
                </div>
            </div>
        </div>
    
        <div class="main-content">
            <div class="header">
                <div class="toggle-sidebar">
                    <i class="fas fa-bars"></i>
                </div>
                <div class="search-bar">
                </div>
                <div class="user-profile">
                <?php include('../includes/MGREMP.php');?>
                <?php include('../includes/MGREMPPerms.php'); ?>
                <?php include('../logic/ManagerDBLogic.php'); ?>
                    <!-- <span>Administrador</span>
                        <img src="/api/placeholder/40/40" alt="Usuario"> -->
                </div>
            </div>
            
            <div class="dashboard">
                <div class="stats-container">
                    <div class="stat-card primary">
                        <h3>Ingresos Mensuales</h3>
                        <div class="value"><?php echo $gananciasMensuales ?></div>
                    </div>
                    <div class="stat-card warning">
                        <h3>Disfraces Rentados</h3>
                        <div class="value"><?php echo $prendasMensuales ?></div>
                    </div>
                    <div class="stat-card success">
                        <h3>Rentas Activas</h3>
                        <div class="value"><?php echo $rentasActivas ?></div>
                    </div>
                    <div class="stat-card info">
                        <h3>Rentas Atrsadas</h3>
                        <div class="value"><?php echo $rentasAtrasadas ?></div>
                    </div>
                </div>
                
                <div class="charts-container">
                    <div class="chart-card">
                        <h3>
                            Tendencia de Alquileres
                            <span>Este año</span>
                        </h3>
                        <div class="chart-content">
                            <div style="width: 100%; height: 100%; display: flex; flex-direction: column; justify-content: space-between;">
                                <div style="display: flex; justify-content: space-between; height: 80%;">
                                    <div style="display: flex; flex-direction: column; justify-content: space-between;">
                                        <span>100</span>
                                        <span>80</span>
                                        <span>60</span>
                                        <span>40</span>
                                        <span>20</span>
                                        <span>0</span>
                                    </div>
                                    <div style="flex-grow: 1; display: flex; align-items: flex-end; padding-left: 20px;">
                                        <div style="background-color: var(--primary); width: 30px; height: 60%; margin-right: 10px;"></div>
                                        <div style="background-color: var(--info); width: 30px; height: 75%; margin-right: 10px;"></div>
                                        <div style="background-color: var(--primary); width: 30px; height: 45%; margin-right: 10px;"></div>
                                        <div style="background-color: var(--info); width: 30px; height: 90%; margin-right: 10px;"></div>
                                        <div style="background-color: var(--primary); width: 30px; height: 65%; margin-right: 10px;"></div>
                                        <div style="background-color: var(--info); width: 30px; height: 80%; margin-right: 10px;"></div>
                                    </div>
                                </div>
                                <div style="display: flex; justify-content: space-around; margin-top: 10px;">
                                    <span>Ene</span>
                                    <span>Feb</span>
                                    <span>Mar</span>
                                    <span>Abr</span>
                                    <span>May</span>
                                    <span>Jun</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="chart-card">
                        <h3>
                            Categorías Populares
                            <span>Último mes</span>
                        </h3>
                        <div class="chart-content">
                            <div style="width: 200px; height: 200px; border-radius: 50%; background: conic-gradient(var(--primary) 0% 25%, var(--info) 25% 55%, var(--success) 55% 75%, var(--warning) 75% 100%); position: relative;">
                                <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 100px; height: 100px; border-radius: 50%; background-color: white; display: flex; align-items: center; justify-content: center; font-weight: bold;">
                                    Total: 453
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="calendar-events-container">
                    <div class="chart-card">
                        <h3>
                            Disfraces Más Populares
                            <span>Ver todos</span>
                        </h3>
                        <div class="costume-card">
                            <div class="costume-img">
                                <i class="fas fa-mask"></i>
                            </div>
                            <div class="costume-info">
                                <h4>Disfraz de Superhéroe</h4>
                                <p>Talla M | ID: 1234</p>
                                <span class="status rented">Rentado</span>
                            </div>
                        </div>
                        <div class="costume-card">
                            <div class="costume-img">
                                <i class="fas fa-hat-wizard"></i>
                            </div>
                            <div class="costume-info">
                                <h4>Bruja Elegante</h4>
                                <p>Talla S | ID: 2156</p>
                                <span class="status available">Disponible</span>
                            </div>
                        </div>
                        <div class="costume-card">
                            <div class="costume-img">
                                <i class="fas fa-crown"></i>
                            </div>
                            <div class="costume-info">
                                <h4>Princesa Encantada</h4>
                                <p>Talla L | ID: 3378</p>
                                <span class="status maintenance">Mantenimiento</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="chart-card">
                        <h3>
                            Próximos Eventos
                            <span>Ver calendario</span>
                        </h3>
                        <div class="event-list">
                            <div class="costume-card">
                                <div class="costume-img" style="background-color: rgba(255, 107, 138, 0.1); color: var(--primary);">
                                    <i class="fas fa-calendar-day"></i>
                                </div>
                                <div class="costume-info">
                                    <h4>Carnaval Municipal</h4>
                                    <p>15 de Abril, 2025</p>
                                    <p>42 reservas anticipadas</p>
                                </div>
                            </div>
                            <div class="costume-card">
                                <div class="costume-img" style="background-color: rgba(138, 79, 255, 0.1); color: var(--secondary);">
                                    <i class="fas fa-calendar-day"></i>
                                </div>
                                <div class="costume-info">
                                    <h4>Fiesta de Disfraces Universitaria</h4>
                                    <p>28 de Abril, 2025</p>
                                    <p>27 reservas anticipadas</p>
                                </div>
                            </div>
                            <div class="costume-card">
                                <div class="costume-img" style="background-color: rgba(46, 204, 113, 0.1); color: var(--success);">
                                    <i class="fas fa-calendar-day"></i>
                                </div>
                                <div class="costume-info">
                                    <h4>Fantasía Medieval</h4>
                                    <p>10 de Mayo, 2025</p>
                                    <p>18 reservas anticipadas</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="../JS/ManagerDB.js"></script>

</body>
</html>