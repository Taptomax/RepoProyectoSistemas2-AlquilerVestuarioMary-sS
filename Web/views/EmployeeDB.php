<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mary'sS - Dashboard Administrativo</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
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
                    <span>Dashboard</span>
                </div>
                <div class="nav-item" id="menu-renta">
                    <i class="fas fa-money-bill-wave"></i>
                    <span>Registrar Renta</span>
                </div>
                <div class="nav-item" id="menu-devolucion">
                    <i class="fas fa-money-bill-wave"></i>
                    <span>Registrar Devolución</span>
                </div>
                <div class="nav-item" id="menu-clientes">
                    <i class="fas fa-user-friends"></i>
                    <span>Gestionar Clientes</span>
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
                </div>
            </div>
            
            <div class="dashboard">
                <div class="stats-container">
                    <div class="stat-card primary">
                        <h3>Ingresos Mensuales</h3>
                        <div class="value">$4,820</div>
                    </div>
                    <div class="stat-card warning">
                        <h3>Disfraces Rentados</h3>
                        <div class="value">87</div>
                    </div>
                    <div class="stat-card success">
                        <h3>Nuevos Clientes</h3>
                        <div class="value">42</div>
                    </div>
                    <div class="stat-card info">
                        <h3>Eventos Próximos</h3>
                        <div class="value">12</div>
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
                
                <div class="charts-container">
                    <div class="chart-card">
                        <h3>
                            Distribución Geográfica de Clientes
                            <span>Último trimestre</span>
                        </h3>
                        <div class="map-container">
                            <div style="text-align: center;">
                                <i class="fas fa-map-marked-alt" style="font-size: 48px; margin-bottom: 10px;"></i>
                                <p>Mapa de distribución de clientes</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="../JS/EmployeeDB.js"></script>

</body>
</html>