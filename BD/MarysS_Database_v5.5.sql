DROP DATABASE IF EXISTS Mary_sS;
CREATE DATABASE Mary_sS;
USE Mary_sS;

CREATE TABLE Empleado(
    EmpleadoID varchar(10) not null primary key,
    CI int(10) not null,
    Nombre varchar(50) not null,
    Apellido varchar(50) not null,
    FechaContrato date not null,
    FechaNacimiento date not null,
    Activo boolean not null default 0,
    Habilitado boolean not null default 1
);

CREATE TABLE UsuarioEmp (
    EmpleadoID varchar(10) not null unique primary key,
    Usuario varchar(50) not null,
    Correo varchar(50) not null,
    Keyword varchar(100) not null,
    CodRecuperacion int(8) not null,
    Habilitado boolean not null default 1,
    FOREIGN KEY (EmpleadoID) REFERENCES Empleado(EmpleadoID)
);

CREATE TABLE Proveedor(
    ProveedorID varchar(10) not null primary key,
    Nombre varchar(50) not null,
    NombreContacto varchar(50) not null,
    ApellidoContacto varchar(50) not null,
    TituloContacto varchar(50) not null,
    Telefono int(9) not null,
    Habilitado boolean not null default 1
);

CREATE TABLE Renta(
    RentaID varchar(10) not null primary key,
    EmpleadoID varchar(10) not null,
    FechaRenta date not null,
    FechaDevolucion date not null,
    FechaDevuelto date null,
    Descuento int not null,
    Total int not null,
    Multa int null,
    FOREIGN KEY (EmpleadoID) REFERENCES Empleado(EmpleadoID)
);

CREATE TABLE Cliente(
    ClienteID varchar(10) not null primary key,
    RentaID varchar(10) not null,
    Nombre varchar(50) not null,
    Apellido varchar(50) not null,
    Telefono int(9) not null,
    Garantia bool not null default false,
    Habilitado boolean not null default 1,
    FOREIGN KEY (RentaID) REFERENCES Renta(RentaID)
);

CREATE TABLE Garantia(
    RentaID varchar(10) not null,
    ClienteID varchar(10) not null,
    Tipo varchar(50) not null,
    Habilitado boolean not null default 1,
    FOREIGN KEY (RentaID) REFERENCES Renta(RentaID),
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID)
);

CREATE TABLE Categoria(
    CategoriaID varchar(10) not null primary key,
    Categoria varchar(30) not null
);

CREATE TABLE Color(
    ColorID varchar(10) not null primary key,
    Color varchar(30) not null
);

CREATE TABLE Producto(
    ProductoID varchar(10) not null primary key,
    CategoriaID varchar(10) not null,
    ColorID1 varchar(10) null,
    ColorID2 varchar(10) null,
    PrecioUnitario int not null,
    PrecioVenta int not null,
    Nombre varchar(100) not null,
    Stock int not null default 0,
    Disponible int not null default 0,
    Habilitado boolean not null default 1,
    FOREIGN KEY (CategoriaID) REFERENCES Categoria(CategoriaID),
    FOREIGN KEY (ColorID1) REFERENCES Color(ColorID),
    FOREIGN KEY (ColorID2) REFERENCES Color(ColorID)
);

CREATE TABLE DetalleRenta(
    RentaID varchar(10) not null,
    ProductoID varchar(10) not null,
    Cantidad int not null,
    Subtotal int not null,
    Habilitado boolean not null default 1,
    FOREIGN KEY (RentaID) REFERENCES Renta(RentaID),
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID)
);

CREATE TABLE Damage(
    DamageID int auto_increment not null primary key,
    Caso varchar(25) not null,
    Multa int not null
);

CREATE TABLE Provision(
    ProductoID varchar(10) not null,
    ProveedorID varchar(10) not null,
    FechaProvision date not null,
    Cantidad int not null,
    PrecioUnitario int not null,
    Subtotal int not null,
    Habilitado boolean not null default 1,
    primary key (ProductoID, ProveedorID),
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID),
    FOREIGN KEY (ProveedorID) REFERENCES Proveedor(ProveedorID)
);

DELIMITER //
CREATE TRIGGER eliminar_usuario_empleado
BEFORE DELETE ON Empleado
FOR EACH ROW
BEGIN
    DELETE FROM UsuarioEmp WHERE EmpleadoID = OLD.EmpleadoID;
END//
DELIMITER ;


INSERT INTO Empleado (EmpleadoID, CI, Nombre, Apellido, FechaContrato, FechaNacimiento, Activo) VALUES ('MGR-002', 12345678, 'Azufranio', 'Ninsial', '2024-09-05', '1992-04-18', 1);
INSERT INTO UsuarioEmp (EmpleadoID, Usuario, Correo, Keyword, CodRecuperacion) VALUES ('MGR-002', 'AzuMgr', 'AzufranioMGR@maryss.com', '$2y$10$ZoRBQ2uhq9mD89gUkRrvcOHTZwA0cw2RVQVP09cRioFfTF6M.j2Ty', 123456);
INSERT INTO Empleado (EmpleadoID, CI, Nombre, Apellido, FechaContrato, FechaNacimiento, Activo) VALUES ('MGR-001', 12345678, 'Damian', 'Aruquipa', '2024-09-05', '2002-04-08', 1);
INSERT INTO UsuarioEmp (EmpleadoID, Usuario, Correo, Keyword, CodRecuperacion) VALUES ('MGR-001', 'DamianArus', 'DamianArus@maryss.com', '$2y$10$By3UZuEFZDtCK5Vo53l5aOKaOktixFX6l12t8k2bnnpagI0Nc3y.S', 123456);
INSERT INTO Empleado (EmpleadoID, CI, Nombre, Apellido, FechaContrato, FechaNacimiento, Activo) VALUES ('MGR-003', 12345678, 'Mateo', 'Torrez', '2024-09-05', '2004-09-14', 1);
INSERT INTO UsuarioEmp (EmpleadoID, Usuario, Correo, Keyword, CodRecuperacion) VALUES ('MGR-003', 'TaptoMax', 'TaptoMax@maryss.com', '$2y$10$xLVzcq.KWCRY3zw9bL7oU.Y8yPionEdi6kHMJSu7FxtHG6oTeKtlG', 123456);

INSERT INTO Empleado (EmpleadoID, CI, Nombre, Apellido, FechaContrato, FechaNacimiento, Activo) VALUES ('EMP-001', 12345678, 'AzufranioEmp', 'Ninsial', '2024-09-05', '1992-04-18', 0);
INSERT INTO UsuarioEmp (EmpleadoID, Usuario, Correo, Keyword, CodRecuperacion) VALUES ('EMP-001', 'AzuEmp', 'AzufranioEMP@marys.com', '$2y$10$ZoRBQ2uhq9mD89gUkRrvcOHTZwA0cw2RVQVP09cRioFfTF6M.j2Ty', 123456);


INSERT INTO Categoria (CategoriaID, Categoria) VALUES
('CAT-001', 'Chutas'),
('CAT-002', 'Pepinos'),
('CAT-003', 'Conjuntos'),
('CAT-004', 'Accesorios'),
('CAT-005', 'Calzados');

INSERT INTO Color (ColorID, Color) VALUES
('COL-001', 'Rojo'),
('COL-002', 'Azul'),
('COL-003', 'Negro'),
('COL-004', 'Blanco'),
('COL-005', 'Verde'),
('COL-006', 'Morado'),
('COL-007', 'Dorado'),
('COL-008', 'Plateado'),
('COL-009', 'Celeste'),
('COL-010', 'Guindo'),
('COL-011', 'Cafe'),
('COL-012', 'Rosado'),
('COL-013', 'Amarillo'),
('COL-014', 'Naranja'),
('COL-015', 'Verde Pacai'),
('COL-016', 'Verde Whatsapp'),
('COL-017', 'Celeste Bolivar'),
('COL-018', 'Crema'),
('COL-019', 'Morado Antiguo'),
('COL-020', 'Tricolor');

INSERT INTO Producto (ProductoID, CategoriaID, ColorID1, ColorID2, PrecioUnitario, PrecioVenta, Nombre, Stock, Disponible, Habilitado) VALUES
-- Rojo con Negro
('PRD-001', 'CAT-001', 'COL-001', 'COL-003', 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-002', 'CAT-001', 'COL-001', 'COL-003', 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-003', 'CAT-001', 'COL-001', 'COL-003', 20, 200, 'Pantalon', 2, 2, 1),
('PRD-004', 'CAT-001', 'COL-001', 'COL-003', 10, 100, 'Faja', 20, 20, 1),
('PRD-005', 'CAT-001', 'COL-001', 'COL-003', 10, 100, 'Chuspa', 20, 20, 1),

-- Azul con Crema
('PRD-006', 'CAT-001', 'COL-002', 'COL-018', 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-007', 'CAT-001', 'COL-002', 'COL-018', 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-008', 'CAT-001', 'COL-002', 'COL-018', 30, 300, 'Pantalon', 2, 2, 1),
('PRD-009', 'CAT-001', 'COL-002', 'COL-018', 10, 100, 'Faja', 20, 20, 1),
('PRD-010', 'CAT-001', 'COL-002', 'COL-018', 10, 100, 'Chuspa', 20, 20, 1),

-- Rojo con Dorado
('PRD-011', 'CAT-001', 'COL-001', 'COL-007', 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-012', 'CAT-001', 'COL-001', 'COL-007', 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-013', 'CAT-001', 'COL-001', 'COL-007', 200, 200, 'Pantalon', 2, 2, 1),
('PRD-014', 'CAT-001', 'COL-001', 'COL-007', 10, 100, 'Faja', 20, 20, 1),
('PRD-015', 'CAT-001', 'COL-001', 'COL-007', 10, 100, 'Chuspa', 20, 20, 1),

-- Negro con Verde
('PRD-016', 'CAT-001', 'COL-003', 'COL-005', 50, 500, 'Chaqueta', 20, 20, 1),
('PRD-017', 'CAT-001', 'COL-003', 'COL-005', 40, 400, 'Chaquetilla', 20, 20, 1),
('PRD-018', 'CAT-001', 'COL-003', 'COL-005', 20, 200, 'Pantalon', 2, 2, 1),
('PRD-019', 'CAT-001', 'COL-003', 'COL-005', 10, 100, 'Faja', 20, 20, 1),
('PRD-020', 'CAT-001', 'COL-003', 'COL-005', 10, 100, 'Chuspa', 20, 20, 1),

-- Blanco con Plateado
('PRD-021', 'CAT-001', 'COL-004', 'COL-008', 40, 400, 'Chaqueta', 20, 20, 1),
('PRD-022', 'CAT-001', 'COL-004', 'COL-008', 30, 300, 'Chaquetilla', 20, 20, 1),
('PRD-023', 'CAT-001', 'COL-004', 'COL-008', 20, 200, 'Pantalon', 2, 2, 1),
('PRD-024', 'CAT-001', 'COL-004', 'COL-008', 10, 100, 'Faja', 20, 20, 1),
('PRD-025', 'CAT-001', 'COL-004', 'COL-008', 10, 100, 'Chuspa', 20, 20, 1),

-- Verde Whatsapp
('PRD-026', 'CAT-001', 'COL-016', NULL, 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-027', 'CAT-001', 'COL-016', NULL, 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-028', 'CAT-001', 'COL-016', NULL, 30, 300, 'Pantalon', 2, 2, 1),
('PRD-029', 'CAT-001', 'COL-016', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-030', 'CAT-001', 'COL-016', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Tricolor
('PRD-031', 'CAT-001', 'COL-020', NULL, 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-032', 'CAT-001', 'COL-020', NULL, 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-033', 'CAT-001', 'COL-020', NULL, 20, 200, 'Pantalon', 2, 2, 1),
('PRD-034', 'CAT-001', 'COL-020', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-035', 'CAT-001', 'COL-020', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Morado
('PRD-036', 'CAT-001', 'COL-006', NULL, 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-037', 'CAT-001', 'COL-006', NULL, 70, 700, 'Chaquetilla', 20, 20, 1),
('PRD-038', 'CAT-001', 'COL-006', NULL, 40, 400, 'Pantalon', 2, 2, 1),
('PRD-039', 'CAT-001', 'COL-006', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-040', 'CAT-001', 'COL-006', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Guindo
('PRD-041', 'CAT-001', 'COL-010', NULL, 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-042', 'CAT-001', 'COL-010', NULL, 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-043', 'CAT-001', 'COL-010', NULL, 20, 200, 'Pantalon', 2, 2, 1),
('PRD-044', 'CAT-001', 'COL-010', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-045', 'CAT-001', 'COL-010', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Verde Pacai
('PRD-046', 'CAT-001', 'COL-015', NULL, 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-047', 'CAT-001', 'COL-015', NULL, 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-048', 'CAT-001', 'COL-015', NULL, 20, 200, 'Pantalon', 2, 2, 1),
('PRD-049', 'CAT-001', 'COL-015', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-050', 'CAT-001', 'COL-015', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Dorado con Negro
('PRD-051', 'CAT-001', 'COL-007', 'COL-003', 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-052', 'CAT-001', 'COL-007', 'COL-003', 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-053', 'CAT-001', 'COL-007', 'COL-003', 20, 200, 'Pantalon', 2, 2, 1),
('PRD-054', 'CAT-001', 'COL-007', 'COL-003', 10, 100, 'Faja', 20, 20, 1),
('PRD-055', 'CAT-001', 'COL-007', 'COL-003', 10, 100, 'Chuspa', 20, 20, 1),

-- Plateado con Negro
('PRD-056', 'CAT-001', 'COL-008', 'COL-003', 90, 900, 'Chaqueta', 20, 20, 1),
('PRD-057', 'CAT-001', 'COL-008', 'COL-003', 100, 1000, 'Chaquetilla', 20, 20, 1),
('PRD-058', 'CAT-001', 'COL-008', 'COL-003', 40, 400, 'Pantalon', 2, 2, 1),
('PRD-059', 'CAT-001', 'COL-008', 'COL-003', 10, 100, 'Faja', 20, 20, 1),
('PRD-060', 'CAT-001', 'COL-008', 'COL-003', 10, 100, 'Chuspa', 20, 20, 1),

-- Celeste Bolivar
('PRD-061', 'CAT-001', 'COL-017', NULL, 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-062', 'CAT-001', 'COL-017', NULL, 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-063', 'CAT-001', 'COL-017', NULL, 20, 200, 'Pantalon', 2, 2, 1),
('PRD-064', 'CAT-001', 'COL-017', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-065', 'CAT-001', 'COL-017', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Cafe
('PRD-066', 'CAT-001', 'COL-011', NULL, 40, 600, 'Chaqueta', 20, 20, 1),
('PRD-067', 'CAT-001', 'COL-011', NULL, 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-068', 'CAT-001', 'COL-011', NULL, 20, 200, 'Pantalon', 2, 2, 1),
('PRD-069', 'CAT-001', 'COL-011', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-070', 'CAT-001', 'COL-011', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Rosado
('PRD-071', 'CAT-001', 'COL-012', NULL, 50, 60, 'Chaqueta', 20, 20, 1),
('PRD-072', 'CAT-001', 'COL-012', NULL, 40, 50, 'Chaquetilla', 20, 20, 1),
('PRD-073', 'CAT-001', 'COL-012', NULL, 20, 120, 'Pantalon', 2, 2, 1),
('PRD-074', 'CAT-001', 'COL-012', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-075', 'CAT-001', 'COL-012', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Azul con Celeste
('PRD-076', 'CAT-001', 'COL-002', 'COL-009', 50, 600, 'Chaqueta', 20, 20, 1),
('PRD-077', 'CAT-001', 'COL-002', 'COL-009', 40, 500, 'Chaquetilla', 20, 20, 1),
('PRD-078', 'CAT-001', 'COL-002', 'COL-009', 20, 200, 'Pantalon', 2, 2, 1),
('PRD-079', 'CAT-001', 'COL-002', 'COL-009', 10, 100, 'Faja', 20, 20, 1),
('PRD-080', 'CAT-001', 'COL-002', 'COL-009', 10, 100, 'Chuspa', 20, 20, 1);

/*('PRD-081', 'CAT-002', 'COL-001', 'COL-002', 130, 'Pepino', 2, 2, 1), -- verde con blanco
('PRD-082', 'CAT-002', 'COL-003', 'COL-004', 120, 'Pepino', 2, 2, 1), -- dorado con azul
('PRD-083', 'CAT-002', 'COL-005', 'COL-003', 110, 'Pepino', 2, 2, 1), -- rojo con dorado
('PRD-084', 'CAT-002', 'COL-006', 'COL-007', 100, 'Pepino', 2, 2, 1), -- negro con amarillo
('PRD-085', 'CAT-002', 'COL-001', 'COL-007', 150, 'Pepino', 2, 2, 1), -- verde con amarillo
('PRD-086', 'CAT-002', 'COL-004', 'COL-005', 190, 'Pepino', 2, 2, 1), -- azul con rojo
('PRD-087', 'CAT-002', 'COL-008', 'COL-002', 150, 'Pepino', 2, 2, 1), -- rosado con blanco
('PRD-088', 'CAT-002', 'COL-009', 'COL-002', 160, 'Pepino', 2, 2, 1), -- morado con blanco
('PRD-089', 'CAT-002', 'COL-010', 'COL-002', 130, 'Pepino', 2, 2, 1), -- celeste con blanco

('PRD-090', 'CAT-003', NULL, NULL, 20, 'Minero', 2, 2, 1),
('PRD-091', 'CAT-003', NULL, NULL, 30, 'Chavo', 2, 2, 1),
('PRD-092', 'CAT-003', NULL, NULL, 30, 'Chapulin', 2, 2, 1),
('PRD-093', 'CAT-003', NULL, NULL, 50, 'Saya', 2, 2, 1),

('PRD-094', 'CAT-004', 'COL-001', 'COL-003', 10, 'Corbatas', 20, 20, 1),
('PRD-095', 'CAT-004', 'COL-002', 'COL-018', 10, 'Corbatas', 20, 20, 1),
('PRD-096', 'CAT-004', 'COL-020', NULL, 10, 'Corbatas', 20, 20, 1),
('PRD-097', 'CAT-004', 'COL-006', NULL, 10, 'Corbatas', 20, 20, 1),

('PRD-098', 'CAT-004', 'COL-001', NULL, 50, 'Pollera', 7, 6, 1),
('PRD-099', 'CAT-004', 'COL-002', NULL, 20, 'Pollera', 7, 6, 1),
('PRD-100', 'CAT-004', 'COL-003', NULL, 30, 'Pollera', 7, 6, 1),
('PRD-101', 'CAT-004', 'COL-004', NULL, 40, 'Pollera', 7, 6, 1),
('PRD-102', 'CAT-004', 'COL-005', NULL, 25, 'Pollera', 7, 6, 1),
('PRD-103', 'CAT-004', 'COL-006', NULL, 15, 'Pollera', 7, 6, 1),

('PRD-104', 'CAT-004', 'COL-004', NULL, 20, 'Sombreros', 20, 20, 1),
('PRD-105', 'CAT-004', 'COL-003', NULL, 20, 'Sombreros', 20, 20, 1),

('PRD-106', 'CAT-004', 'COL-002', 'COL-004', 15, 'Mascaras', 20, 20, 1),
('PRD-107', 'CAT-004', 'COL-013', 'COL-004', 15, 'Mascaras', 20, 20, 1),
('PRD-108', 'CAT-004', 'COL-012', 'COL-004', 15, 'Mascaras', 20, 20, 1),
('PRD-109', 'CAT-004', 'COL-002', 'COL-001', 15, 'Mascaras', 20, 20, 1),
('PRD-110', 'CAT-004', 'COL-005', 'COL-004', 15, 'Mascaras', 20, 20, 1),
('PRD-111', 'CAT-004', 'COL-006', 'COL-004', 15, 'Mascaras', 20, 20, 1),

('PRD-112', 'CAT-005', 'COL-006', NULL, 25, 'Zapatos', 20, 20, 1),
('PRD-11', 'CAT-005', 'COL-006', NULL, 20, 'Chinelas', 20, 20, 1);*/

INSERT INTO Proveedor (ProveedorID, Nombre, NombreContacto, ApellidoContacto, TituloContacto, Telefono)
VALUES
('PRV-001', 'TexAndes', 'María', 'Gutiérrez', 'Gerente Comercial', 76451230),
('PRV-002', 'RopaFestiva S.R.L.', 'Jorge', 'Mamani', 'Encargado de Ventas', 71234567),
('PRV-003', 'Tradiciones Vivas', 'Lucía', 'Cáceres', 'Asesora de Provisión', 78900123);

INSERT INTO Damage (Caso, Multa) VALUES
('Daño leve (manchas, desgaste mínimo, pequeños accesorios) - 10%', 10),
('Daño moderado (pérdida de accesorios, desgaste visible) - 20%', 15),
('Modificación no autorizada (cortes, pinturas) - 25%', 120),
('Daño considerable (roturas pequeñas, deshilachados) - 30%', 50),
('Daño significativo (roturas medianas, manchas permanentes) - 40%', 200),
('Daño grave (roturas grandes, daño estructural) - 50%', 450),
('Daño muy grave (daño múltiple, irreparable parcial) - 60%', 490),
('Daño severo (daño extenso, pérdida funcional) - 70%', 650);

select * from detallerenta;
select * from renta;
select * from cliente where RentaID = 'RNT-003';
select c.* from cliente c group by rentaID;

select * from producto where habilitado = 0;

select disponible from producto;

select min(precioventa) from producto