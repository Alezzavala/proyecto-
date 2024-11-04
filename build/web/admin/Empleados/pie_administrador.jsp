<script>
    // Función para alternar la visibilidad del sidebar
    function toggleMenu() {
        var sidebar = document.querySelector('.sidebar');
        if (sidebar.style.display === 'none' || sidebar.style.display === '') {
            sidebar.style.display = 'block'; // Muestra el sidebar
        } else {
            sidebar.style.display = 'none'; // Oculta el sidebar
        }
    }

    // Función para ocultar el sidebar
    function hideMenu() {
        var sidebar = document.querySelector('.sidebar');
        sidebar.style.display = 'none'; // Oculta el sidebar
    }
</script>


<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
</body>
</html>
