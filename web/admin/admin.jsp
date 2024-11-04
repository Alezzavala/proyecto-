

<!DOCTYPE html>

<html>
    <head>
        <title>Menu</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <style>
            body { 
                background-image: url('../img/7.jpg');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                height: 100vh;
                
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                padding: 20px;
            }
            
            .navbar {
                padding: 10px 10px; /* Aumenta el padding de la navbar */
            }

            .navbar-brand img {
                width: 200px; /* Aumenta el tamaño de la imagen */
                height: auto; /* Mantiene la proporción de la imagen */
            }

            .nav-link {
                font-size: 1.5rem; /* Aumenta el tamaño de la fuente */
                padding: 10px 15px; /* Aumenta el padding */
            }

            .form-control {
                height: 50px; /* Aumenta la altura del campo de búsqueda */
            }
            
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            .card-container {
                display: grid;
                grid-template-columns: repeat(4, 1fr); /* Tres columnas */
                gap: 40px; /* Espacio entre las tarjetas */
            }

            .card {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                padding: 120px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <header>
            <nav class="navbar navbar-expand-lg navbar-night bg-night">
                <div class="container-fluid">

                    <a class="navbar-brand" href="login.jsp" target="_blank">
                        <img src="img/as.png">
                    </a>
                  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                  </button>
                  <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                      <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="bienvenida.jsp">Administrador</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="inventario.jsp">Inventario</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="usuarios.jsp">Usuarios</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="empleados.jsp">Empleados</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="ventas.jsp">Ventas</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="compras.jsp">Compras</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="proveedores.jsp">Proveedores</a>
                      </li>
                    </ul>
                  </div>
                </div>
              </nav>
            
            <br>
            

            <div class="card-container">

                <div class="card">
                    <h3>Título</h3>
                    <p>Descripción breve de la tarjeta.</p>
                </div>

            </div>
            
            
        </header>
        
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    </body>
</html>
