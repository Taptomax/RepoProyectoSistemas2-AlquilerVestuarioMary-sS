// Cambiar el color de vista previa al cambiar el valor del input de color
document.getElementById("nuevoColor").addEventListener("input", function() {
    const color = this.value;
    document.getElementById("colorPreview").style.backgroundColor = color;
});

// Al seleccionar una geocerca, llenar los campos de etiqueta y color
document.getElementById("deviceSelect").addEventListener("change", function() {
    const selectedOption = this.options[this.selectedIndex];
    const etiqueta = selectedOption.getAttribute("data-etiqueta");
    const color = selectedOption.getAttribute("data-color");

    // Llenar los campos
    document.getElementById("nuevaEtiqueta").value = etiqueta;
    document.getElementById("nuevoColor").value = color;
    document.getElementById("colorPreview").style.backgroundColor = color;
});

// Al hacer clic en "Guardar", verificar si el valor del color es hexadecimal válido
// Función para validar si el color es hexadecimal o un nombre de color CSS válido
function isValidColor(color) {
// Expresión regular para colores hexadecimales
const hexColorPattern = /^#([0-9A-F]{3}|[0-9A-F]{6})$/i;

// Lista de nombres de colores CSS válidos
const namedColors = [
"aqua", "black", "blue", "fuchsia", "gray", "green", "lime", 
"maroon", "navy", "olive", "purple", "red", "silver", "teal", "white", "yellow", "yellowgreen", "pink", "cyan"
];

// Comprobar si el color es hexadecimal o un nombre de color válido
return hexColorPattern.test(color) || namedColors.includes(color.toLowerCase());
}

// Al hacer clic en "Guardar"
document.getElementById("guardarCambios").addEventListener("click", function() {
const chip = document.getElementById("deviceSelect").value;
const nuevaEtiqueta = document.getElementById("nuevaEtiqueta").value;
const nuevoColor = document.getElementById("nuevoColor").value;
if (!chip) {
alert("Por favor, selecciona un chip.");
} else if (!isValidColor(nuevoColor)) {
alert("Por favor, introduce un color hexadecimal válido o un nombre de color CSS (ej. 'yellow' o '#FFFFFF').");
} else {
const data = new FormData();
data.append('idChip', chip);
data.append('nuevaEtiqueta', nuevaEtiqueta);
data.append('nuevoColor', nuevoColor);

// Enviar la solicitud AJAX al servidor
fetch('../utils/GuardarOldDevData.php', {
    method: 'POST',
    body: data,
})
.then(response => response.text())
.then(result => {
    alert("Datos guardados.");
    location.reload(); // Mostrar el resultado de la operación
})
.catch(error => {
    console.error('Error:', error);
    alert('Ocurrió un error al guardar la devisa.');
});
}
});