-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-11-2024 a las 01:01:55
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `newdb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `idCliente` int(11) NOT NULL,
  `nombres` varchar(60) DEFAULT NULL,
  `apellidos` varchar(60) DEFAULT NULL,
  `nit` varchar(12) DEFAULT NULL,
  `genero` bit(1) DEFAULT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `correo_electronico` varchar(45) DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`idCliente`, `nombres`, `apellidos`, `nit`, `genero`, `telefono`, `correo_electronico`, `fecha_ingreso`) VALUES
(2, 'Marlon', 'Lopez', '7878869', b'0', '44466592', 'marlon@gmail.com', '1995-10-10 00:00:00'),
(3, 'Kateryn', 'Perez', '65656523', b'1', '65656539', 'katy@gmail.com', '1999-10-23 00:00:00'),
(4, 'Pedro', 'Renta ', '1236547', b'1', '65987469', 'pedroren@gmail.com', '2010-12-06 00:00:00'),
(5, 'Julieta ', 'Ponce ', '13664693', b'0', '15639827', 'julieta@gmail.com', '2006-11-14 00:00:00'),
(6, 'Martin', 'Rios', '12365893', b'1', '56987133', 'martin21@gmal.com', '2008-06-02 00:00:00'),
(7, 'Efrain', 'Casas', '3698521', b'1', '78965234', 'efrain12@gmail.com', '1996-10-05 12:00:00'),
(8, 'Valentina', 'Laverde', '963285173', b'0', '26002503', 'valentina56@gmail.com', '2011-05-20 06:30:00'),
(9, 'Juan ', 'Corral', '230056931', b'1', '63036939', 'juan28@gmail.com', '0185-01-01 01:20:00'),
(10, 'Jorge', 'Cruz', '69325679', b'1', '12332', 'jorge98@gmail.com', '1999-02-05 10:30:00'),
(24, 'Juan', 'Perez', '123', b'0', '1231', 'jorge98@gmail.com', '2024-10-15 21:27:22'),
(25, 'maria', 'ochoa', '123', b'1', '1231', 'jorge98@gmail.com', '2024-10-15 21:54:02'),
(26, 'Maria', 'Ochoa', '69325679', b'1', '12345678', 'jorge98@gmail.com', '2024-10-23 21:52:01'),
(27, 'PErro', 'Ochoa', '69325679', b'1', '12345678', 'jorge98@gmail.com', '2024-10-27 08:58:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `idCompra` int(11) NOT NULL,
  `no_orden_compra` int(11) DEFAULT NULL,
  `idproveedor` int(11) DEFAULT NULL,
  `fecha_orden` date DEFAULT NULL,
  `fechaingreso` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`idCompra`, `no_orden_compra`, `idproveedor`, `fecha_orden`, `fechaingreso`) VALUES
(2, 10002, 101, '2024-10-13', '2024-10-16 09:45:00'),
(3, 10003, 101, '2024-10-14', '2024-10-17 17:11:00'),
(4, 10004, 105, '2024-10-15', '2024-10-18 18:16:00'),
(5, 10005, 104, '2024-10-16', '2024-10-19 10:15:00'),
(6, 10006, 103, '2024-10-16', '2024-10-20 04:30:00'),
(7, 10007, 102, '2024-10-17', '2024-10-21 11:00:00'),
(8, 10008, 102, '2024-10-18', '2024-10-22 01:45:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras_detalle`
--

CREATE TABLE `compras_detalle` (
  `idCompra_detalle` bigint(20) NOT NULL,
  `idcompra` int(11) DEFAULT NULL,
  `idproducto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio_costo_unitario` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `compras_detalle`
--

INSERT INTO `compras_detalle` (`idCompra_detalle`, `idcompra`, `idproducto`, `cantidad`, `precio_costo_unitario`) VALUES
(1, 5, 12, 20, 550.00),
(2, NULL, NULL, 30, 60.00),
(3, NULL, NULL, 60, 400.00),
(4, NULL, NULL, 25, 95.00),
(5, NULL, NULL, 10, 150.00),
(6, NULL, NULL, 80, 325.00),
(7, NULL, NULL, 60, 500.00),
(8, 5, 14, 25, 430.00),
(9, NULL, NULL, 30, 250.00),
(11, 4, 12, 5, 300.04),
(13, 4, 16, 20, 40.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `idEmpleado` int(11) NOT NULL,
  `nombres` varchar(60) DEFAULT NULL,
  `apellidos` varchar(60) DEFAULT NULL,
  `direccion` varchar(80) DEFAULT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `DPI` varchar(15) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `idPuesto` smallint(6) DEFAULT NULL,
  `fecha_inicio_labores` date DEFAULT NULL,
  `fechaingreso` datetime DEFAULT current_timestamp(),
  `genero` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`idEmpleado`, `nombres`, `apellidos`, `direccion`, `telefono`, `DPI`, `fecha_nacimiento`, `idPuesto`, `fecha_inicio_labores`, `fechaingreso`, `genero`) VALUES
(1, 'Daniel', 'Hernández', 'Guatemala', '12345678', '123456789369', '0980-01-01', 2, '2023-01-01', '2023-01-01 00:00:00', b'0'),
(2, 'Sofía', 'Gómez', 'Mexico', '87654321', '8765432103562', '1990-05-15', 2, '2022-05-15', '2022-05-15 00:00:00', b'0'),
(3, 'Luis', 'Alvarado', 'Pamana', '54321678', '5432167893653', '1975-11-20', 3, '2021-11-20', '2021-11-20 00:00:00', b'1'),
(4, 'Pedro', '	Rodríguez', 'Brasil', '98765432	', '9876543211244', '1995-08-05', 4, '2023-08-05', '2023-08-05 00:00:00', b'1'),
(6, 'Orlando', 'Sánchez', 'Colonia Residencial', '87654321', '8765432104826', '2000-12-25', 6, '2022-12-25', '2022-12-25 00:00:00', b'1'),
(7, 'Jose', 'Pérez', 'Barrio Popular', '54321678', '5432167890127', '1970-07-04', 7, '2021-07-04', '2021-07-04 00:00:00', b'0'),
(8, 'Isaias', 'García', 'Conjunto Habitacional', '98765432', '987654321028', '1992-02-18', 8, '2023-02-18', '2023-02-18 00:00:00', b'0'),
(9, 'Marcos', '	Martínez', 'Condominio Residencial', '12345678', '1234567898819', '1988-09-23', 9, '2020-09-23', '2020-09-23 00:00:00', b'0'),
(43, 'Daniel', 'Marroquin', 'Guatemala', '12345678', '123456789369', '2001-02-28', 12, '2024-10-04', '2024-10-23 21:52:41', b'0'),
(44, 'Daniel', 'Marroquin', 'Guatemala', '12345678', '123456789369', '2001-02-28', 12, '2024-10-04', '2024-10-23 21:53:45', b'0'),
(45, 'Daniel', 'Marroquin', 'Guatemala', '12345678', '123456789369', '2024-10-02', 12, '2024-10-17', '2024-10-27 08:58:41', b'0'),
(46, 'Daniel', 'Marroquin', 'Guatemala', '12345678', '123456789369', '2024-10-03', 12, '2024-10-25', '2024-10-27 11:08:33', b'0');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas`
--

CREATE TABLE `marcas` (
  `idMarca` smallint(6) NOT NULL,
  `marca` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `marcas`
--

INSERT INTO `marcas` (`idMarca`, `marca`) VALUES
(1, 'Hp'),
(2, 'Xaomii'),
(3, 'Dell'),
(4, 'Lenovo'),
(5, 'Asus'),
(6, 'Samsung'),
(7, 'Predator'),
(8, 'Apple'),
(9, 'oppo'),
(10, 'Infinity');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE `menu` (
  `id_menu` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `padre_id` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `archivo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `menu`
--

INSERT INTO `menu` (`id_menu`, `nombre`, `padre_id`, `url`, `archivo`) VALUES
(1, 'Productos', NULL, '/Proyecto/admin/Administrador/', 'Productos.jsp'),
(2, 'Ventas', NULL, '/Proyecto/admin/Administrador/', 'ventas.jsp'),
(3, 'Compras', NULL, '/Proyecto/admin/Administrador/', 'compras.jsp'),
(4, 'Reportes', NULL, '/Proyecto/admin/Administrador/', 'reportes.jsp'),
(5, 'Marcas', 1, '/Proyecto/admin/Administrador/', 'marcas.jsp'),
(6, 'Clientes', 2, '/Proyecto/admin/Administrador/', 'clientes.jsp'),
(7, 'Empleados', 2, '/Proyecto/admin/Administrador/', 'empleados.jsp'),
(8, 'Puestos', 7, '/Proyecto/admin/Administrador/', 'puestos.jsp'),
(9, 'Proveedores', 3, '/Proyecto/admin/Administrador/', 'proveedores.jsp');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idProducto` int(11) NOT NULL,
  `producto` varchar(50) DEFAULT NULL,
  `idmarca` smallint(6) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `precio_costo` decimal(8,2) DEFAULT NULL,
  `precio_venta` decimal(8,2) DEFAULT NULL,
  `existencia` int(11) DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idProducto`, `producto`, `idmarca`, `descripcion`, `imagen`, `precio_costo`, `precio_venta`, `existencia`, `fecha_ingreso`) VALUES
(12, 'infinix 40', 10, 'telefono', 'infinix zero 30.jpg', 300.00, 350.00, 30, '2024-10-14 23:27:38'),
(14, 'Galaxy S24 ', 6, 'telefono', '14 Ultra.jpg', 500.00, 550.00, 50, '2024-10-14 23:27:38'),
(16, 'samsung', 6, 'telefono', 'REDMI-14C-BLACK.jpg', 700.00, 875.00, 70, '2024-10-14 23:27:38'),
(28, 'ASUS ROG PHONE 6', 5, 'telefono', 'asus rog 6.jpg', 5000.00, 6250.00, 12, '2024-11-03 15:27:48'),
(29, 'Zero 30', 10, 'telefono', 'infinix zero 30.jpg', 2500.00, 3125.00, 23, '2024-11-03 15:29:28'),
(30, 'iPhone 15 Pro Max', 8, 'telefono', 'iphone 15 pro max.jpg', 14000.00, 17500.00, 32, '2024-11-03 15:31:27'),
(31, 'Galaxy S23 Ultra', 6, 'telefono', 'SAMSUNG-S23-ULTRA.jpg', 10000.00, 12500.00, 46, '2024-11-03 15:33:06'),
(32, 'Poco F6 ', 2, 'telefono', 'poco f6.jpg', 4000.00, 5000.00, 25, '2024-11-03 15:35:01'),
(33, 'Redmi 14C', 2, 'telefono', 'REDMI-14C-BLACK.jpg', 1000.00, 1250.00, 27, '2024-11-03 15:36:23'),
(34, '14 Ultra', 2, 'telefono', '14 Ultra.jpg', 12500.00, 15625.00, 33, '2024-11-03 15:37:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `idProveedore` int(11) NOT NULL,
  `proveedor` varchar(60) DEFAULT NULL,
  `nit` varchar(12) DEFAULT NULL,
  `direccion` varchar(80) DEFAULT NULL,
  `telefono` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`idProveedore`, `proveedor`, `nit`, `direccion`, `telefono`) VALUES
(101, 'Acme', '123456', 'Guatemala ', '98765432'),
(102, 'Beta Suples', '87654321-0', 'Mexico', '87654321'),
(103, 'Gamma Industries', '54321678-9', 'Pamana', '54321678'),
(104, 'Eta Electronics', '111222333-4', 'Ciudad de la Electrónica', '11122233'),
(105, 'Theta Solutions', '444555666-7', 'Edificio Corporativo', '44455566'),
(106, 'Zeta Components', '98765432-1', 'Parque Industrial', '98765432'),
(107, 'Iota Services', '777888999-0', 'Torre Empresarial, Zona VIP', '77788899'),
(108, 'Lambda Materials', '222111000-2', 'Zona de Materiales', '22211100'),
(109, 'Mu Materials', '555666777-3', 'Zona de Materiales', '555666777');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puestos`
--

CREATE TABLE `puestos` (
  `idpuesto` smallint(6) NOT NULL,
  `puesto` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `puestos`
--

INSERT INTO `puestos` (`idpuesto`, `puesto`) VALUES
(2, 'Contado'),
(3, 'Vendedor'),
(4, 'Bodeguero'),
(5, 'Soporte It'),
(6, 'Ingeniero'),
(7, 'Repartidor'),
(8, 'Supervisor'),
(9, 'Asistente'),
(12, 'Administrador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `attempts` int(11) DEFAULT 0,
  `lock_time` timestamp NULL DEFAULT NULL,
  `mec` varchar(20) NOT NULL,
  `idEmpleado` int(11) DEFAULT NULL,
  `idCliente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `attempts`, `lock_time`, `mec`, `idEmpleado`, `idCliente`) VALUES
(2, 'sgomez47', 'aaa', 0, NULL, 'empleado', 2, NULL),
(3, 'lalvarado96', 'ZXC789asd', 0, NULL, 'empleado', 3, NULL),
(4, 'prodriguez18', 'MNB456fgh', 0, NULL, 'empleado', 4, NULL),
(6, 'osanchez77', 'JKL098wer', 0, NULL, 'admin', 6, NULL),
(7, 'jperez04', 'RTY123uio', 0, NULL, 'empleado', 7, NULL),
(8, 'igarcia45', 'UIO456zxc', 0, NULL, 'empleado', 8, NULL),
(9, 'mmartinez23', 'QAZ789asd', 0, NULL, 'admin', 9, NULL),
(12, 'kperez53', 'ZXC789qwe', 0, NULL, 'cliente', NULL, 3),
(13, 'prenta51', 'ASDF234rty', 0, NULL, 'cliente', NULL, 4),
(14, 'jponce72', 'JKL098asd', 0, NULL, 'cliente', NULL, 5),
(15, 'mrios44', 'MNB456zxc', 0, NULL, 'cliente', NULL, 6),
(16, 'ecasas79', 'UIO789wer', 0, NULL, 'cliente', NULL, 7),
(17, 'vlaverde23', 'POI123rty', 0, NULL, 'cliente', NULL, 8),
(18, 'jcorral10', 'LOP456uio', 0, NULL, 'cliente', NULL, 9),
(19, 'jcruz98', 'ASW789poi', 0, NULL, 'cliente', NULL, 10),
(27, 'jperez24', 'gS0SasgI', 0, NULL, 'cliente', NULL, 24),
(28, 'jsp24', 'asdsasd', 0, NULL, 'cliente', NULL, 2),
(29, 'jsp24', 'asdsasd', 0, NULL, 'cliente', NULL, 2),
(30, 'jsp24', 'asdsasd', 0, NULL, 'cliente', NULL, 2),
(32, 'dhernandez82', 'ABC123defg', 0, NULL, 'admin', NULL, 10),
(33, 'dhernandez82', 'ABC123defg', 0, NULL, 'admin', NULL, 24),
(34, 'dhernandez82', 'ABC123defg', 0, NULL, 'cliente', NULL, 24),
(35, 'dhernandez82', 'ABC123defg', 0, NULL, 'admin', NULL, 10),
(36, 'dhernandez82', 'ABC123defg', 0, NULL, 'cliente', NULL, 10),
(37, 'mochoa25', 'yrk9cd!X', 0, NULL, 'cliente', NULL, 25),
(62, 'mochoa26', 'hLb39gm#', 0, NULL, 'cliente', NULL, 26),
(63, 'dmarroquin43', 'MmGKrnrR', 0, NULL, 'empleado', 43, NULL),
(64, 'dmarroquin44', '%pF6y81l', 0, NULL, 'empleado', 44, NULL),
(65, 'pochoa27', 'M8TQwppt', 0, NULL, 'cliente', NULL, 27),
(66, 'dmarroquin45', 'Ll!fhKnm', 0, NULL, 'empleado', 45, NULL),
(67, 'dmarroquin46', 'Nvt!PzK4', 0, NULL, 'empleado', 46, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idVenta` int(11) NOT NULL,
  `nofactura` int(11) DEFAULT NULL,
  `serie` char(1) DEFAULT NULL,
  `fechafactura` date DEFAULT NULL,
  `idcliente` int(11) DEFAULT NULL,
  `idempleado` int(11) DEFAULT NULL,
  `fechaingreso` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`idVenta`, `nofactura`, `serie`, `fechafactura`, `idcliente`, `idempleado`, `fechaingreso`) VALUES
(20, 1007, 'B', '2024-10-17', 2, 2, '2024-10-17 16:16:31'),
(21, 1006, 'A', '2024-10-29', 2, 1, '2024-10-29 16:07:32'),
(22, 1007, 'B', '2024-11-03', 4, 6, '2024-11-03 15:49:32');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas_detalle`
--

CREATE TABLE `ventas_detalle` (
  `idventa_detalle` bigint(20) NOT NULL,
  `idventa` int(11) DEFAULT NULL,
  `idproducto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio_unitario` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `ventas_detalle`
--

INSERT INTO `ventas_detalle` (`idventa_detalle`, `idventa`, `idproducto`, `cantidad`, `precio_unitario`) VALUES
(1, NULL, NULL, 2, 600.00),
(2, NULL, NULL, 1, 800.00),
(3, NULL, NULL, 3, 250.00),
(4, NULL, NULL, 1, 785.00),
(5, NULL, NULL, 2, 299.99),
(6, NULL, NULL, 4, 79.99),
(7, 20, 12, 1, 379.99),
(10, 22, 12, 1, 379.99);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idCliente`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`idCompra`),
  ADD KEY `idCompras_idx` (`idproveedor`);

--
-- Indices de la tabla `compras_detalle`
--
ALTER TABLE `compras_detalle`
  ADD PRIMARY KEY (`idCompra_detalle`),
  ADD KEY `idCompra_idx` (`idcompra`),
  ADD KEY `idProducto_idx` (`idproducto`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`idEmpleado`),
  ADD KEY `fk_Empleados_Puestos1_idx` (`idPuesto`);

--
-- Indices de la tabla `marcas`
--
ALTER TABLE `marcas`
  ADD PRIMARY KEY (`idMarca`);

--
-- Indices de la tabla `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id_menu`),
  ADD KEY `padre_id` (`padre_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `idMarca_idx` (`producto`),
  ADD KEY `idMarca_idx1` (`idmarca`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`idProveedore`);

--
-- Indices de la tabla `puestos`
--
ALTER TABLE `puestos`
  ADD PRIMARY KEY (`idpuesto`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idEmpleado_idx` (`idEmpleado`),
  ADD KEY `idCliente_idx` (`idCliente`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`idVenta`),
  ADD KEY `idCliente_idx` (`idcliente`),
  ADD KEY `empleado_idx` (`idempleado`);

--
-- Indices de la tabla `ventas_detalle`
--
ALTER TABLE `ventas_detalle`
  ADD PRIMARY KEY (`idventa_detalle`),
  ADD KEY `idventa_idx` (`idventa`),
  ADD KEY `idproducto_idx` (`idproducto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `idCompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `compras_detalle`
--
ALTER TABLE `compras_detalle`
  MODIFY `idCompra_detalle` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `idEmpleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `marcas`
--
ALTER TABLE `marcas`
  MODIFY `idMarca` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `menu`
--
ALTER TABLE `menu`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `idProveedore` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT de la tabla `puestos`
--
ALTER TABLE `puestos`
  MODIFY `idpuesto` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `idVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `ventas_detalle`
--
ALTER TABLE `ventas_detalle`
  MODIFY `idventa_detalle` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `idCompras` FOREIGN KEY (`idproveedor`) REFERENCES `proveedores` (`idProveedore`);

--
-- Filtros para la tabla `compras_detalle`
--
ALTER TABLE `compras_detalle`
  ADD CONSTRAINT `idCompra` FOREIGN KEY (`idcompra`) REFERENCES `compras` (`idCompra`),
  ADD CONSTRAINT `idProducto` FOREIGN KEY (`idproducto`) REFERENCES `productos` (`idProducto`);

--
-- Filtros para la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `idPuesto` FOREIGN KEY (`idPuesto`) REFERENCES `puestos` (`idpuesto`);

--
-- Filtros para la tabla `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`padre_id`) REFERENCES `menu` (`id_menu`) ON DELETE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `idMarca` FOREIGN KEY (`idmarca`) REFERENCES `marcas` (`idMarca`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `idCliente` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`),
  ADD CONSTRAINT `idEmpleado` FOREIGN KEY (`idEmpleado`) REFERENCES `empleados` (`idEmpleado`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `cliente` FOREIGN KEY (`idcliente`) REFERENCES `clientes` (`idCliente`),
  ADD CONSTRAINT `empleado` FOREIGN KEY (`idempleado`) REFERENCES `empleados` (`idEmpleado`);

--
-- Filtros para la tabla `ventas_detalle`
--
ALTER TABLE `ventas_detalle`
  ADD CONSTRAINT `producto` FOREIGN KEY (`idproducto`) REFERENCES `productos` (`idProducto`),
  ADD CONSTRAINT `venta` FOREIGN KEY (`idventa`) REFERENCES `ventas` (`idVenta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
