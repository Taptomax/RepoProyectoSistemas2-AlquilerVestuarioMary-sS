document.addEventListener('DOMContentLoaded', function() {
    const toggleBtn = document.querySelector('.toggle-sidebar');
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.main-content');
    
    toggleBtn.addEventListener('click', function() {
        sidebar.classList.toggle('collapsed');
        if (sidebar.classList.contains('collapsed')) {
            sidebar.style.width = '0';
            mainContent.style.marginLeft = '0';
        } else {
            sidebar.style.width = window.innerWidth > 768 ? 'var(--sidebar-width)' : '70px';
            mainContent.style.marginLeft = window.innerWidth > 768 ? 'var(--sidebar-width)' : '70px';
        }
    });
    
    const navItems = document.querySelectorAll('.nav-item');
    navItems.forEach(item => {
        item.addEventListener('click', function() {
            navItems.forEach(i => i.classList.remove('active'));
            this.classList.add('active');
        });
    });
});

document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('menu-clientes').addEventListener('click', function() {
        window.location.href = 'gestionar_clientes.php';
    });

    document.getElementById('menu-renta').addEventListener('click', function() {
        window.location.href = 'registrar_renta.php';
    });

    document.getElementById('menu-devolucion').addEventListener('click', function() {
        window.location.href = 'registrar_devolucion.php';
    });
    
    document.getElementById('menu-logout').addEventListener('click', function() {
        window.location.href = '../logOut.php';
    });
});