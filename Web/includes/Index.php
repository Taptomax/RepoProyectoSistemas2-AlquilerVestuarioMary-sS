<?php if (isset($_SESSION['idUser']) && isset($_SESSION['username'])): ?>
            <span class="username">Bienvenido, <?php echo htmlspecialchars($_SESSION['username']); ?>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-double-down" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M1.646 6.646a.5.5 0 0 1 .708 0L8 12.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708"/>
                <path fill-rule="evenodd" d="M1.646 2.646a.5.5 0 0 1 .708 0L8 8.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708"/>
            </svg>
            </span>
            <div class="dropdown-panel">
                <a href="views/GeoMapa.php">Ir al Mapa</a>
                <a href="logOut.php">Cerrar Sesión</a>
            </div>
        <?php else: ?>
            <a href="views/SignIn.php">Sign Up</a>
            <a href="views/StartSession.php">Login</a>
        <?php endif; ?>