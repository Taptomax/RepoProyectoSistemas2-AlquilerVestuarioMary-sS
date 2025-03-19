mapboxgl.accessToken = 'pk.eyJ1IjoibWFzaGxlIiwiYSI6ImNsdXU3MXZ4NTA2ZGcyanJ1dHM0eW52OHkifQ.b_pc31sucG5adN4F0--f2A';
        
        var map = new mapboxgl.Map({
            container: 'map',
            style: 'mapbox://styles/mapbox/streets-v11',
            center: [-68.1193, -16.5000],
            zoom: 12
        });

        var productosDiv = document.getElementById("productosDiv");
        var contadorDiv = document.getElementById("contador");
        var markers = []; // Array para almacenar los marcadores
        var contadorPuntos = 0; // Contador de puntos

        // Función para generar colores aleatorios
        function generarColorAleatorio() {
            var letras = '0123456789ABCDEF';
            var color = '#';
            for (var i = 0; i < 6; i++) {
                color += letras[Math.floor(Math.random() * 16)];
            }
            return color;
        }

        // Manejar clics en el mapa
        map.on('click', function(e) {
            if (contadorPuntos < 10) {
                var coords = e.lngLat;
                var colorAleatorio = generarColorAleatorio();

                // Crear un nuevo div para el punto
                var newPuntoDiv = document.createElement("div");
                newPuntoDiv.classList.add("punto");

                // Agregar el contenido al div
                newPuntoDiv.innerHTML = `
                    <input type="text" value="Lng: ${coords.lng}" readonly>
                    <input type="text" value="Lat: ${coords.lat}" readonly><br>
                    <input type="color" value="${colorAleatorio}" disabled>
                    <button type="button" class="remove_punto">Eliminar</button>
                `;

                // Agregar el nuevo div al menú izquierdo
                productosDiv.appendChild(newPuntoDiv);

                // Crear un marcador en el mapa con el color aleatorio
                var el = document.createElement('div');
                el.className = 'marker';
                el.style.backgroundColor = colorAleatorio;

                var marker = new mapboxgl.Marker(el)
                    .setLngLat([coords.lng, coords.lat])
                    .addTo(map);

                // Guardar el marcador en el array junto con el div
                markers.push({ marker: marker, div: newPuntoDiv, coords: coords }); // Agregar coords al objeto
                contadorPuntos++; // Aumentar el contador de puntos
                contadorDiv.textContent = `Puntos en el mapa: ${contadorPuntos} / 10`; // Actualizar contador
            } else {
                alert("Has alcanzado el número máximo de puntos en el mapa (10).");
            }
        });

        // Eliminar punto cuando se hace clic en el botón "Eliminar"
        productosDiv.addEventListener("click", function(event) {
            if (event.target.classList.contains("remove_punto")) {
                var puntoDiv = event.target.parentNode;

                // Encontrar el marcador asociado y eliminarlo
                var index = markers.findIndex(item => item.div === puntoDiv);
                if (index !== -1) {
                    markers[index].marker.remove(); // Eliminar el marcador del mapa
                    markers.splice(index, 1); // Eliminar el marcador del array
                    contadorPuntos--; // Disminuir el contador de puntos
                    contadorDiv.textContent = `Puntos en el mapa: ${contadorPuntos} / 10`; // Actualizar contador
                }

                // Eliminar el div del punto
                puntoDiv.remove();
            }
        });

        // Función para eliminar todos los puntos y reiniciar el contador
        document.getElementById("eliminarTodo").addEventListener("click", function() {
            // Eliminar todos los marcadores del mapa
            markers.forEach(item => item.marker.remove());
            markers = []; // Reiniciar el array de marcadores
            contadorPuntos = 0; // Reiniciar el contador de puntos
            contadorDiv.textContent = `Puntos en el mapa: ${contadorPuntos} / 10`; // Actualizar contador

            // Eliminar todos los divs de puntos
            productosDiv.innerHTML = ''; // Vaciar el contenedor de puntos
        });

        // Función para guardar datos
        // Función para guardar datos
document.getElementById("guardarDatos").addEventListener("click", function() {
    if (contadorPuntos < 3) {
        alert("Debes tener al menos 3 puntos para guardar.");
    } else {
        // Crear un vector de vectores con las coordenadas
        var coordenadas = markers.map(item => [item.coords.lng, item.coords.lat]);
        
        // Hacer la petición AJAX para enviar los datos a PHP
        $.ajax({
            url: "../utils/GuardarNewGeocerca.php", // Archivo PHP que procesará los datos
            type: "POST",
            data: { 
                coordenadas: JSON.stringify(coordenadas), // Enviar las coordenadas como JSON
            },
            success: function(response) {
                window.location.href = "../views/ManageGeocercas.php";
            }
        });
    }
});

document.getElementById("volver").addEventListener("click", function() {
    const confirmacion = confirm("¿Estás seguro de que deseas volver? Los cambios no serán guardados.");
    if (confirmacion) {
        window.location.href = "../views/ManageGeocercas.php"; // Redirige a ManageGeocercas.php
    }
});