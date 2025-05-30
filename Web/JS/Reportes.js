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
                return false;
            }
            else if (intervalo = ""){
                alert("Por favor, selecciona un intervalo de tiempo'.");
                return false;
            }
            return true;
        }

        function formatearFecha(fecha) {
            const dia = ("0" + fecha.getDate()).slice(-2);
            const mes = ("0" + (fecha.getMonth() + 1)).slice(-2);
            const anio = fecha.getFullYear();
            return `${anio}-${mes}-${dia}`;
        }

        const hoy = new Date();
        const haceDosMeses = new Date();
        haceDosMeses.setMonth(haceDosMeses.getMonth() - 2);

        fechaInicioInput.max = formatearFecha(hoy);
        fechaInicioInput.min = formatearFecha(haceDosMeses);
        fechaFinInput.max = formatearFecha(hoy);
        fechaFinInput.min = formatearFecha(haceDosMeses);