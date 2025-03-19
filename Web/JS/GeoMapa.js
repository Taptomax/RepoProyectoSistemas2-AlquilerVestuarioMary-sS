document.getElementById('localizarChip').onclick = function() {
    var select = document.getElementById('chipSelect');
    var selectedChipId = select.value;
    
    if (selectedChipId) {
        $.ajax({
            url: '../utils/LocalizarChip.php',
            type: 'GET',
            data: { idChip: selectedChipId },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    map.flyTo({
                        center: [response.longitud, response.latitud],
                        zoom: 17,
                        essential: true
                    });
                } else {
                    alert("No se pudieron obtener las coordenadas del chip.");
                }
            },
            error: function() {
                alert("Error al comunicarse con el servidor.");
            }
        });
    } else {
        alert("Por favor, selecciona un chip.");
    }
};

mapboxgl.accessToken = 'pk.eyJ1IjoibWFzaGxlIiwiYSI6ImNsdXU3MXZ4NTA2ZGcyanJ1dHM0eW52OHkifQ.b_pc31sucG5adN4F0--f2A';

var map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v11',
    center: [-68.1193, -16.5000],
    zoom: 12
});

var chipMarkers = {};

var geocercasGlobal = []; // Variable global para almacenar las geocercas

function obtenerGeocercas() {
    $.ajax({
        url: "../utils/ObtenerGeocercas.php",
        type: "GET",
        data: { idUser: idUser },
        dataType: "json",
        success: function(data) {
            if (data.geocercas && data.geocercas.length > 0) {
                geocercasGlobal = data.geocercas; // Guardar geocercas en la variable global
                data.geocercas.forEach(function(geocerca) {
                    generarPoligono(geocerca.vertices, geocerca.color, geocerca.idGeocerca);
                });
            } else {
                console.log("No se encontraron geocercas.");
            }
        },
        error: function(xhr, status, error) {
            console.error("Error al obtener las geocercas:", error);
        }
    });
}

const geocercas = {};

function generarPoligono(vertices, color, idGeocerca) {
    const polygon = turf.polygon([vertices]);

    geocercas[idGeocerca] = polygon;

    map.addLayer({
        'id': idGeocerca,
        'type': 'fill',
        'source': {
            'type': 'geojson',
            'data': {
                'type': 'Feature',
                'geometry': {
                    'type': 'Polygon',
                    'coordinates': [vertices]
                }
            }
        },
        'layout': {},
        'paint': {
            'fill-color': color || '#ccc',
            'fill-opacity': 0.4
        }
    });
}

var estadoChipEnGeocercas = {}; // Almacenar el estado actual de cada chip en cada geocerca

function verificarChipEnGeocercas(chip) {
    if (!chip.longitud || !chip.latitud) {
        console.log("Coordenadas no válidas para el chip:", chip.idChip);
        return;
    }

    var puntoChip = turf.point([parseFloat(chip.longitud), parseFloat(chip.latitud)]);

    geocercasGlobal.forEach(function(geocerca) {
        var poligono = turf.polygon([geocerca.vertices]);

        var estaDentro = turf.booleanPointInPolygon(puntoChip, poligono);

        var idChipGeocerca = chip.idChip + "_" + geocerca.idGeocerca;

        if (estadoChipEnGeocercas[idChipGeocerca] === undefined) {
            estadoChipEnGeocercas[idChipGeocerca] = estaDentro;
        }

        if (estaDentro && !estadoChipEnGeocercas[idChipGeocerca]) {
            console.log(`El chip ${chip.idChip} ha entrado en la geocerca ${geocerca.idGeocerca}`);
            enviarEventoChip(chip.idChip, chip.etiqueta, geocerca.idGeocerca, geocerca.etiqueta, 'entró', chip.longitud, chip.latitud);
        } else if (!estaDentro && estadoChipEnGeocercas[idChipGeocerca]) {
            console.log(`El chip ${chip.idChip} ha salido de la geocerca ${geocerca.idGeocerca}`);
            enviarEventoChip(chip.idChip, chip.etiqueta, geocerca.idGeocerca, geocerca.etiqueta, 'salió', chip.longitud, chip.latitud);
        }

        estadoChipEnGeocercas[idChipGeocerca] = estaDentro;
    });
}

function enviarEventoChip(idChip, etChip, idGeocerca, etGeocerca,accion, longitud, latitud) {
    var data = [idChip, etChip, idGeocerca, etGeocerca, accion, longitud, latitud];
    
    $.ajax({
        url: '../utils/EventoChip.php',
        type: 'POST',
        data: { evento: data },
        success: function(response) {
            console.log("Evento enviado correctamente:", response);
        },
        error: function(xhr, status, error) {
            console.error("Error al enviar el evento:", error);
        }
    });
}

function obtenerChipsYCoordenadas() {
    $.ajax({
        url: "../utils/ObtenerCoordenadas.php",
        type: "GET",
        data: { idUser: idUser },
        dataType: "json",
        success: function(data) {
            if (data.chips && data.chips.length > 0) {
                data.chips.forEach(function(chip) {
                    actualizarMarcadorChip(chip);
                    verificarChipEnGeocercas(chip); // Llamar a la función verificar para cada chip
                });
            } else {
                console.log("No se encontraron chips.");
            }
        },
        error: function(xhr, status, error) {
            console.error("Error al obtener los chips y coordenadas:", error);
        }
    });
}


function actualizarMarcadorChip(chip) {
    if (chip.longitud && chip.latitud) {
        var lngLat = [parseFloat(chip.longitud), parseFloat(chip.latitud)];
        if (chipMarkers[chip.idChip]) {
            chipMarkers[chip.idChip].setLngLat(lngLat);
            chipMarkers[chip.idChip].getPopup().setHTML(`<h3>${chip.etiqueta}</h3><p>Última actualización: ${chip.fechaHora}</p>`);
        } else {
            var el = document.createElement('div');
            el.className = 'marker';
            el.style.backgroundColor = chip.color;
            el.style.width = '10px';
            el.style.height = '10px';
            el.style.borderRadius = '50%';

            chipMarkers[chip.idChip] = new mapboxgl.Marker(el)
                .setLngLat(lngLat)
                .setPopup(new mapboxgl.Popup().setHTML(`<h3>${chip.etiqueta}</h3><p>Última actualización: ${chip.fechaHora}</p>`))
                .addTo(map);
        }
    } else {
        console.log("Coordenadas no válidas para el chip:", chip.idChip);
    }
}

function programado() {
    obtenerChipsYCoordenadas();
}

map.on('load', function() {
    obtenerGeocercas();
    obtenerChipsYCoordenadas();
    setInterval(programado, 2000);
});