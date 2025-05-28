<?php include('VerifySession.php'); ?>

<?php if (isset($_SESSION['idUser']) && isset($_SESSION['username'])): ?>
    <b>Bienvenido, <?php echo htmlspecialchars($_SESSION['username']); ?></b>
<?php else: ?>
    <b><i class="bi bi-exclamation-diamond" aria-hidden="true"></i>Algo falló, inicia sesión nuevamente.</b>
<?php endif; ?>