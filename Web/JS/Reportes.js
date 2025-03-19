const intervaloSelect = document.getElementById('intervalo');
        const fechasDiv = document.getElementById('fechasDiv');
        const fechaInicioInput = document.getElementById('fechaInicio');
        const fechaFinInput = document.getElementById('fechaFin');

        intervaloSelect.addEventListener('change', function() {
            if (intervaloSelect.value === 'manual') {
                fechasDiv.style.display = 'block'; 
                fechaInicioInput.disabled = false;  
                fechaFinInput.disabled = false;
            } else {
                fechasDiv.style.display = 'none';   
                fechaInicioInput.disabled = true;   
                fechaFinInput.disabled = true;
            }
        });

        function validarFormulario() {
            const chipSelect = document.getElementById('chipSelect').value;
            const intervalo = document.getElementById('intervalo').value;
            if (chipSelect === "") {
                alert("Por favor, selecciona un chip o 'Todos los dispositivos'.");
                return false; // Evita el envío del formulario
            }
            else if (intervalo = ""){
                alert("Por favor, selecciona un intervalo de tiempo'.");
                return false;
            }
            return true; // Permite el envío del formulario
        }

        function formatearFecha(fecha) {
            const dia = ("0" + fecha.getDate()).slice(-2);
            const mes = ("0" + (fecha.getMonth() + 1)).slice(-2);
            const anio = fecha.getFullYear();
            return `${anio}-${mes}-${dia}`;
        }

        // Obtener la fecha de hoy y la fecha de hace 2 meses
        const hoy = new Date();
        const haceDosMeses = new Date();
        haceDosMeses.setMonth(haceDosMeses.getMonth() - 2);

        // Establecer las fechas mínimas y máximas en los inputs
        fechaInicioInput.max = formatearFecha(hoy);
        fechaInicioInput.min = formatearFecha(haceDosMeses);
        fechaFinInput.max = formatearFecha(hoy);
        fechaFinInput.min = formatearFecha(haceDosMeses);