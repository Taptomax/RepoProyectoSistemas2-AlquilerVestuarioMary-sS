// Seleccionar elementos del DOM
const menuToggle = document.getElementById('menuToggle');
const navMenu = document.getElementById('navMenu');

// Agregar evento para alternar el menú en dispositivos móviles
menuToggle.addEventListener('click', function () {
    navMenu.classList.toggle('active'); // Agrega o quita la clase 'active' al menú
});

// Cerrar el menú al hacer clic en un enlace (opcional para mejor experiencia en móvil)
const menuLinks = navMenu.querySelectorAll('a');
menuLinks.forEach(link => {
    link.addEventListener('click', function () {
        navMenu.classList.remove('active'); // Cierra el menú
    });
});

// Asegurarse de que el menú esté cerrado al redimensionar la ventana
window.addEventListener('resize', function () {
    if (window.innerWidth > 768) {
        navMenu.classList.remove('active'); // Oculta el menú en pantallas grandes
    }
});
