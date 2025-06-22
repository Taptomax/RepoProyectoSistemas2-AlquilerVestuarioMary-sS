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
('PRD-003', 'CAT-001', 'COL-001', 'COL-003', 20, 200, 'Pantalon', 20, 20, 1),
('PRD-004', 'CAT-001', 'COL-001', 'COL-003', 10, 100, 'Faja', 20, 20, 1),
('PRD-005', 'CAT-001', 'COL-001', 'COL-003', 10, 100, 'Chuspa', 20, 20, 1),

-- Azul con Crema
('PRD-006', 'CAT-001', 'COL-002', 'COL-018', 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-007', 'CAT-001', 'COL-002', 'COL-018', 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-008', 'CAT-001', 'COL-002', 'COL-018', 30, 300, 'Pantalon', 20, 20, 1),
('PRD-009', 'CAT-001', 'COL-002', 'COL-018', 10, 100, 'Faja', 20, 20, 1),
('PRD-010', 'CAT-001', 'COL-002', 'COL-018', 10, 100, 'Chuspa', 20, 20, 1),

-- Rojo con Dorado
('PRD-011', 'CAT-001', 'COL-001', 'COL-007', 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-012', 'CAT-001', 'COL-001', 'COL-007', 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-013', 'CAT-001', 'COL-001', 'COL-007', 200, 200, 'Pantalon', 20, 20, 1),
('PRD-014', 'CAT-001', 'COL-001', 'COL-007', 10, 100, 'Faja', 20, 20, 1),
('PRD-015', 'CAT-001', 'COL-001', 'COL-007', 10, 100, 'Chuspa', 20, 20, 1),

-- Negro con Verde
('PRD-016', 'CAT-001', 'COL-003', 'COL-005', 50, 500, 'Chaqueta', 20, 20, 1),
('PRD-017', 'CAT-001', 'COL-003', 'COL-005', 40, 400, 'Chaquetilla', 20, 20, 1),
('PRD-018', 'CAT-001', 'COL-003', 'COL-005', 20, 200, 'Pantalon', 20, 20, 1),
('PRD-019', 'CAT-001', 'COL-003', 'COL-005', 10, 100, 'Faja', 20, 20, 1),
('PRD-020', 'CAT-001', 'COL-003', 'COL-005', 10, 100, 'Chuspa', 20, 20, 1),

-- Blanco con Plateado
('PRD-021', 'CAT-001', 'COL-004', 'COL-008', 40, 400, 'Chaqueta', 20, 20, 1),
('PRD-022', 'CAT-001', 'COL-004', 'COL-008', 30, 300, 'Chaquetilla', 20, 20, 1),
('PRD-023', 'CAT-001', 'COL-004', 'COL-008', 20, 200, 'Pantalon', 20, 20, 1),
('PRD-024', 'CAT-001', 'COL-004', 'COL-008', 10, 100, 'Faja', 20, 20, 1),
('PRD-025', 'CAT-001', 'COL-004', 'COL-008', 10, 100, 'Chuspa', 20, 20, 1),

-- Verde Whatsapp
('PRD-026', 'CAT-001', 'COL-016', NULL, 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-027', 'CAT-001', 'COL-016', NULL, 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-028', 'CAT-001', 'COL-016', NULL, 30, 300, 'Pantalon', 20, 20, 1),
('PRD-029', 'CAT-001', 'COL-016', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-030', 'CAT-001', 'COL-016', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Tricolor
('PRD-031', 'CAT-001', 'COL-020', NULL, 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-032', 'CAT-001', 'COL-020', NULL, 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-033', 'CAT-001', 'COL-020', NULL, 20, 200, 'Pantalon', 20, 20, 1),
('PRD-034', 'CAT-001', 'COL-020', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-035', 'CAT-001', 'COL-020', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Morado
('PRD-036', 'CAT-001', 'COL-006', NULL, 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-037', 'CAT-001', 'COL-006', NULL, 70, 700, 'Chaquetilla', 20, 20, 1),
('PRD-038', 'CAT-001', 'COL-006', NULL, 40, 400, 'Pantalon', 20, 20, 1),
('PRD-039', 'CAT-001', 'COL-006', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-040', 'CAT-001', 'COL-006', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Guindo
('PRD-041', 'CAT-001', 'COL-010', NULL, 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-042', 'CAT-001', 'COL-010', NULL, 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-043', 'CAT-001', 'COL-010', NULL, 20, 200, 'Pantalon', 20, 20, 1),
('PRD-044', 'CAT-001', 'COL-010', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-045', 'CAT-001', 'COL-010', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Verde Pacai
('PRD-046', 'CAT-001', 'COL-015', NULL, 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-047', 'CAT-001', 'COL-015', NULL, 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-048', 'CAT-001', 'COL-015', NULL, 20, 200, 'Pantalon', 20, 20, 1),
('PRD-049', 'CAT-001', 'COL-015', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-050', 'CAT-001', 'COL-015', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Dorado con Negro
('PRD-051', 'CAT-001', 'COL-007', 'COL-003', 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-052', 'CAT-001', 'COL-007', 'COL-003', 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-053', 'CAT-001', 'COL-007', 'COL-003', 20, 200, 'Pantalon', 20, 20, 1),
('PRD-054', 'CAT-001', 'COL-007', 'COL-003', 10, 100, 'Faja', 20, 20, 1),
('PRD-055', 'CAT-001', 'COL-007', 'COL-003', 10, 100, 'Chuspa', 20, 20, 1),

-- Plateado con Negro
('PRD-056', 'CAT-001', 'COL-008', 'COL-003', 90, 900, 'Chaqueta', 20, 20, 1),
('PRD-057', 'CAT-001', 'COL-008', 'COL-003', 100, 1000, 'Chaquetilla', 20, 20, 1),
('PRD-058', 'CAT-001', 'COL-008', 'COL-003', 40, 400, 'Pantalon', 20, 20, 1),
('PRD-059', 'CAT-001', 'COL-008', 'COL-003', 10, 100, 'Faja', 20, 20, 1),
('PRD-060', 'CAT-001', 'COL-008', 'COL-003', 10, 100, 'Chuspa', 20, 20, 1),

-- Celeste Bolivar
('PRD-061', 'CAT-001', 'COL-017', NULL, 60, 600, 'Chaqueta', 20, 20, 1),
('PRD-062', 'CAT-001', 'COL-017', NULL, 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-063', 'CAT-001', 'COL-017', NULL, 20, 200, 'Pantalon', 20, 20, 1),
('PRD-064', 'CAT-001', 'COL-017', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-065', 'CAT-001', 'COL-017', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Cafe
('PRD-066', 'CAT-001', 'COL-011', NULL, 40, 600, 'Chaqueta', 20, 20, 1),
('PRD-067', 'CAT-001', 'COL-011', NULL, 50, 500, 'Chaquetilla', 20, 20, 1),
('PRD-068', 'CAT-001', 'COL-011', NULL, 20, 200, 'Pantalon', 20, 20, 1),
('PRD-069', 'CAT-001', 'COL-011', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-070', 'CAT-001', 'COL-011', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Rosado
('PRD-071', 'CAT-001', 'COL-012', NULL, 50, 60, 'Chaqueta', 20, 20, 1),
('PRD-072', 'CAT-001', 'COL-012', NULL, 40, 50, 'Chaquetilla', 20, 20, 1),
('PRD-073', 'CAT-001', 'COL-012', NULL, 20, 120, 'Pantalon', 20, 20, 1),
('PRD-074', 'CAT-001', 'COL-012', NULL, 10, 100, 'Faja', 20, 20, 1),
('PRD-075', 'CAT-001', 'COL-012', NULL, 10, 100, 'Chuspa', 20, 20, 1),

-- Azul con Celeste
('PRD-076', 'CAT-001', 'COL-002', 'COL-009', 50, 600, 'Chaqueta', 20, 20, 1),
('PRD-077', 'CAT-001', 'COL-002', 'COL-009', 40, 500, 'Chaquetilla', 20, 20, 1),
('PRD-078', 'CAT-001', 'COL-002', 'COL-009', 20, 200, 'Pantalon', 20, 20, 1),
('PRD-079', 'CAT-001', 'COL-002', 'COL-009', 10, 100, 'Faja', 20, 20, 1),
('PRD-080', 'CAT-001', 'COL-002', 'COL-009', 10, 100, 'Chuspa', 20, 20, 1),

('PRD-081', 'CAT-002', 'COL-001', 'COL-002', 130, 250, 'Pepino', 2, 2, 1), -- verde con blanco
('PRD-082', 'CAT-002', 'COL-003', 'COL-004', 120, 250, 'Pepino', 2, 2, 1), -- dorado con azul
('PRD-083', 'CAT-002', 'COL-005', 'COL-003', 110, 250, 'Pepino', 2, 2, 1), -- rojo con dorado
('PRD-084', 'CAT-002', 'COL-006', 'COL-007', 100, 250, 'Pepino', 2, 2, 1), -- negro con amarillo
('PRD-085', 'CAT-002', 'COL-001', 'COL-007', 150, 250, 'Pepino', 2, 2, 1), -- verde con amarillo
('PRD-086', 'CAT-002', 'COL-004', 'COL-005', 190, 250, 'Pepino', 2, 2, 1), -- azul con rojo
('PRD-087', 'CAT-002', 'COL-008', 'COL-002', 150, 250, 'Pepino', 2, 2, 1), -- rosado con blanco
('PRD-088', 'CAT-002', 'COL-009', 'COL-002', 160, 250, 'Pepino', 2, 2, 1), -- morado con blanco
('PRD-089', 'CAT-002', 'COL-010', 'COL-002', 130, 250, 'Pepino', 2, 2, 1), -- celeste con blanco

('PRD-090', 'CAT-003', NULL, NULL, 20, 300, 'Minero', 2, 2, 1),
('PRD-091', 'CAT-003', NULL, NULL, 30, 200, 'Chavo', 2, 2, 1),
('PRD-092', 'CAT-003', NULL, NULL, 30, 200, 'Chapulin', 2, 2, 1),
('PRD-093', 'CAT-003', NULL, NULL, 50, 300, 'Saya', 2, 2, 1),

('PRD-094', 'CAT-004', 'COL-001', 'COL-003', 10, 100, 'Corbatas', 20, 20, 1),
('PRD-095', 'CAT-004', 'COL-002', 'COL-018', 10, 100, 'Corbatas', 20, 20, 1),
('PRD-096', 'CAT-004', 'COL-020', NULL, 10, 100, 'Corbatas', 20, 20, 1),
('PRD-097', 'CAT-004', 'COL-006', NULL, 10, 100, 'Corbatas', 20, 20, 1),

('PRD-098', 'CAT-004', 'COL-001', NULL, 50, 300, 'Pollera', 7, 6, 1),
('PRD-099', 'CAT-004', 'COL-002', NULL, 20, 300, 'Pollera', 7, 6, 1),
('PRD-100', 'CAT-004', 'COL-003', NULL, 30, 300, 'Pollera', 7, 6, 1),
('PRD-101', 'CAT-004', 'COL-004', NULL, 40, 300, 'Pollera', 7, 6, 1),
('PRD-102', 'CAT-004', 'COL-005', NULL, 25, 300, 'Pollera', 7, 6, 1),
('PRD-103', 'CAT-004', 'COL-006', NULL, 15, 300, 'Pollera', 7, 6, 1),

('PRD-104', 'CAT-004', 'COL-004', NULL, 20, 250, 'Sombreros', 20, 20, 1),
('PRD-105', 'CAT-004', 'COL-003', NULL, 20, 250, 'Sombreros', 20, 20, 1),

('PRD-106', 'CAT-004', 'COL-002', 'COL-004', 15, 350, 'Mascaras', 20, 20, 1),
('PRD-107', 'CAT-004', 'COL-013', 'COL-004', 15, 350, 'Mascaras', 20, 20, 1),
('PRD-108', 'CAT-004', 'COL-012', 'COL-004', 15, 350, 'Mascaras', 20, 20, 1),
('PRD-109', 'CAT-004', 'COL-002', 'COL-001', 15, 350, 'Mascaras', 20, 20, 1),
('PRD-110', 'CAT-004', 'COL-005', 'COL-004', 15, 350, 'Mascaras', 20, 20, 1),
('PRD-111', 'CAT-004', 'COL-006', 'COL-004', 15, 350, 'Mascaras', 20, 20, 1),

('PRD-112', 'CAT-005', 'COL-006', NULL, 25, 420, 'Zapatos', 20, 20, 1),
('PRD-113', 'CAT-005', 'COL-006', NULL, 20, 200, 'Chinelas', 20, 20, 1);

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

-- select min(precioventa) from producto



-- Inserts para tabla Renta (Noviembre 2024 - 20 días hábiles)
INSERT INTO Renta (RentaID, EmpleadoID, FechaRenta, FechaDevolucion, FechaDevuelto, Descuento, Total, Multa) VALUES
-- Día 1 (2024-11-01) - 2 rentas
('RNT-001', 'MGR-001', '2024-11-01', '2024-11-06', '2024-11-06', 0, 1500, 0),
('RNT-002', 'MGR-002', '2024-11-01', '2024-11-04', '2024-11-04', 5, 1140, 0),

-- Día 2 (2024-11-04) - 3 rentas
('RNT-003', 'MGR-001', '2024-11-04', '2024-11-08', '2024-11-08', 0, 2100, 0),
('RNT-004', 'MGR-003', '2024-11-04', '2024-11-07', '2024-11-07', 10, 1350, 0),
('RNT-005', 'MGR-002', '2024-11-04', '2024-11-09', '2024-11-10', 0, 850, 25),
-- Día 3 (2024-11-05) - 1 renta
('RNT-006', 'MGR-001', '2024-11-05', '2024-11-12', '2024-11-12', 0, 3200, 0),

-- Día 4 (2024-11-06) - 2 rentas
('RNT-007', 'MGR-002', '2024-11-06', '2024-11-11', '2024-11-11', 0, 1800, 0),
('RNT-008', 'MGR-003', '2024-11-06', '2024-11-10', '2024-11-11', 0, 950, 15),

-- Día 5 (2024-11-07) - 3 rentas
('RNT-009', 'MGR-001', '2024-11-07', '2024-11-14', '2024-11-14', 5, 2375, 0),
('RNT-010', 'MGR-002', '2024-11-07', '2024-11-12', '2024-11-12', 0, 1600, 0),
('RNT-011', 'MGR-003', '2024-11-07', '2024-11-13', '2024-11-13', 0, 1250, 0),

-- Día 6 (2024-11-08) - 2 rentas
('RNT-012', 'MGR-001', '2024-11-08', '2024-11-15', '2024-11-15', 0, 2750, 0),
('RNT-013', 'MGR-002', '2024-11-08', '2024-11-13', '2024-11-14', 0, 1100, 20),
-- Día 7 (2024-11-11) - 1 renta
('RNT-014', 'MGR-003', '2024-11-11', '2024-11-18', '2024-11-18', 15, 2125, 0),

-- Día 8 (2024-11-12) - 3 rentas
('RNT-015', 'MGR-001', '2024-11-12', '2024-11-19', '2024-11-19', 0, 1950, 0),
('RNT-016', 'MGR-002', '2024-11-12', '2024-11-16', '2024-11-16', 0, 1450, 0),
('RNT-017', 'MGR-003', '2024-11-12', '2024-11-17', '2024-11-18', 0, 750, 30),

-- Día 9 (2024-11-13) - 2 rentas
('RNT-018', 'MGR-001', '2024-11-13', '2024-11-20', '2024-11-20', 10, 1440, 0),
('RNT-019', 'MGR-002', '2024-11-13', '2024-11-18', '2024-11-18', 0, 2200, 0),

-- Día 10 (2024-11-14) - 1 renta
('RNT-020', 'MGR-003', '2024-11-14', '2024-11-21', '2024-11-21', 0, 3100, 0),

-- Día 11 (2024-11-15) - 2 rentas
('RNT-021', 'MGR-001', '2024-11-15', '2024-11-22', '2024-11-22', 5, 1425, 0),
('RNT-022', 'MGR-002', '2024-11-15', '2024-11-19', '2024-11-19', 0, 1700, 0),

-- Día 12 (2024-11-18) - 3 rentas
('RNT-023', 'MGR-003', '2024-11-18', '2024-11-25', '2024-11-25', 0, 2600, 0),
('RNT-024', 'MGR-001', '2024-11-18', '2024-11-22', '2024-11-22', 0, 1350, 0),
('RNT-025', 'MGR-002', '2024-11-18', '2024-11-23', '2024-11-24', 0, 950, 40),

-- Día 13 (2024-11-19) - 1 renta
('RNT-026', 'MGR-003', '2024-11-19', '2024-11-26', '2024-11-26', 0, 2850, 0),

-- Día 14 (2024-11-20) - 2 rentas
('RNT-027', 'MGR-001', '2024-11-20', '2024-11-27', '2024-11-27', 8, 1472, 0),
('RNT-028', 'MGR-002', '2024-11-20', '2024-11-25', '2024-11-25', 0, 1800, 0),

-- Día 15 (2024-11-21) - 3 rentas
('RNT-029', 'MGR-003', '2024-11-21', '2024-11-28', '2024-11-28', 0, 2100, 0),
('RNT-030', 'MGR-001', '2024-11-21', '2024-11-26', '2024-11-26', 0, 1250, 0),
('RNT-031', 'MGR-002', '2024-11-21', '2024-11-27', '2024-11-28', 0, 750, 25),

-- Día 16 (2024-11-22) - 2 rentas
('RNT-032', 'MGR-003', '2024-11-22', '2024-11-29', '2024-11-29', 0, 3400, 0),
('RNT-033', 'MGR-001', '2024-11-22', '2024-11-27', '2024-11-27', 12, 1408, 0),

-- Día 17 (2024-11-25) - 1 renta
('RNT-034', 'MGR-002', '2024-11-25', '2024-12-02', '2024-12-02', 0, 2750, 0),

-- Día 18 (2024-11-26) - 3 rentas
('RNT-035', 'MGR-003', '2024-11-26', '2024-12-03', '2024-12-03', 0, 1950, 0),
('RNT-036', 'MGR-001', '2024-11-26', '2024-12-01', '2024-12-01', 0, 1600, 0),
('RNT-037', 'MGR-002', '2024-11-26', '2024-11-30', '2024-12-01', 0, 850, 35),

-- Día 19 (2024-11-27) - 2 rentas
('RNT-038', 'MGR-003', '2024-11-27', '2024-12-04', '2024-12-04', 5, 2375, 0),
('RNT-039', 'MGR-001', '2024-11-27', '2024-12-02', '2024-12-02', 0, 1450, 0),

-- Día 20 (2024-11-28) - 1 renta
('RNT-040', 'MGR-002', '2024-11-28', '2024-12-05', '2024-12-05', 0, 3200, 0);

-- Inserts para tabla Cliente
INSERT INTO Cliente (ClienteID, RentaID, Nombre, Apellido, Telefono, Garantia, Habilitado) VALUES
-- Clientes para cada renta (algunos con múltiples clientes por renta)
('CLI-001', 'RNT-001', 'Ana María', 'Vargas', 78912345, 1, 1),
('CLI-002', 'RNT-001', 'José Luis', 'Mamani', 76543210, 1, 1),

('CLI-003', 'RNT-002', 'Patricia', 'Quispe', 75432198, 1, 1),

('CLI-004', 'RNT-003', 'Roberto', 'Condori', 77865432, 1, 1),
('CLI-005', 'RNT-003', 'Silvia', 'Pérez', 76789012, 1, 1),
('CLI-006', 'RNT-003', 'Miguel', 'Torrez', 78901234, 1, 1),

('CLI-007', 'RNT-004', 'Carmen', 'López', 75678901, 1, 1),
('CLI-008', 'RNT-004', 'Diego', 'Choque', 77234567, 1, 1),

('CLI-009', 'RNT-005', 'Elena', 'Apaza', 76345678, 1, 1),

('CLI-010', 'RNT-006', 'Fernando', 'Huanca', 78456789, 1, 1),
('CLI-011', 'RNT-006', 'Gloria', 'Mendoza', 75567890, 1, 1),
('CLI-012', 'RNT-006', 'Héctor', 'Flores', 77678901, 1, 1),
('CLI-013', 'RNT-006', 'Irma', 'Castro', 76789012, 1, 1),

('CLI-014', 'RNT-007', 'Javier', 'Morales', 78890123, 1, 1),
('CLI-015', 'RNT-007', 'Karina', 'Vega', 75901234, 1, 1),
('CLI-016', 'RNT-008', 'Luis', 'Gutierrez', 77012345, 1, 1),

('CLI-017', 'RNT-009', 'Martha', 'Rojas', 76123456, 1, 1),
('CLI-018', 'RNT-009', 'Nicolás', 'Sánchez', 78234567, 1, 1),
('CLI-019', 'RNT-009', 'Olga', 'Herrera', 75345678, 1, 1),
('CLI-020', 'RNT-010', 'Pedro', 'Alarcón', 77456789, 1, 1),
('CLI-021', 'RNT-010', 'Querida', 'Ibañez', 76567890, 1, 1),

('CLI-022', 'RNT-011', 'Ricardo', 'Pinto', 78678901, 1, 1),

('CLI-023', 'RNT-012', 'Sandra', 'Romero', 75789012, 1, 1),
('CLI-024', 'RNT-012', 'Tomás', 'Delgado', 77890123, 1, 1),
('CLI-025', 'RNT-012', 'Ursula', 'Villarroel', 76901234, 1, 1),

('CLI-026', 'RNT-013', 'Víctor', 'Espinoza', 78012345, 1, 1),
('CLI-027', 'RNT-013', 'Wanda', 'Quiroga', 75123456, 1, 1),
('CLI-028', 'RNT-014', 'Xavier', 'Balcázar', 77234567, 1, 1),

('CLI-029', 'RNT-015', 'Yolanda', 'Cortez', 76345678, 1, 1),
('CLI-030', 'RNT-015', 'Zenón', 'Aguilar', 78456789, 1, 1),

('CLI-031', 'RNT-016', 'Adriana', 'Beltrán', 75567890, 1, 1),
('CLI-032', 'RNT-016', 'Bruno', 'Calderon', 77678901, 1, 1),

('CLI-033', 'RNT-017', 'Carla', 'Durán', 76789012, 1, 1),

('CLI-034', 'RNT-018', 'Daniel', 'Escalante', 78890123, 1, 1),
('CLI-035', 'RNT-018', 'Emma', 'Franco', 75901234, 1, 1),
('CLI-036', 'RNT-019', 'Fabio', 'Galindo', 77012345, 1, 1),
('CLI-037', 'RNT-019', 'Gabriela', 'Hidalgo', 76123456, 1, 1),
('CLI-038', 'RNT-019', 'Hugo', 'Jiménez', 78234567, 1, 1),

('CLI-039', 'RNT-020', 'Isabel', 'Karina', 75345678, 1, 1),
('CLI-040', 'RNT-020', 'Jorge', 'Luna', 77456789, 1, 1),
('CLI-041', 'RNT-020', 'Katia', 'Muñoz', 76567890, 1, 1),
('CLI-042', 'RNT-020', 'Lorenzo', 'Navarro', 78678901, 1, 1),

('CLI-043', 'RNT-021', 'Monica', 'Ortega', 75789012, 1, 1),
('CLI-044', 'RNT-021', 'Nelson', 'Padilla', 77890123, 1, 1),

('CLI-045', 'RNT-022', 'Olivia', 'Quintana', 76901234, 1, 1),
('CLI-046', 'RNT-022', 'Pablo', 'Ramírez', 78012345, 1, 1),
('CLI-047', 'RNT-023', 'Rosa', 'Silva', 75123456, 1, 1),
('CLI-048', 'RNT-023', 'Sergio', 'Torres', 77234567, 1, 1),
('CLI-049', 'RNT-023', 'Teresa', 'Uribe', 76345678, 1, 1),
('CLI-050', 'RNT-024', 'Ulises', 'Varela', 78456789, 1, 1),
('CLI-051', 'RNT-024', 'Valeria', 'Wilde', 75567890, 1, 1),

('CLI-052', 'RNT-025', 'William', 'Yañez', 77678901, 1, 1),
('CLI-053', 'RNT-026', 'Ximena', 'Zamora', 76789012, 1, 1),
('CLI-054', 'RNT-026', 'Yamila', 'Álvarez', 78890123, 1, 1),
('CLI-055', 'RNT-026', 'Zulma', 'Benítez', 75901234, 1, 1),

('CLI-056', 'RNT-027', 'Alberto', 'Carvajal', 77012345, 1, 1),
('CLI-057', 'RNT-027', 'Beatriz', 'Domínguez', 76123456, 1, 1),

('CLI-058', 'RNT-028', 'Carlos', 'Estrada', 78234567, 1, 1),
('CLI-059', 'RNT-028', 'Diana', 'Fernández', 75345678, 1, 1),

('CLI-060', 'RNT-029', 'Eduardo', 'García', 77456789, 1, 1),
('CLI-061', 'RNT-029', 'Fabiola', 'Heredia', 76567890, 1, 1),
('CLI-062', 'RNT-029', 'Gonzalo', 'Iglesias', 78678901, 1, 1),

('CLI-063', 'RNT-030', 'Helena', 'Jordán', 75789012, 1, 1),
('CLI-064', 'RNT-030', 'Ignacio', 'Kelvin', 77890123, 1, 1),

('CLI-065', 'RNT-031', 'Julia', 'Loayza', 76901234, 1, 1),

('CLI-066', 'RNT-032', 'Kevin', 'Maldonado', 78012345, 1, 1),
('CLI-067', 'RNT-032', 'Lucia', 'Núñez', 75123456, 1, 1),
('CLI-068', 'RNT-032', 'Mario', 'Orozco', 77234567, 1, 1),
('CLI-069', 'RNT-032', 'Nadia', 'Palacios', 76345678, 1, 1),
('CLI-070', 'RNT-033', 'Oscar', 'Quevedo', 78456789, 1, 1),
('CLI-071', 'RNT-033', 'Paola', 'Rivera', 75567890, 1, 1),
('CLI-072', 'RNT-034', 'Raúl', 'Salinas', 77678901, 1, 1),

('CLI-073', 'RNT-035', 'Susana', 'Trujillo', 76789012, 1, 1),
('CLI-074', 'RNT-035', 'Tito', 'Ugarte', 78890123, 1, 1),
('CLI-075', 'RNT-035', 'Verónica', 'Vásquez', 75901234, 1, 1),

('CLI-076', 'RNT-036', 'Walter', 'Wilkinson', 77012345, 1, 1),
('CLI-077', 'RNT-036', 'Xiomara', 'Yabeta', 76123456, 1, 1),
('CLI-078', 'RNT-037', 'Yuri', 'Zegarra', 78234567, 1, 1),

('CLI-079', 'RNT-038', 'Zaira', 'Arce', 75345678, 1, 1),
('CLI-080', 'RNT-038', 'Arturo', 'Borda', 77456789, 1, 1),
('CLI-081', 'RNT-038', 'Blanca', 'Calle', 76567890, 1, 1),

('CLI-082', 'RNT-039', 'Camilo', 'Daza', 78678901, 1, 1),
('CLI-083', 'RNT-039', 'Delia', 'Escobar', 75789012, 1, 1),

('CLI-084', 'RNT-040', 'Emilio', 'Fuentes', 77890123, 1, 1);

-- Inserts para tabla DetalleRenta
INSERT INTO DetalleRenta (RentaID, ProductoID, Cantidad, Subtotal, Habilitado) VALUES
-- RNT-NOV001 (Total: 1500)
('RNT-001', 'PRD-001', 2, 1200, 1), -- Chaqueta Roja/Negra
('RNT-001', 'PRD-004', 3, 300, 1),  -- Faja Roja/Negra

-- RNT-NOV002 (Total: 1200, con descuento 5% = 1140)
('RNT-002', 'PRD-081', 1, 250, 1),  -- Pepino
('RNT-002', 'PRD-098', 2, 600, 1),  -- Pollera Roja
('RNT-002', 'PRD-104', 1, 250, 1),  -- Sombrero Blanco
('RNT-002', 'PRD-094', 1, 100, 1),  -- Corbata

-- RNT-NOV003 (Total: 2100)
('RNT-003', 'PRD-006', 3, 1800, 1), -- Chaqueta Azul/Crema
('RNT-003', 'PRD-008', 1, 300, 1),  -- Pantalón Azul/Crema

-- RNT-NOV004 (Total: 1500, con descuento 10% = 1350)
('RNT-004', 'PRD-036', 2, 1200, 1), -- Chaqueta Morada
('RNT-004', 'PRD-038', 1, 400, 1),  -- Pantalón Morado

-- RNT-NOV005 (Total: 850)
('RNT-005', 'PRD-090', 2, 600, 1),  -- Minero
('RNT-005', 'PRD-105', 1, 250, 1),  -- Sombrero Negro

-- RNT-NOV006 (Total: 3200)
('RNT-006', 'PRD-051', 4, 2400, 1), -- Chaqueta Dorada/Negra
('RNT-006', 'PRD-053', 4, 800, 1),  -- Pantalón Dorado/Negro

-- RNT-NOV007 (Total: 1800)
('RNT-007', 'PRD-011', 3, 1800, 1), -- Chaqueta Roja/Dorada

-- RNT-NOV008 (Total: 950)
('RNT-008', 'PRD-082', 1, 250, 1),  -- Pepino
('RNT-008', 'PRD-106', 2, 700, 1),  -- Máscaras

-- RNT-NOV009 (Total: 2500, con descuento 5% = 2375)
('RNT-009', 'PRD-056', 2, 1800, 1), -- Chaqueta Plateada/Negra
('RNT-009', 'PRD-058', 1, 400, 1),  -- Pantalón Plateado/Negro
('RNT-009', 'PRD-112', 1, 420, 1),  -- Zapatos

-- RNT-NOV010 (Total: 1600)
('RNT-010', 'PRD-016', 2, 1000, 1), -- Chaqueta Negra/Verde
('RNT-010', 'PRD-018', 3, 600, 1),  -- Pantalón Negro/Verde

-- RNT-NOV011 (Total: 1250)
('RNT-011', 'PRD-083', 5, 1250, 1), -- Pepino

-- RNT-NOV012 (Total: 2750)
('RNT-012', 'PRD-031', 3, 1800, 1), -- Chaqueta Tricolor
('RNT-012', 'PRD-033', 2, 400, 1),  -- Pantalón Tricolor
('RNT-012', 'PRD-093', 1, 300, 1),  -- Saya
('RNT-012', 'PRD-096', 2, 200, 1),  -- Corbata Tricolor
('RNT-012', 'PRD-113', 1, 200, 1),  -- Chinelas

-- RNT-NOV013 (Total: 1100)
('RNT-013', 'PRD-021', 2, 800, 1),  -- Chaqueta Blanca/Plateada
('RNT-013', 'PRD-023', 1, 200, 1),  -- Pantalón Blanco/Plateado
('RNT-013', 'PRD-025', 1, 100, 1),  -- Chuspa Blanca/Plateada

-- RNT-NOV014 (Total: 2500, con descuento 15% = 2125)
('RNT-014', 'PRD-076', 3, 1800, 1), -- Chaqueta Azul/Celeste
('RNT-014', 'PRD-078', 3, 600, 1),  -- Pantalón Azul/Celeste
('RNT-014', 'PRD-080', 1, 100, 1),  -- Chuspa Azul/Celeste

-- RNT-NOV015 (Total: 1950)
('RNT-015', 'PRD-041', 2, 1200, 1), -- Chaqueta Guindo
('RNT-015', 'PRD-043', 2, 400, 1),  -- Pantalón Guindo
('RNT-015', 'PRD-107', 1, 350, 1),  -- Máscara

-- RNT-NOV016 (Total: 1450)
('RNT-016', 'PRD-046', 2, 1200, 1), -- Chaqueta Verde Pacai
('RNT-016', 'PRD-048', 1, 200, 1),  -- Pantalón Verde Pacai
('RNT-016', 'PRD-050', 1, 100, 1),  -- Chuspa Verde Pacai

-- RNT-NOV017 (Total: 750)
('RNT-017', 'PRD-084', 3, 750, 1),  -- Pepino

-- RNT-NOV018 (Total: 1600, con descuento 10% = 1440)
('RNT-018', 'PRD-066', 2, 1200, 1), -- Chaqueta Café
('RNT-018', 'PRD-068', 2, 400, 1),  -- Pantalón Café

-- RNT-NOV019 (Total: 2200)
('RNT-019', 'PRD-061', 3, 1800, 1), -- Chaqueta Celeste Bolívar
('RNT-019', 'PRD-063', 2, 400, 1),  -- Pantalón Celeste Bolívar

-- RNT-NOV020 (Total: 3100)
('RNT-020', 'PRD-057', 3, 3000, 1), -- Chaquetilla Plateada/Negra
('RNT-020', 'PRD-095', 1, 100, 1),  -- Corbata Azul/Crema

-- RNT-NOV021 (Total: 1500, con descuento 5% = 1425)
('RNT-021', 'PRD-026', 2, 1200, 1), -- Chaqueta Verde WhatsApp
('RNT-021', 'PRD-028', 1, 300, 1),  -- Pantalón Verde WhatsApp

-- RNT-NOV022 (Total: 1700)
('RNT-022', 'PRD-071', 2, 120, 1),  -- Chaqueta Rosada
('RNT-022', 'PRD-072', 3, 150, 1),  -- Chaquetilla Rosada
('RNT-022', 'PRD-091', 5, 1000, 1), -- Chavo
('RNT-022', 'PRD-108', 1, 350, 1),  -- Máscara Rosada/Blanca
('RNT-022', 'PRD-113', 1, 200, 1),  -- Chinelas

-- RNTV023 (Total: 2600)
('RNT-023', 'PRD-002', 4, 2000, 1), -- Chaquetilla Roja/Negra
('RNT-023', 'PRD-003', 3, 600, 1),  -- Pantalón Rojo/Negro

-- RNT-NOV024 (Total: 1350)
('RNT-024', 'PRD-017', 2, 800, 1),  -- Chaquetilla Negra/Verde
('RNT-024', 'PRD-019', 3, 300, 1),  -- Faja Negra/Verde
('RNT-024', 'PRD-020', 2, 200, 1),  -- Chuspa Negra/Verde
('RNT-024', 'PRD-113', 1, 200, 1),  -- Chinelas

-- RNT-NOV025 (Total: 950)
('RNT-025', 'PRD-085', 2, 500, 1),  -- Pepino Verde/Amarillo
('RNT-025', 'PRD-092', 2, 400, 1),  -- Chapulín
('RNT-025', 'PRD-113', 1, 200, 1),  -- Chinelas

-- RNT-NOV026 (Total: 2850)
('RNT-026', 'PRD-012', 4, 2000, 1), -- Chaquetilla Roja/Dorada
('RNT-026', 'PRD-014', 5, 500, 1),  -- Faja Roja/Dorada
('RNT-026', 'PRD-109', 1, 350, 1),  -- Máscara Azul/Roja

-- RNT-NOV027 (Total: 1600, con descuento 8% = 1472)
('RNT-027', 'PRD-022', 4, 1200, 1), -- Chaquetilla Blanca/Plateada
('RNT-027', 'PRD-024', 4, 400, 1),  -- Faja Blanca/Plateada

-- RNT-NOV028 (Total: 1800)
('RNT-028', 'PRD-027', 2, 1000, 1), -- Chaquetilla Verde WhatsApp
('RNT-028', 'PRD-029', 5, 500, 1),  -- Faja Verde WhatsApp
('RNT-028', 'PRD-030', 3, 300, 1),  -- Chuspa Verde WhatsApp

-- RNT-NOV029 (Total: 2100)
('RNT-029', 'PRD-032', 3, 1500, 1), -- Chaquetilla Tricolor
('RNT-029', 'PRD-034', 4, 400, 1),  -- Faja Tricolor
('RNT-029', 'PRD-035', 2, 200, 1),  -- Chuspa Tricolor

-- RNT-NOV030 (Total: 1250)
('RNT-030', 'PRD-037', 1, 700, 1),  -- Chaquetilla Morada
('RNT-030', 'PRD-039', 5, 500, 1),  -- Faja Morada
('RNT-030', 'PRD-040', 1, 100, 1),  -- Chuspa Morada

-- RNT-NOV031 (Total: 750)
('RNT-031', 'PRD-086', 3, 750, 1),  -- Pepino Azul/Rojo

-- RNT-NOV032 (Total: 3400)
('RNT-032', 'PRD-042', 5, 2500, 1), -- Chaquetilla Guindo
('RNT-032', 'PRD-044', 5, 500, 1),  -- Faja Guindo
('RNT-032', 'PRD-045', 4, 400, 1),  -- Chuspa Guindo

-- RNT-NOV033 (Total: 1600, con descuento 12% = 1408)
('RNT-033', 'PRD-047', 2, 1000, 1), -- Chaquetilla Verde Pacai
('RNT-033', 'PRD-049', 4, 400, 1),  -- Faja Verde Pacai
('RNT-033', 'PRD-097', 2, 200, 1),  -- Corbata Morada

-- RNT-NOV034 (Total: 2750)
('RNT-034', 'PRD-052', 4, 2000, 1), -- Chaquetilla Dorada/Negra
('RNT-034', 'PRD-054', 5, 500, 1),  -- Faja Dorada/Negra
('RNT-034', 'PRD-055', 2, 200, 1),  -- Chuspa Dorada/Negra

-- RNT-NOV035 (Total: 1950)
('RNT-035', 'PRD-062', 3, 1500, 1), -- Chaquetilla Celeste Bolívar
('RNT-035', 'PRD-064', 4, 400, 1),  -- Faja Celeste Bolívar
('RNT-035', 'PRD-065', 1, 100, 1),  -- Chuspa Celeste Bolívar

-- RNT-NOV036 (Total: 1600)
('RNT-036', 'PRD-067', 2, 1000, 1), -- Chaquetilla Café
('RNT-036', 'PRD-069', 4, 400, 1),  -- Faja Café
('RNT-036', 'PRD-070', 2, 200, 1),  -- Chuspa Café

-- RNT-NOV037 (Total: 850)
('RNT-037', 'PRD-087', 2, 500, 1),  -- Pepino Rosado/Blanco
('RNT-037', 'PRD-110', 1, 350, 1),  -- Máscara Verde/Blanca
-- RNT-NOV038 (Total: 2500, con descuento 5% = 2375)
('RNT-038', 'PRD-077', 4, 2000, 1), -- Chaquetilla Azul/Celeste
('RNT-038', 'PRD-079', 5, 500, 1),  -- Faja Azul/Celeste

-- RNT-NOV039 (Total: 1450)
('RNT-039', 'PRD-007', 2, 1000, 1), -- Chaquetilla Azul/Crema
('RNT-039', 'PRD-009', 4, 400, 1),  -- Faja Azul/Crema
('RNT-039', 'PRD-010', 1, 100, 1),  -- Chuspa Azul/Crema

-- RNT-NOV040 (Total: 3200)
('RNT-040', 'PRD-001', 4, 2400, 1), -- Chaqueta Roja/Negra
('RNT-040', 'PRD-088', 2, 500, 1),  -- Pepino Morado/Blanco
('RNT-040', 'PRD-089', 1, 250, 1),  -- Pepino Celeste/Blanco
('RNT-040', 'PRD-113', 1, 200, 1);  -- Chinelas

-- Inserts para tabla Garantía
INSERT INTO Garantia (RentaID, ClienteID, Tipo, Habilitado) VALUES
-- Garantías para RNT-NOV001
('RNT-001', 'CLI-001', 'Cédula de Identidad', 1),
('RNT-001', 'CLI-002', 'Licencia de Conducir', 1),

-- Garantías para RNT-NOV002
('RNT-002', 'CLI-003', 'Cédula de Identidad', 1),
('RNT-002', 'CLI-003', 'Carnet de Estudiante', 1),

-- Garantías para RNT-NOV003
('RNT-003', 'CLI-004', 'Cédula de Identidad', 1),
('RNT-003', 'CLI-005', 'Licencia de Conducir', 1),
('RNT-003', 'CLI-006', 'Carnet de Trabajo', 1),

-- Garantías paraNT-NOV004
('RNT-004', 'CLI-007', 'Cédula de Identidad', 1),
('RNT-004', 'CLI-008', 'Licencia de Conducir', 1),
('RNT-004', 'CLI-008', 'Carnet de Estudiante', 1),

-- Garantías para RNT-NOV005
('RNT-005', 'CLI-009', 'Cédula de Identidad', 1),

-- Garantías para RNT-NOV006
('RNT-006', 'CLI-010', 'Cédula de Identidad', 1),
('RNT-006', 'CLI-011', 'Licencia de Conducir', 1),
('RNT-006', 'CLI-012', 'Carnet de Trabajo', 1),
('RNT-006', 'CLI-013', 'Cédula de Identidad', 1),
('RNT-006', 'CLI-013', 'Carnet de Estudiante', 1),

-- Garantías para RNT-NOV007
('RNT-007', 'CLI-014', 'Cédula de Identidad', 1),
('RNT-007', 'CLI-015', 'Licencia de Conducir', 1),

-- Garantías para RNT-NOV008
('RNT-008', 'CLI-016', 'Cédula de Identidad', 1),
('RNT-008', 'CLI-016', 'Carnet de Trabajo', 1),

-- Garantías para RNT-NOV009
('RNT-009', 'CLI-017', 'Cédula de Identidad', 1),
('RNT-009', 'CLI-018', 'Licencia de Conducir', 1),
('RNT-009', 'CLI-019', 'Carnet de Estudiante', 1),

-- Garantías para RNT-NOV010
('RNT-010', 'CLI-020', 'Cédula de Identidad', 1),
('RNT-010', 'CLI-021', 'Licencia de Conducir', 1),
('RNT-010', 'CLI-021', 'Carnet de Trabajo', 1),

-- Garantías para RNT-NOV011
('RNT-011', 'CLI-022', 'Cédula de Identidad', 1),

-- Garantías paraRNT-NOV012
('RNT-012', 'CLI-023', 'Cédula de Identidad', 1),
('RNT-012', 'CLI-024', 'Licencia de Conducir', 1),
('RNT-012', 'CLI-025', 'Carnet de Estudiante', 1),

-- Garantías para RNT-NOV013
('RNT-013', 'CLI-026', 'Cédula de Identidad', 1),
('RNT-013', 'CLI-027', 'Licencia de Conducir', 1),

-- Garantías para RNT-NOV014
('RNT-014', 'CLI-028', 'Cédula de Identidad', 1),
('RNT-014', 'CLI-028', 'Carnet de Trabajo', 1),

-- Garntías para RNT-NOV015
('RNT-015', 'CLI-029', 'Cédula de Identidad', 1),
('RNT-015', 'CLI-030', 'Licencia de Conducir', 1),

-- Garantías para RNT-NOV016
('RNT-016', 'CLI-031', 'Cédula de Identidad', 1),
('RNT-016', 'CLI-032', 'Carnet de Estudiante', 1),
('RNT-016', 'CLI-032', 'Carnet de Trabajo', 1),
-- Garantías para RNT-NOV017
('RNT-017', 'CLI-033', 'Cédula de Identidad', 1),

-- Garantías para RNT-NOV018
('RNT-018', 'CLI-034', 'Cédula de Identidad', 1),
('RNT-018', 'CLI-035', 'Licencia de Conducir', 1),

-- Garantías para RNT-NOV019
('RNT-019', 'CLI-036', 'Cédula de Identidad', 1),
('RNT-019', 'CLI-037', 'Licencia de Conducir', 1),
('RNT-019', 'CLI-038', 'Carnet de Trabajo', 1),

-- Garantías para RNT-NOV020
('RNT-020', 'CLI-039', 'Cédula de Identidad', 1),
('RNT-020', 'CLI-040', 'Licencia de Conducir', 1),
('RNT-020', 'CLI-041', 'Carnet de Estudiante', 1),
('RNT-020', 'CLI-042', 'Carnet de Trabajo', 1),

-- Garantías para RNT-NOV021
('RNT-021', 'CLI-043', 'Cédula de Identidad', 1),
('RNT-021', 'CLI-044', 'Licencia de Conducir', 1),

-- Garantías para RNT-NOV022
('RNT-022', 'CLI-045', 'Cédula de Identidad', 1),
('RNT-022', 'CLI-046', 'Carnet de Estudiante', 1),

-- Garantías para RNT-NOV023
('RNT-023', 'CLI-047', 'Cédula de Identidad', 1),
('RNT-023', 'CLI-048', 'Licencia de Conducir', 1),
('RNT-023', 'CLI-049', 'Carnet de Trabajo', 1),

-- Garantías para RNT-NOV024
('RNT-024', 'CLI-050', 'Cédula de Identidad', 1),
('RNT-024', 'CLI-051', 'Licencia de Conducir', 1),
('RNT-024', 'CLI-051', 'Carnet de Estudiante', 1),

-- Garantías para RNT-NOV025
('RNT-025', 'CLI-052', 'Cédula de Identidad', 1),

-- Garantías para RNT-NOV026
('RNT-026', 'CLI-053', 'Cédula de Identidad', 1),
('RNT-026', 'CLI-054', 'Licencia de Conducir', 1),
('RNT-026', 'CLI-055', 'Carnet de Trabajo', 1),

-- Garantías para RNT-NOV027
('RNT-027', 'CLI-056', 'Cédula de Identidad', 1),
('RNT-027', 'CLI-057', 'Licencia de Conducir', 1),

-- Garantías para RNT-NOV028
('RNT-028', 'CLI-058', 'Cédula de Identidad', 1),
('RNT-028', 'CLI-059', 'Carnet de Estudiante', 1),
('RNT-028', 'CLI-059', 'Carnet de Trabajo', 1),

-- Garantías para RNT-NOV029
('RNT-029', 'CLI-060', 'Cédula de Identidad', 1),
('RNT-029', 'CLI-061', 'Licencia de Conducir', 1),
('RNT-029', 'CLI-062', 'Carnet de Trabajo', 1),

-- Garantías para RNT-NOV030
('RNT-030', 'CLI-063', 'Cédula de Identidad', 1),
('RNT-030', 'CLI-064', 'Licencia de Conducir', 1),

-- Garantías para RNT-NOV031
('RNT-031', 'CLI-065', 'Cédula de Identidad', 1),

-- Garantías para RNT-NOV032
('RNT-032', 'CLI-066', 'Cédula de Identidad', 1),
('RNT-032', 'CLI-067', 'Licencia de Conducir', 1),
('RNT-032', 'CLI-068', 'Carnet de Trabajo', 1),
('RNT-032', 'CLI-069', 'Carnet de Estudiante', 1),

-- Garantías para RNT-NOV033
('RNT-033', 'CLI-070', 'Cédula de Identidad', 1),
('RNT-033', 'CLI-071', 'Licencia de Conducir', 1),

-- Garantías para RNT-NOV034
('RNT-034', 'CLI-072', 'Cédula de Identidad', 1),
('RNT-034', 'CLI-072', 'Carnet de Trabajo', 1),

-- Garantías para RNT-NOV035
('RNT-035', 'CLI-073', 'Cédula de Identidad', 1),
('RNT-035', 'CLI-074', 'Licencia de Conducir', 1),
('RNT-035', 'CLI-075', 'Carnet de Estudiante', 1),

-- Garantías para RNT-NOV036
('RNT-036', 'CLI-076', 'Cédula de Identidad', 1),
('RNT-036', 'CLI-077', 'Licencia de Conducir', 1),

-- Garantías para RNT-NOV037
('RNT-037', 'CLI-078', 'Cédula de Identidad', 1),

-- Garantías para RNT-NOV038
('RNT-038', 'CLI-079', 'Cédula de Identidad', 1),
('RNT-038', 'CLI-080', 'Licencia de Conducir', 1),
('RNT-038', 'CLI-081', 'Carnet de Trabajo', 1),

-- Garantías para RNT-NOV039
('RNT-039', 'CLI-082', 'Cédula de Identidad', 1),
('RNT-039', 'CLI-083', 'Carnet de Estudiante', 1),
('RNT-039', 'CLI-083', 'Licencia de Conducir', 1),

-- Garantías para RNT-NOV040
('RNT-040', 'CLI-084', 'Cédula de Identidad', 1),
('RNT-040', 'CLI-084', 'Carnet de Trabajo', 1);
-- Rentas para Diciembre 2024 (22 días hábiles aproximadamente)
-- Cada día tiene de 1 a 3 rentas, con múltiples clientes, productos y garantías

-- TABLA RENTA
INSERT INTO Renta (RentaID, EmpleadoID, FechaRenta, FechaDevolucion, FechaDevuelto, Descuento, Total, Multa) VALUES 
-- Lunes 2 de diciembre
('RNT-101', 'MGR-001', '2024-12-02', '2024-12-07', '2024-12-07', 0, 1500, 0),
('RNT-102', 'MGR-002', '2024-12-02', '2024-12-06', '2024-12-06', 5, 850, 0),

-- Martes 3 de diciembre
('RNT-103', 'MGR-001', '2024-12-03', '2024-12-08', '2024-12-08', 0, 2200, 0),
('RNT-104', 'MGR-002', '2024-12-03', '2024-12-07', '2024-12-09', 0, 1100, 100),
('RNT-105', 'MGR-001', '2024-12-03', '2024-12-10', '2024-12-10', 10, 900, 0),

-- Miércoles 4 de diciembre
('RNT-106', 'MGR-002', '2024-12-04', '2024-12-09', '2024-12-09', 0, 1800, 0),
('RNT-107', 'MGR-001', '2024-12-04', '2024-12-11', '2024-12-11', 0, 650, 0),

-- Jueves 5 de diciembre
('RNT-108', 'MGR-001', '2024-12-05', '2024-12-12', '2024-12-12', 0, 2500, 0),
('RNT-109', 'MGR-002', '2024-12-05', '2024-12-10', '2024-12-12', 0, 1300, 150),
('RNT-110', 'MGR-001', '2024-12-05', '2024-12-09', '2024-12-09', 15, 750, 0),

-- Viernes 6 de diciembre
('RNT-111', 'MGR-002', '2024-12-06', '2024-12-13', '2024-12-13', 0, 1950, 0),
('RNT-112', 'MGR-001', '2024-12-06', '2024-12-11', '2024-12-11', 0, 1100, 0),

-- Lunes 9 de diciembre
('RNT-113', 'MGR-001', '2024-12-09', '2024-12-16', '2024-12-16', 0, 3200, 0),
('RNT-114', 'MGR-002', '2024-12-09', '2024-12-13', '2024-12-13', 5, 900, 0),
('RNT-115', 'MGR-001', '2024-12-09', '2024-12-14', '2024-12-16', 0, 800, 200),

-- Martes 10 de diciembre
('RNT-116', 'MGR-002', '2024-12-10', '2024-12-17', '2024-12-17', 0, 2800, 0),
('RNT-117', 'MGR-001', '2024-12-10', '2024-12-15', '2024-12-15', 10, 1200, 0),

-- Miércoles 11 de diciembre
('RNT-118', 'MGR-001', '2024-12-11', '2024-12-18', '2024-12-18', 0, 1700, 0),
('RNT-119', 'MGR-002', '2024-12-11', '2024-12-16', '2024-12-16', 0, 950, 0),
('RNT-120', 'MGR-001', '2024-12-11', '2024-12-15', '2024-12-17', 0, 600, 100),

-- Jueves 12 de diciembre
('RNT-121', 'MGR-002', '2024-12-12', '2024-12-19', '2024-12-19', 0, 2100, 0),
('RNT-122', 'MGR-001', '2024-12-12', '2024-12-17', '2024-12-17', 20, 1400, 0),

-- Viernes 13 de diciembre
('RNT-123', 'MGR-001', '2024-12-13', '2024-12-20', '2024-12-20', 0, 3500, 0),
('RNT-124', 'MGR-002', '2024-12-13', '2024-12-18', '2024-12-18', 0, 1800, 0),
('RNT-125', 'MGR-001', '2024-12-13', '2024-12-17', '2024-12-19', 0, 750, 150),

-- Lunes 16 de diciembre
('RNT-126', 'MGR-002', '2024-12-16', '2024-12-23', '2024-12-23', 0, 2600, 0),
('RNT-127', 'MGR-001', '2024-12-16', '2024-12-20', '2024-12-20', 0, 1100, 0),

-- Martes 17 de diciembre
('RNT-128', 'MGR-001', '2024-12-17', '2024-12-24', NULL, 0, 4200, 0),
('RNT-129', 'MGR-002', '2024-12-17', '2024-12-21', '2024-12-21', 5, 1000, 0),
('RNT-130', 'MGR-001', '2024-12-17', '2024-12-22', '2024-12-24', 0, 850, 200),

-- Miércoles 18 de diciembre
('RNT-131', 'MGR-002', '2024-12-18', '2024-12-25', NULL, 0, 3800, 0),
('RNT-132', 'MGR-001', '2024-12-18', '2024-12-23', '2024-12-23', 0, 1500, 0),

-- Jueves 19 de diciembre
('RNT-133', 'MGR-001', '2024-12-19', '2024-12-26', NULL, 0, 2900, 0),
('RNT-134', 'MGR-002', '2024-12-19', '2024-12-24', NULL, 10, 1700, 0),
('RNT-135', 'MGR-001', '2024-12-19', '2024-12-23', '2024-12-25', 0, 950, 100),

-- Viernes 20 de diciembre
('RNT-136', 'MGR-002', '2024-12-20', '2024-12-27', NULL, 0, 5200, 0),
('RNT-137', 'MGR-001', '2024-12-20', '2024-12-24', NULL, 0, 2100, 0),

-- Lunes 23 de diciembre
('RNT-138', 'MGR-001', '2024-12-23', '2024-12-30', NULL, 0, 3100, 0),
('RNT-139', 'MGR-002', '2024-12-23', '2024-12-27', NULL, 15, 1400, 0),
('RNT-140', 'MGR-001', '2024-12-23', '2024-12-28', NULL, 0, 800, 0),

-- Martes 24 de diciembre
('RNT-141', 'MGR-002', '2024-12-24', '2024-12-31', NULL, 0, 4800, 0),

-- Viernes 27 de diciembre
('RNT-142', 'MGR-001', '2024-12-27', '2025-01-03', NULL, 0, 2200, 0),
('RNT-143', 'MGR-002', '2024-12-27', '2024-12-31', NULL, 0, 1600, 0),

-- Lunes 30 de diciembre
('RNT-144', 'MGR-001', '2024-12-30', '2025-01-06', NULL, 0, 3700, 0),
('RNT-145', 'MGR-002', '2024-12-30', '2025-01-04', NULL, 5, 950, 0),

-- Martes 31 de diciembre
('RNT-146', 'MGR-001', '2024-12-31', '2025-01-07', NULL, 0, 2800, 0);

-- TABLA CLIENTE
INSERT INTO Cliente (ClienteID, RentaID, Nombre, Apellido, Telefono, Garantia, Habilitado) VALUES 
-- Clientes para RNT-101
('CLI-101', 'RNT-101', 'Ana', 'Mamani', 78912345, 1, 1),
('CLI-102', 'RNT-101', 'Pedro', 'Quispe', 79123456, 1, 1),

-- Clientes para RNT-102
('CLI-103', 'RNT-102', 'Rosa', 'Condori', 77234567, 1, 1),

-- Clientes para RNT-103
('CLI-104', 'RNT-103', 'Miguel', 'Choque', 76345678, 1, 1),
('CLI-105', 'RNT-103', 'Sofia', 'Huanca', 75456789, 1, 1),
('CLI-106', 'RNT-103', 'Diego', 'Apaza', 74567890, 1, 1),

-- Clientes para RNT-104
('CLI-107', 'RNT-104', 'Carmen', 'Flores', 73678901, 1, 1),
('CLI-108', 'RNT-104', 'Luis', 'Vargas', 72789012, 1, 1),

-- Clientes para RNT-105
('CLI-109', 'RNT-105', 'Elena', 'Castro', 71890123, 1, 1),

-- Clientes para RNT-106
('CLI-110', 'RNT-106', 'Roberto', 'Nina', 70901234, 1, 1),
('CLI-111', 'RNT-106', 'Patricia', 'Calle', 69012345, 1, 1),

-- Clientes para RNT-107
('CLI-112', 'RNT-107', 'Juan', 'Ticona', 68123456, 1, 1),

-- Clientes para RNT-108
('CLI-113', 'RNT-108', 'Maria', 'Gutierrez', 67234567, 1, 1),
('CLI-114', 'RNT-108', 'Carlos', 'Limachi', 66345678, 1, 1),
('CLI-115', 'RNT-108', 'Andrea', 'Mamani', 65456789, 1, 1),

-- Clientes para RNT-109
('CLI-116', 'RNT-109', 'Fernando', 'Cruz', 64567890, 1, 1),
('CLI-117', 'RNT-109', 'Lucia', 'Rios', 63678901, 1, 1),

-- Clientes para RNT-110
('CLI-118', 'RNT-110', 'Jorge', 'Siles', 62789012, 1, 1),

-- Clientes para RNT-111
('CLI-119', 'RNT-111', 'Silvia', 'Mendez', 61890123, 1, 1),
('CLI-120', 'RNT-111', 'Raul', 'Paredes', 60901234, 1, 1),
('CLI-121', 'RNT-111', 'Gloria', 'Torrez', 59012345, 1, 1),

-- Clientes para RNT-112
('CLI-122', 'RNT-112', 'Victor', 'Ramos', 58123456, 1, 1),
('CLI-123', 'RNT-112', 'Monica', 'Vasquez', 57234567, 1, 1),

-- Clientes para RNT-113
('CLI-124', 'RNT-113', 'Daniela', 'Morales', 56345678, 1, 1),
('CLI-125', 'RNT-113', 'Alejandro', 'Jimenez', 55456789, 1, 1),
('CLI-126', 'RNT-113', 'Valentina', 'Herrera', 54567890, 1, 1),
('CLI-127', 'RNT-113', 'Nicolas', 'Peña', 53678901, 1, 1),

-- Clientes para RNT-114
('CLI-128', 'RNT-114', 'Isabella', 'Romero', 52789012, 1, 1),

-- Clientes para RNT-115
('CLI-129', 'RNT-115', 'Sebastian', 'Aguilar', 51890123, 1, 1),

-- Clientes para RNT-116
('CLI-130', 'RNT-116', 'Camila', 'Delgado', 50901234, 1, 1),
('CLI-131', 'RNT-116', 'Mateo', 'Rojas', 49012345, 1, 1),
('CLI-132', 'RNT-116', 'Antonella', 'Moreno', 48123456, 1, 1),

-- Clientes para RNT-117
('CLI-133', 'RNT-117', 'Emilio', 'Alvarez', 47234567, 1, 1),
('CLI-134', 'RNT-117', 'Renata', 'Medina', 46345678, 1, 1),

-- Clientes para RNT-118
('CLI-135', 'RNT-118', 'Joaquin', 'Cordova', 45456789, 1, 1),
('CLI-136', 'RNT-118', 'Esperanza', 'Sandoval', 44567890, 1, 1),

-- Clientes para RNT-119
('CLI-137', 'RNT-119', 'Maximiliano', 'Contreras', 43678901, 1, 1),
('CLI-138', 'RNT-119', 'Fernanda', 'Espinoza', 42789012, 1, 1),

-- Clientes para RNT-120
('CLI-139', 'RNT-120', 'Lorenzo', 'Villanueva', 41890123, 1, 1),

-- Clientes para RNT-121
('CLI-140', 'RNT-121', 'Martina', 'Guerrero', 40901234, 1, 1),
('CLI-141', 'RNT-121', 'Thiago', 'Salinas', 39012345, 1, 1),
('CLI-142', 'RNT-121', 'Julieta', 'Vega', 38123456, 1, 1),

-- Clientes para RNT-122
('CLI-143', 'RNT-122', 'Augusto', 'Molina', 37234567, 1, 1),
('CLI-144', 'RNT-122', 'Constanza', 'Pinto', 36345678, 1, 1),

-- Clientes para RNT-123
('CLI-145', 'RNT-123', 'Bautista', 'Fuentes', 35456789, 1, 1),
('CLI-146', 'RNT-123', 'Agustina', 'Ibañez', 34567890, 1, 1),
('CLI-147', 'RNT-123', 'Ignacio', 'Caceres', 33678901, 1, 1),
('CLI-148', 'RNT-123', 'Delfina', 'Montoya', 32789012, 1, 1),

-- Clientes para RNT-124
('CLI-149', 'RNT-124', 'Tomas', 'Campos', 31890123, 1, 1),
('CLI-150', 'RNT-124', 'Pilar', 'Duran', 30901234, 1, 1),

-- Clientes para RNT-125
('CLI-151', 'RNT-125', 'Facundo', 'Benitez', 29012345, 1, 1),

-- Clientes para RNT-126
('CLI-152', 'RNT-126', 'Amparo', 'Soto', 28123456, 1, 1),
('CLI-153', 'RNT-126', 'Patricio', 'Gallardo', 27234567, 1, 1),
('CLI-154', 'RNT-126', 'Milagros', 'Vera', 26345678, 1, 1),

-- Clientes para RNT-127
('CLI-155', 'RNT-127', 'Gaspar', 'Arce', 25456789, 1, 1),
('CLI-156', 'RNT-127', 'Macarena', 'Bernal', 24567890, 1, 1),

-- Clientes para RNT-128
('CLI-157', 'RNT-128', 'Eliseo', 'Quiroga', 23678901, 1, 1),
('CLI-158', 'RNT-128', 'Dolores', 'Escobar', 22789012, 1, 1),
('CLI-159', 'RNT-128', 'Leandro', 'Cabrera', 21890123, 1, 1),
('CLI-160', 'RNT-128', 'Esperanza', 'Miranda', 20901234, 1, 1),

-- Clientes para RNT-129
('CLI-161', 'RNT-129', 'Patricio', 'Avalos', 19012345, 1, 1),

-- Clientes para RNT-130
('CLI-162', 'RNT-130', 'Candela', 'Barrios', 18123456, 1, 1),

-- Clientes para RNT-131
('CLI-163', 'RNT-131', 'Benjamin', 'Coronel', 17234567, 1, 1),
('CLI-164', 'RNT-131', 'Micaela', 'Valdez', 16345678, 1, 1),
('CLI-165', 'RNT-131', 'Galo', 'Prieto', 15456789, 1, 1),
('CLI-166', 'RNT-131', 'Azul', 'Bustamante', 14567890, 1, 1),

-- Clientes para RNT-132
('CLI-167', 'RNT-132', 'Aurelio', 'Caballero', 13678901, 1, 1),
('CLI-168', 'RNT-132', 'Malena', 'Figueroa', 12789012, 1, 1),

-- Clientes para RNT-133
('CLI-169', 'RNT-133', 'Efrain', 'Lara', 11890123, 1, 1),
('CLI-170', 'RNT-133', 'Amelia', 'Villarroel', 10901234, 1, 1),
('CLI-171', 'RNT-133', 'Claudio', 'Arancibia', 78901235, 1, 1),

-- Clientes para RNT-134
('CLI-172', 'RNT-134', 'Josefina', 'Orellana', 78901236, 1, 1),
('CLI-173', 'RNT-134', 'Tobias', 'Mercado', 78901237, 1, 1),

-- Clientes para RNT-135
('CLI-174', 'RNT-135', 'Celestino', 'Antezana', 78901238, 1, 1),

-- Clientes para RNT-136
('CLI-175', 'RNT-136', 'Esperanza', 'Zenteno', 78901239, 1, 1),
('CLI-176', 'RNT-136', 'Florencio', 'Blanco', 78901240, 1, 1),
('CLI-177', 'RNT-136', 'Remedios', 'Franco', 78901241, 1, 1),
('CLI-178', 'RNT-136', 'Evaristo', 'Portillo', 78901242, 1, 1),

-- Clientes para RNT-137
('CLI-179', 'RNT-137', 'Graciela', 'Padilla', 78901243, 1, 1),
('CLI-180', 'RNT-137', 'Silverio', 'Gonzales', 78901244, 1, 1),

-- Clientes para RNT-138
('CLI-181', 'RNT-138', 'Trinidad', 'Perez', 78901245, 1, 1),
('CLI-182', 'RNT-138', 'Clemente', 'Lopez', 78901246, 1, 1),
('CLI-183', 'RNT-138', 'Soledad', 'Martinez', 78901247, 1, 1),

-- Clientes para RNT-139
('CLI-184', 'RNT-139', 'Abundio', 'Garcia', 78901248, 1, 1),
('CLI-185', 'RNT-139', 'Eusebia', 'Rodriguez', 78901249, 1, 1),

-- Clientes para RNT-140
('CLI-186', 'RNT-140', 'Policarpo', 'Hernandez', 78901250, 1, 1),

-- Clientes para RNT-141
('CLI-187', 'RNT-141', 'Crescencia', 'Sanchez', 78901251, 1, 1),
('CLI-188', 'RNT-141', 'Saturnino', 'Ramirez', 78901252, 1, 1),
('CLI-189', 'RNT-141', 'Primitiva', 'Torres', 78901253, 1, 1),
('CLI-190', 'RNT-141', 'Hermenegildo', 'Flores', 78901254, 1, 1),

-- Clientes para RNT-142
('CLI-191', 'RNT-142', 'Encarnacion', 'Rivera', 78901255, 1, 1),
('CLI-192', 'RNT-142', 'Melquiades', 'Gomez', 78901256, 1, 1),

-- Clientes para RNT-143
('CLI-193', 'RNT-143', 'Filomena', 'Diaz', 78901257, 1, 1),
('CLI-194', 'RNT-143', 'Epifanio', 'Ruiz', 78901258, 1, 1),

-- Clientes para RNT-144
('CLI-195', 'RNT-144', 'Purificacion', 'Morales', 78901259, 1, 1),
('CLI-196', 'RNT-144', 'Telesforo', 'Jimenez', 78901260, 1, 1),
('CLI-197', 'RNT-144', 'Concordia', 'Herrera', 78901261, 1, 1),

-- Clientes para RNT-145
('CLI-198', 'RNT-145', 'Nepomuceno', 'Aguilar', 78901262, 1, 1),

-- Clientes para RNT-146
('CLI-199', 'RNT-146', 'Candelaria', 'Vargas', 78901263, 1, 1),
('CLI-200', 'RNT-146', 'Aniceto', 'Castro', 78901264, 1, 1);

-- TABLA DETALLE RENTA
INSERT INTO DetalleRenta (RentaID, ProductoID, Cantidad, Subtotal, Habilitado) VALUES 
-- RNT-101 detalles
('RNT-101', 'PRD-001', 2, 1200, 1), -- Chaqueta Rojo/Negro
('RNT-101', 'PRD-004', 3, 300, 1), -- Faja Rojo/Negro

-- RNT-102 detalles
('RNT-102', 'PRD-026', 1, 600, 1), -- Chaqueta Verde Whatsapp
('RNT-102', 'PRD-098', 1, 300, 1), -- Pollera Roja

-- RNT-103 detalles
('RNT-103', 'PRD-011', 3, 1800, 1), -- Chaqueta Rojo/Dorado
('RNT-103', 'PRD-013', 2, 400, 1), -- Pantalón Rojo/Dorado

-- RNT-104 detalles
('RNT-104', 'PRD-056', 1, 900, 1), -- Chaqueta Plateado/Negro
('RNT-104', 'PRD-081', 1, 250, 1), -- Pepino

-- RNT-105 detalles
('RNT-105', 'PRD-036', 1, 600, 1), -- Chaqueta Morado
('RNT-105', 'PRD-094', 3, 300, 1), -- Corbatas Rojo/Negro

-- RNT-106 detalles
('RNT-106', 'PRD-006', 2, 1200, 1), -- Chaqueta Azul/Crema
('RNT-106', 'PRD-008', 3, 900, 1), -- Pantalón Azul/Crema

-- RNT-107 detalles
('RNT-107', 'PRD-076', 1, 600, 1), -- Chaqueta Azul/Celeste
('RNT-107', 'PRD-104', 1, 250, 1), -- Sombrero Blanco

-- RNT-108 detalles
('RNT-108', 'PRD-031', 3, 1800, 1), -- Chaqueta Tricolor
('RNT-108', 'PRD-033', 2, 400, 1), -- Pantalón Tricolor
('RNT-108', 'PRD-090', 1, 300, 1), -- Minero

-- RNT-109 detalles
('RNT-109', 'PRD-041', 2, 1200, 1), -- Chaqueta Guindo
('RNT-109', 'PRD-082', 1, 250, 1), -- Pepino Dorado/Azul

-- RNT-110 detalles
('RNT-110', 'PRD-061', 1, 600, 1), -- Chaqueta Celeste Bolivar
('RNT-110', 'PRD-095', 2, 200, 1), -- Corbatas Azul/Crema

-- RNT-111 detalles
('RNT-111', 'PRD-021', 2, 800, 1), -- Chaqueta Blanco/Plateado
('RNT-111', 'PRD-023', 3, 600, 1), -- Pantalón Blanco/Plateado
('RNT-111', 'PRD-106', 2, 700, 1), -- Máscaras Azul/Blanco

-- RNT-112 detalles
('RNT-112', 'PRD-016', 1, 500, 1), -- Chaqueta Negro/Verde
('RNT-112', 'PRD-018', 3, 600, 1), -- Pantalón Negro/Verde

-- RNT-113 detalles
('RNT-113', 'PRD-001', 4, 2400, 1), -- Chaqueta Rojo/Negro
('RNT-113', 'PRD-003', 4, 800, 1), -- Pantalón Rojo/Negro

-- RNT-114 detalles
('RNT-114', 'PRD-066', 1, 600, 1), -- Chaqueta Café
('RNT-114', 'PRD-091', 1, 200, 1), -- Chavo
('RNT-114', 'PRD-112', 1, 420, 1), -- Zapatos Morado

-- RNT-115 detalles
('RNT-115', 'PRD-071', 1, 60, 1), -- Chaqueta Rosado
('RNT-115', 'PRD-073', 4, 480, 1), -- Pantalón Rosado
('RNT-115', 'PRD-096', 2, 200, 1), -- Corbatas Tricolor

-- RNT-116 detalles
('RNT-116', 'PRD-051', 3, 1800, 1), -- Chaqueta Dorado/Negro
('RNT-116', 'PRD-053', 5, 1000, 1), -- Pantalón Dorado/Negro

-- RNT-117 detalles
('RNT-117', 'PRD-046', 2, 1200, 1), -- Chaqueta Verde Pacai

-- RNT-118 detalles
('RNT-118', 'PRD-037', 2, 1400, 1), -- Chaquetilla Morado
('RNT-118', 'PRD-083', 1, 250, 1), -- Pepino Rojo/Dorado
('RNT-118', 'PRD-107', 1, 350, 1), -- Máscaras Naranja/Blanco

-- RNT-119 detalles
('RNT-119', 'PRD-062', 1, 500, 1), -- Chaquetilla Celeste Bolivar
('RNT-119', 'PRD-092', 2, 400, 1), -- Chapulin
('RNT-119', 'PRD-105', 1, 250, 1), -- Sombrero Negro

-- RNT-120 detalles
('RNT-120', 'PRD-072', 1, 50, 1), -- Chaquetilla Rosado
('RNT-120', 'PRD-097', 5, 500, 1), -- Corbatas Morado
('RNT-120', 'PRD-113', 1, 200, 1), -- Chinelas Morado

-- RNT-121 detalles
('RNT-121', 'PRD-006', 2, 1200, 1), -- Chaqueta Azul/Crema
('RNT-121', 'PRD-007', 1, 500, 1), -- Chaquetilla Azul/Crema
('RNT-121', 'PRD-084', 2, 500, 1), -- Pepino Negro/Amarillo

-- RNT-122 detalles
('RNT-122', 'PRD-026', 2, 1200, 1), -- Chaqueta Verde Whatsapp
('RNT-122', 'PRD-028', 1, 300, 1), -- Pantalón Verde Whatsapp

-- RNT-123 detalles
('RNT-123', 'PRD-056', 3, 2700, 1), -- Chaqueta Plateado/Negro
('RNT-123', 'PRD-057', 1, 1000, 1), -- Chaquetilla Plateado/Negro

-- RNT-124 detalles
('RNT-124', 'PRD-011', 2, 1200, 1), -- Chaqueta Rojo/Dorado
('RNT-124', 'PRD-012', 1, 500, 1), -- Chaquetilla Rojo/Dorado
('RNT-124', 'PRD-093', 1, 300, 1), -- Saya

-- RNT-125 detalles
('RNT-125', 'PRD-067', 1, 500, 1), -- Chaquetilla Café
('RNT-125', 'PRD-108', 1, 350, 1), -- Máscaras Rosado/Blanco

-- RNT-126 detalles
('RNT-126', 'PRD-031', 3, 1800, 1), -- Chaqueta Tricolor
('RNT-126', 'PRD-032', 2, 1000, 1), -- Chaquetilla Tricolor

-- RNT-127 detalles
('RNT-127', 'PRD-076', 1, 600, 1), -- Chaqueta Azul/Celeste
('RNT-127', 'PRD-077', 1, 500, 1), -- Chaquetilla Azul/Celeste

-- RNT-128 detalles
('RNT-128', 'PRD-001', 5, 3000, 1), -- Chaqueta Rojo/Negro
('RNT-128', 'PRD-002', 3, 1500, 1), -- Chaquetilla Rojo/Negro

-- RNT-129 detalles
('RNT-129', 'PRD-041', 1, 600, 1), -- Chaqueta Guindo
('RNT-129', 'PRD-085', 2, 500, 1), -- Pepino Verde/Amarillo

-- RNT-130 detalles
('RNT-130', 'PRD-036', 1, 600, 1), -- Chaqueta Morado
('RNT-130', 'PRD-109', 1, 350, 1), -- Máscaras Azul/Rojo

-- RNT-131 detalles
('RNT-131', 'PRD-051', 4, 2400, 1), -- Chaqueta Dorado/Negro
('RNT-131', 'PRD-052', 2, 1000, 1), -- Chaquetilla Dorado/Negro
('RNT-131', 'PRD-086', 2, 500, 1), -- Pepino Azul/Rojo

-- RNT-132 detalles
('RNT-132', 'PRD-021', 2, 800, 1), -- Chaqueta Blanco/Plateado
('RNT-132', 'PRD-022', 2, 600, 1), -- Chaquetilla Blanco/Plateado
('RNT-132', 'PRD-098', 1, 300, 1), -- Pollera Roja

-- RNT-133 detalles
('RNT-133', 'PRD-016', 3, 1500, 1), -- Chaqueta Negro/Verde
('RNT-133', 'PRD-017', 2, 800, 1), -- Chaquetilla Negro/Verde
('RNT-133', 'PRD-087', 3, 750, 1), -- Pepino Rosado/Blanco

-- RNT-134 detalles
('RNT-134', 'PRD-061', 2, 1200, 1), -- Chaqueta Celeste Bolivar
('RNT-134', 'PRD-110', 2, 700, 1), -- Máscaras Verde/Blanco

-- RNT-135 detalles
('RNT-135', 'PRD-066', 1, 600, 1), -- Chaqueta Café
('RNT-135', 'PRD-099', 1, 300, 1), -- Pollera Azul
('RNT-135', 'PRD-104', 1, 250, 1), -- Sombrero Blanco

-- RNT-136 detalles
('RNT-136', 'PRD-056', 4, 3600, 1), -- Chaqueta Plateado/Negro
('RNT-136', 'PRD-057', 2, 2000, 1), -- Chaquetilla Plateado/Negro

-- RNT-137 detalles
('RNT-137', 'PRD-006', 2, 1200, 1), -- Chaqueta Azul/Crema
('RNT-137', 'PRD-008', 3, 900, 1), -- Pantalón Azul/Crema

-- RNT-138 detalles
('RNT-138', 'PRD-031', 3, 1800, 1), -- Chaqueta Tricolor
('RNT-138', 'PRD-033', 4, 800, 1), -- Pantalón Tricolor
('RNT-138', 'PRD-088', 2, 500, 1), -- Pepino Morado/Blanco

-- RNT-139 detalles
('RNT-139', 'PRD-046', 1, 600, 1), -- Chaqueta Verde Pacai
('RNT-139', 'PRD-047', 1, 500, 1), -- Chaquetilla Verde Pacai
('RNT-139', 'PRD-100', 1, 300, 1), -- Pollera Negra

-- RNT-140 detalles
('RNT-140', 'PRD-071', 1, 60, 1), -- Chaqueta Rosado
('RNT-140', 'PRD-072', 1, 50, 1), -- Chaquetilla Rosado
('RNT-140', 'PRD-089', 3, 750, 1), -- Pepino Celeste/Blanco

-- RNT-141 detalles
('RNT-141', 'PRD-001', 5, 3000, 1), -- Chaqueta Rojo/Negro
('RNT-141', 'PRD-003', 5, 1000, 1), -- Pantalón Rojo/Negro
('RNT-141', 'PRD-081', 4, 1000, 1), -- Pepino Verde/Blanco

-- RNT-142 detalles
('RNT-142', 'PRD-011', 2, 1200, 1), -- Chaqueta Rojo/Dorado
('RNT-142', 'PRD-012', 2, 1000, 1), -- Chaquetilla Rojo/Dorado

-- RNT-143 detalles
('RNT-143', 'PRD-026', 2, 1200, 1), -- Chaqueta Verde Whatsapp
('RNT-143', 'PRD-101', 1, 300, 1), -- Pollera Blanca
('RNT-143', 'PRD-112', 1, 420, 1), -- Zapatos Morado

-- RNT-144 detalles
('RNT-144', 'PRD-051', 4, 2400, 1), -- Chaqueta Dorado/Negro
('RNT-144', 'PRD-053', 5, 1000, 1), -- Pantalón Dorado/Negro
('RNT-144', 'PRD-090', 1, 300, 1), -- Minero

-- RNT-145 detalles
('RNT-145', 'PRD-036', 1, 600, 1), -- Chaqueta Morado
('RNT-145', 'PRD-038', 1, 400, 1), -- Pantalón Morado

-- RNT-146 detalles
('RNT-146', 'PRD-016', 3, 1500, 1), -- Chaqueta Negro/Verde
('RNT-146', 'PRD-018', 4, 800, 1), -- Pantalón Negro/Verde
('RNT-146', 'PRD-082', 2, 500, 1); -- Pepino Dorado/Azul

-- TABLA GARANTIA
INSERT INTO Garantia (RentaID, ClienteID, Tipo, Habilitado) VALUES 
-- Garantías para RNT-101
('RNT-101', 'CLI-101', 'Cédula de Identidad', 1),
('RNT-101', 'CLI-101', 'Licencia de Conducir', 1),
('RNT-101', 'CLI-102', 'Cédula de Identidad', 1),

-- Garantías para RNT-102
('RNT-102', 'CLI-103', 'Cédula de Identidad', 1),
('RNT-102', 'CLI-103', 'Pasaporte', 1),

-- Garantías para RNT-103
('RNT-103', 'CLI-104', 'Cédula de Identidad', 1),
('RNT-103', 'CLI-105', 'Licencia de Conducir', 1),
('RNT-103', 'CLI-106', 'Cédula de Identidad', 1),
('RNT-103', 'CLI-106', 'Carnet Universitario', 1),

-- Garantías para RNT-104
('RNT-104', 'CLI-107', 'Cédula de Identidad', 1),
('RNT-104', 'CLI-108', 'Licencia de Conducir', 1),
('RNT-104', 'CLI-108', 'Cédula de Identidad', 1),

-- Garantías para RNT-105
('RNT-105', 'CLI-109', 'Cédula de Identidad', 1),

-- Garantías para RNT-106
('RNT-106', 'CLI-110', 'Cédula de Identidad', 1),
('RNT-106', 'CLI-110', 'Licencia de Conducir', 1),
('RNT-106', 'CLI-111', 'Cédula de Identidad', 1),

-- Garantías para RNT-107
('RNT-107', 'CLI-112', 'Cédula de Identidad', 1),
('RNT-107', 'CLI-112', 'Pasaporte', 1),

-- Garantías para RNT-108
('RNT-108', 'CLI-113', 'Cédula de Identidad', 1),
('RNT-108', 'CLI-114', 'Licencia de Conducir', 1),
('RNT-108', 'CLI-115', 'Cédula de Identidad', 1),
('RNT-108', 'CLI-115', 'Carnet Universitario', 1),

-- Garantías para RNT-109
('RNT-109', 'CLI-116', 'Cédula de Identidad', 1),
('RNT-109', 'CLI-117', 'Licencia de Conducir', 1),
('RNT-109', 'CLI-117', 'Cédula de Identidad', 1),

-- Garantías para RNT-110
('RNT-110', 'CLI-118', 'Cédula de Identidad', 1),

-- Garantías para RNT-111
('RNT-111', 'CLI-119', 'Cédula de Identidad', 1),
('RNT-111', 'CLI-120', 'Licencia de Conducir', 1),
('RNT-111', 'CLI-121', 'Cédula de Identidad', 1),
('RNT-111', 'CLI-121', 'Pasaporte', 1),

-- Garantías para RNT-112
('RNT-112', 'CLI-122', 'Cédula de Identidad', 1),
('RNT-112', 'CLI-123', 'Licencia de Conducir', 1),

-- Garantías para RNT-113
('RNT-113', 'CLI-124', 'Cédula de Identidad', 1),
('RNT-113', 'CLI-125', 'Licencia de Conducir', 1),
('RNT-113', 'CLI-126', 'Cédula de Identidad', 1),
('RNT-113', 'CLI-127', 'Carnet Universitario', 1),
('RNT-113', 'CLI-127', 'Cédula de Identidad', 1),

-- Garantías para RNT-114
('RNT-114', 'CLI-128', 'Cédula de Identidad', 1),

-- Garantías para RNT-115
('RNT-115', 'CLI-129', 'Cédula de Identidad', 1),
('RNT-115', 'CLI-129', 'Licencia de Conducir', 1),

-- Garantías para RNT-116
('RNT-116', 'CLI-130', 'Cédula de Identidad', 1),
('RNT-116', 'CLI-131', 'Licencia de Conducir', 1),
('RNT-116', 'CLI-132', 'Cédula de Identidad', 1),
('RNT-116', 'CLI-132', 'Pasaporte', 1),

-- Garantías para RNT-117
('RNT-117', 'CLI-133', 'Cédula de Identidad', 1),
('RNT-117', 'CLI-134', 'Licencia de Conducir', 1),

-- Garantías para RNT-118
('RNT-118', 'CLI-135', 'Cédula de Identidad', 1),
('RNT-118', 'CLI-136', 'Cédula de Identidad', 1),
('RNT-118', 'CLI-136', 'Carnet Universitario', 1),

-- Garantías para RNT-119
('RNT-119', 'CLI-137', 'Cédula de Identidad', 1),
('RNT-119', 'CLI-138', 'Licencia de Conducir', 1),

-- Garantías para RNT-120
('RNT-120', 'CLI-139', 'Cédula de Identidad', 1),

-- Garantías para RNT-121
('RNT-121', 'CLI-140', 'Cédula de Identidad', 1),
('RNT-121', 'CLI-141', 'Licencia de Conducir', 1),
('RNT-121', 'CLI-142', 'Cédula de Identidad', 1),
('RNT-121', 'CLI-142', 'Pasaporte', 1),

-- Garantías para RNT-122
('RNT-122', 'CLI-143', 'Cédula de Identidad', 1),
('RNT-122', 'CLI-144', 'Licencia de Conducir', 1),

-- Garantías para RNT-123
('RNT-123', 'CLI-145', 'Cédula de Identidad', 1),
('RNT-123', 'CLI-146', 'Licencia de Conducir', 1),
('RNT-123', 'CLI-147', 'Cédula de Identidad', 1),
('RNT-123', 'CLI-148', 'Cédula de Identidad', 1),
('RNT-123', 'CLI-148', 'Carnet Universitario', 1),

-- Garantías para RNT-124
('RNT-124', 'CLI-149', 'Cédula de Identidad', 1),
('RNT-124', 'CLI-150', 'Licencia de Conducir', 1),

-- Garantías para RNT-125
('RNT-125', 'CLI-151', 'Cédula de Identidad', 1),
('RNT-125', 'CLI-151', 'Pasaporte', 1),

-- Garantías para RNT-126
('RNT-126', 'CLI-152', 'Cédula de Identidad', 1),
('RNT-126', 'CLI-153', 'Licencia de Conducir', 1),
('RNT-126', 'CLI-154', 'Cédula de Identidad', 1),

-- Garantías para RNT-127
('RNT-127', 'CLI-155', 'Cédula de Identidad', 1),
('RNT-127', 'CLI-156', 'Licencia de Conducir', 1),
('RNT-127', 'CLI-156', 'Cédula de Identidad', 1),

-- Garantías para RNT-128
('RNT-128', 'CLI-157', 'Cédula de Identidad', 1),
('RNT-128', 'CLI-158', 'Licencia de Conducir', 1),
('RNT-128', 'CLI-159', 'Cédula de Identidad', 1),
('RNT-128', 'CLI-160', 'Cédula de Identidad', 1),
('RNT-128', 'CLI-160', 'Pasaporte', 1),

-- Garantías para RNT-129
('RNT-129', 'CLI-161', 'Cédula de Identidad', 1),

-- Garantías para RNT-130
('RNT-130', 'CLI-162', 'Cédula de Identidad', 1),
('RNT-130', 'CLI-162', 'Licencia de Conducir', 1),

-- Garantías para RNT-131
('RNT-131', 'CLI-163', 'Cédula de Identidad', 1),
('RNT-131', 'CLI-164', 'Licencia de Conducir', 1),
('RNT-131', 'CLI-165', 'Cédula de Identidad', 1),
('RNT-131', 'CLI-166', 'Cédula de Identidad', 1),
('RNT-131', 'CLI-166', 'Carnet Universitario', 1),

-- Garantías para RNT-132
('RNT-132', 'CLI-167', 'Cédula de Identidad', 1),
('RNT-132', 'CLI-168', 'Licencia de Conducir', 1),

-- Garantías para RNT-133
('RNT-133', 'CLI-169', 'Cédula de Identidad', 1),
('RNT-133', 'CLI-170', 'Licencia de Conducir', 1),
('RNT-133', 'CLI-171', 'Cédula de Identidad', 1),
('RNT-133', 'CLI-171', 'Pasaporte', 1),

-- Garantías para RNT-134
('RNT-134', 'CLI-172', 'Cédula de Identidad', 1),
('RNT-134', 'CLI-173', 'Licencia de Conducir', 1),

-- Garantías para RNT-135
('RNT-135', 'CLI-174', 'Cédula de Identidad', 1),

-- Garantías para RNT-136
('RNT-136', 'CLI-175', 'Cédula de Identidad', 1),
('RNT-136', 'CLI-176', 'Licencia de Conducir', 1),
('RNT-136', 'CLI-177', 'Cédula de Identidad', 1),
('RNT-136', 'CLI-178', 'Cédula de Identidad', 1),
('RNT-136', 'CLI-178', 'Carnet Universitario', 1),

-- Garantías para RNT-137
('RNT-137', 'CLI-179', 'Cédula de Identidad', 1),
('RNT-137', 'CLI-180', 'Licencia de Conducir', 1),

-- Garantías para RNT-138
('RNT-138', 'CLI-181', 'Cédula de Identidad', 1),
('RNT-138', 'CLI-182', 'Licencia de Conducir', 1),
('RNT-138', 'CLI-183', 'Cédula de Identidad', 1),
('RNT-138', 'CLI-183', 'Pasaporte', 1),

-- Garantías para RNT-139
('RNT-139', 'CLI-184', 'Cédula de Identidad', 1),
('RNT-139', 'CLI-185', 'Licencia de Conducir', 1),

-- Garantías para RNT-140
('RNT-140', 'CLI-186', 'Cédula de Identidad', 1),

-- Garantías para RNT-141
('RNT-141', 'CLI-187', 'Cédula de Identidad', 1),
('RNT-141', 'CLI-188', 'Licencia de Conducir', 1),
('RNT-141', 'CLI-189', 'Cédula de Identidad', 1),
('RNT-141', 'CLI-190', 'Cédula de Identidad', 1),
('RNT-141', 'CLI-190', 'Carnet Universitario', 1),

-- Garantías para RNT-142
('RNT-142', 'CLI-191', 'Cédula de Identidad', 1),
('RNT-142', 'CLI-192', 'Licencia de Conducir', 1),

-- Garantías para RNT-143
('RNT-143', 'CLI-193', 'Cédula de Identidad', 1),
('RNT-143', 'CLI-194', 'Licencia de Conducir', 1),
('RNT-143', 'CLI-194', 'Cédula de Identidad', 1),

-- Garantías para RNT-144
('RNT-144', 'CLI-195', 'Cédula de Identidad', 1),
('RNT-144', 'CLI-196', 'Licencia de Conducir', 1),
('RNT-144', 'CLI-197', 'Cédula de Identidad', 1),
('RNT-144', 'CLI-197', 'Pasaporte', 1),

-- Garantías para RNT-145
('RNT-145', 'CLI-198', 'Cédula de Identidad', 1),

-- Garantías para RNT-146
('RNT-146', 'CLI-199', 'Cédula de Identidad', 1),
('RNT-146', 'CLI-200', 'Licencia de Conducir', 1),
('RNT-146', 'CLI-200', 'Cédula de Identidad', 1);

-- RENTAS ENERO 2025
-- Inserts para tabla Renta
INSERT INTO Renta (RentaID, EmpleadoID, FechaRenta, FechaDevolucion, FechaDevuelto, Descuento, Total, Multa) VALUES 
-- Día 2 enero (jueves)
('RNT-147', 'MGR-001', '2025-01-02', '2025-01-07', NULL, 0, 1500, 0),
('RNT-148', 'MGR-002', '2025-01-02', '2025-01-09', NULL, 10, 1350, 0),

-- Día 3 enero (viernes)
('RNT-149', 'MGR-001', '2025-01-03', '2025-01-08', NULL, 0, 2200, 0),
('RNT-150', 'MGR-002', '2025-01-03', '2025-01-10', NULL, 5, 950, 0),
('RNT-151', 'MGR-001', '2025-01-03', '2025-01-11', NULL, 0, 800, 0),

-- Día 6 enero (lunes)
('RNT-152', 'MGR-002', '2025-01-06', '2025-01-13', NULL, 0, 1800, 0),
('RNT-153', 'MGR-001', '2025-01-06', '2025-01-11', NULL, 15, 1275, 0),

-- Día 7 enero (martes)
('RNT-154', 'MGR-001', '2025-01-07', '2025-01-14', NULL, 0, 3200, 0),

-- Día 8 enero (miércoles)
('RNT-155', 'MGR-002', '2025-01-08', '2025-01-15', NULL, 0, 1600, 0),
('RNT-156', 'MGR-001', '2025-01-08', '2025-01-13', NULL, 0, 900, 0),
('RNT-157', 'MGR-002', '2025-01-08', '2025-01-16', NULL, 20, 800, 0),

-- Día 9 enero (jueves)
('RNT-158', 'MGR-001', '2025-01-09', '2025-01-16', NULL, 0, 2100, 0),
('RNT-159', 'MGR-002', '2025-01-09', '2025-01-14', NULL, 10, 1080, 0),

-- Día 10 enero (viernes)
('RNT-160', 'MGR-001', '2025-01-10', '2025-01-17', NULL, 0, 1400, 0),

-- Día 13 enero (lunes)
('RNT-161', 'MGR-002', '2025-01-13', '2025-01-20', NULL, 0, 2800, 0),
('RNT-162', 'MGR-001', '2025-01-13', '2025-01-18', NULL, 5, 1425, 0),
('RNT-163', 'MGR-002', '2025-01-13', '2025-01-21', NULL, 0, 1200, 0),

-- Día 14 enero (martes)
('RNT-164', 'MGR-001', '2025-01-14', '2025-01-21', NULL, 0, 1900, 0),
('RNT-165', 'MGR-002', '2025-01-14', '2025-01-19', NULL, 0, 750, 0),

-- Día 15 enero (miércoles)
('RNT-166', 'MGR-001', '2025-01-15', '2025-01-22', NULL, 0, 3500, 0),
('RNT-167', 'MGR-002', '2025-01-15', '2025-01-20', NULL, 15, 1275, 0),

-- Día 16 enero (jueves)
('RNT-168', 'MGR-001', '2025-01-16', '2025-01-23', NULL, 0, 2600, 0),

-- Día 17 enero (viernes)
('RNT-169', 'MGR-002', '2025-01-17', '2025-01-24', NULL, 0, 1800, 0),
('RNT-170', 'MGR-001', '2025-01-17', '2025-01-22', NULL, 10, 1620, 0),
('RNT-171', 'MGR-002', '2025-01-17', '2025-01-25', NULL, 0, 1100, 0),

-- Día 20 enero (lunes)
('RNT-172', 'MGR-001', '2025-01-20', '2025-01-27', NULL, 0, 2200, 0),
('RNT-173', 'MGR-002', '2025-01-20', '2025-01-25', NULL, 0, 1350, 0),

-- Día 21 enero (martes)
('RNT-174', 'MGR-001', '2025-01-21', '2025-01-28', NULL, 5, 1425, 0),
('RNT-175', 'MGR-002', '2025-01-21', '2025-01-26', NULL, 0, 950, 0),

-- Día 22 enero (miércoles)
('RNT-176', 'MGR-001', '2025-01-22', '2025-01-29', NULL, 0, 3100, 0),

-- Día 23 enero (jueves)
('RNT-177', 'MGR-002', '2025-01-23', '2025-01-30', NULL, 0, 1650, 0),
('RNT-178', 'MGR-001', '2025-01-23', '2025-01-28', NULL, 20, 1440, 0),

-- Día 24 enero (viernes)
('RNT-179', 'MGR-001', '2025-01-24', '2025-01-31', NULL, 0, 2400, 0),
('RNT-180', 'MGR-002', '2025-01-24', '2025-01-29', NULL, 0, 800, 0),

-- Día 27 enero (lunes)
('RNT-181', 'MGR-001', '2025-01-27', '2025-02-03', NULL, 0, 2900, 0),
('RNT-182', 'MGR-002', '2025-01-27', '2025-02-01', NULL, 10, 1350, 0),

-- Día 28 enero (martes)
('RNT-183', 'MGR-001', '2025-01-28', '2025-02-04', NULL, 0, 1750, 0),

-- Día 29 enero (miércoles)
('RNT-184', 'MGR-002', '2025-01-29', '2025-02-05', NULL, 0, 2100, 0),
('RNT-185', 'MGR-001', '2025-01-29', '2025-02-03', NULL, 15, 1275, 0),
('RNT-186', 'MGR-002', '2025-01-29', '2025-02-07', NULL, 0, 1200, 0),

-- Día 30 enero (jueves)
('RNT-187', 'MGR-001', '2025-01-30', '2025-02-06', NULL, 0, 3200, 0),
('RNT-188', 'MGR-002', '2025-01-30', '2025-02-04', NULL, 0, 900, 0),

-- Día 31 enero (viernes)
('RNT-189', 'MGR-001', '2025-01-31', '2025-02-07', NULL, 5, 1900, 0);

-- Inserts para tabla Cliente
INSERT INTO Cliente (ClienteID, RentaID, Nombre, Apellido, Telefono, Garantia, Habilitado) VALUES 
-- RNT-147
('CLI-147-1', 'RNT-147', 'Ana María', 'Fernández', 78456123, 1, 1),
('CLI-147-2', 'RNT-147', 'Roberto', 'Vargas', 76234567, 1, 1),

-- RNT-148
('CLI-148-1', 'RNT-148', 'Carmen Rosa', 'Jiménez', 77891234, 1, 1),

-- RNT-149
('CLI-149-1', 'RNT-149', 'José Luis', 'Mamani', 75678901, 1, 1),
('CLI-149-2', 'RNT-149', 'Patricia', 'Condori', 78234567, 1, 1),

-- RNT-150
('CLI-150-1', 'RNT-150', 'Miguel Ángel', 'Ticona', 76789012, 1, 1),

-- RNT-151
('CLI-151-1', 'RNT-151', 'Lucía', 'Choque', 77345678, 1, 1),

-- RNT-152
('CLI-152-1', 'RNT-152', 'Fernando', 'Huanca', 75234567, 1, 1),
('CLI-152-2', 'RNT-152', 'Sandra', 'Apaza', 78901234, 1, 1),

-- RNT-153
('CLI-153-1', 'RNT-153', 'Ricardo', 'Flores', 76456789, 1, 1),

-- RNT-154
('CLI-154-1', 'RNT-154', 'Elena', 'Chávez', 77567890, 1, 1),
('CLI-154-2', 'RNT-154', 'David', 'Morales', 75890123, 1, 1),
('CLI-154-3', 'RNT-154', 'Mónica', 'Gutiérrez', 78123456, 1, 1),

-- RNT-155
('CLI-155-1', 'RNT-155', 'Andrés', 'Rojas', 76678901, 1, 1),

-- RNT-156
('CLI-156-1', 'RNT-156', 'Gabriela', 'Sánchez', 77234567, 1, 1),

-- RNT-157
('CLI-157-1', 'RNT-157', 'Pablo', 'Mendoza', 75567890, 1, 1),

-- RNT-158
('CLI-158-1', 'RNT-158', 'Verónica', 'Castro', 78345678, 1, 1),
('CLI-158-2', 'RNT-158', 'Alejandro', 'Ramos', 76890123, 1, 1),

-- RNT-159
('CLI-159-1', 'RNT-159', 'Silvia', 'Herrera', 77456789, 1, 1),

-- RNT-160
('CLI-160-1', 'RNT-160', 'Marcelo', 'Torrez', 75789012, 1, 1),

-- RNT-161
('CLI-161-1', 'RNT-161', 'Rosa María', 'Villarroel', 78567890, 1, 1),
('CLI-161-2', 'RNT-161', 'Carlos Eduardo', 'Limachi', 76123456, 1, 1),

-- RNT-162
('CLI-162-1', 'RNT-162', 'Antonio', 'Pacheco', 77678901, 1, 1),

-- RNT-163
('CLI-163-1', 'RNT-163', 'María José', 'Camacho', 75234567, 1, 1),

-- RNT-164
('CLI-164-1', 'RNT-164', 'Gonzalo', 'Quiroga', 78789012, 1, 1),
('CLI-164-2', 'RNT-164', 'Liliana', 'Espinoza', 76345678, 1, 1),

-- RNT-165
('CLI-165-1', 'RNT-165', 'Ramiro', 'Delgado', 77890123, 1, 1),

-- RNT-166
('CLI-166-1', 'RNT-166', 'Carla', 'Machicado', 75456789, 1, 1),
('CLI-166-2', 'RNT-166', 'Edmundo', 'Salinas', 78012345, 1, 1),
('CLI-166-3', 'RNT-166', 'Yolanda', 'Cortez', 76567890, 1, 1),

-- RNT-167
('CLI-167-1', 'RNT-167', 'Hernán', 'Peña', 77123456, 1, 1),

-- RNT-168
('CLI-168-1', 'RNT-168', 'Beatriz', 'Arce', 75678901, 1, 1),
('CLI-168-2', 'RNT-168', 'Gustavo', 'Medina', 78234567, 1, 1),

-- RNT-169
('CLI-169-1', 'RNT-169', 'Nadia', 'Vega', 76789012, 1, 1),

-- RNT-170
('CLI-170-1', 'RNT-170', 'Oscar', 'Vásquez', 77345678, 1, 1),
('CLI-170-2', 'RNT-170', 'Diana', 'Campos', 75901234, 1, 1),

-- RNT-171
('CLI-171-1', 'RNT-171', 'Julio', 'Aguilar', 78456789, 1, 1),

-- RNT-172
('CLI-172-1', 'RNT-172', 'Teresa', 'Montoya', 76012345, 1, 1),
('CLI-172-2', 'RNT-172', 'Édgar', 'Ibañez', 77567890, 1, 1),

-- RNT-173
('CLI-173-1', 'RNT-173', 'Gladys', 'Nogales', 75123456, 1, 1),

-- RNT-174
('CLI-174-1', 'RNT-174', 'Iván', 'Zenteno', 78678901, 1, 1),

-- RNT-175
('CLI-175-1', 'RNT-175', 'Marlene', 'Burgos', 76234567, 1, 1),

-- RNT-176
('CLI-176-1', 'RNT-176', 'Rubén', 'Torrico', 77789012, 1, 1),
('CLI-176-2', 'RNT-176', 'Susana', 'Paredes', 75345678, 1, 1),
('CLI-176-3', 'RNT-176', 'Freddy', 'Almanza', 78890123, 1, 1),

-- RNT-177
('CLI-177-1', 'RNT-177', 'Estela', 'Miranda', 76456789, 1, 1),

-- RNT-178
('CLI-178-1', 'RNT-178', 'Alberto', 'Castellanos', 77012345, 1, 1),

-- RNT-179
('CLI-179-1', 'RNT-179', 'Norma', 'Rivero', 75567890, 1, 1),
('CLI-179-2', 'RNT-179', 'Jaime', 'Cordero', 78123456, 1, 1),

-- RNT-180
('CLI-180-1', 'RNT-180', 'Fabiola', 'Urquizu', 76678901, 1, 1),

-- RNT-181
('CLI-181-1', 'RNT-181', 'Wilber', 'Escalante', 77234567, 1, 1),
('CLI-181-2', 'RNT-181', 'Miriam', 'Solares', 75890123, 1, 1),

-- RNT-182
('CLI-182-1', 'RNT-182', 'Rolando', 'Justiniano', 78345678, 1, 1),

-- RNT-183
('CLI-183-1', 'RNT-183', 'Vanessa', 'Calderón', 76901234, 1, 1),
('CLI-183-2', 'RNT-183', 'Mauricio', 'Herbas', 77456789, 1, 1),

-- RNT-184
('CLI-184-1', 'RNT-184', 'Ingrid', 'Mercado', 75012345, 1, 1),
('CLI-184-2', 'RNT-184', 'Sergio', 'Daza', 78567890, 1, 1),

-- RNT-185
('CLI-185-1', 'RNT-185', 'Ximena', 'Terrazas', 76123456, 1, 1),

-- RNT-186
('CLI-186-1', 'RNT-186', 'Waldo', 'Barragán', 77678901, 1, 1),

-- RNT-187
('CLI-187-1', 'RNT-187', 'Claudia', 'Bustillos', 75234567, 1, 1),
('CLI-187-2', 'RNT-187', 'Víctor', 'Colque', 78789012, 1, 1),
('CLI-187-3', 'RNT-187', 'Jenny', 'Valdivia', 76345678, 1, 1),

-- RNT-188
('CLI-188-1', 'RNT-188', 'Armando', 'Pereira', 77890123, 1, 1),

-- RNT-189
('CLI-189-1', 'RNT-189', 'Karina', 'Durán', 75456789, 1, 1),
('CLI-189-2', 'RNT-189', 'Nelson', 'Bernal', 78012345, 1, 1);

-- Inserts para tabla DetalleRenta
INSERT INTO DetalleRenta (RentaID, ProductoID, Cantidad, Subtotal, Habilitado) VALUES 
-- RNT-147
('RNT-147', 'PRD-001', 2, 1200, 1), -- Chaqueta Rojo/Negro
('RNT-147', 'PRD-005', 3, 300, 1), -- Chuspa Rojo/Negro

-- RNT-148
('RNT-148', 'PRD-026', 2, 1200, 1), -- Chaqueta Verde Whatsapp
('RNT-148', 'PRD-094', 3, 300, 1), -- Corbatas

-- RNT-149
('RNT-149', 'PRD-036', 3, 1800, 1), -- Chaqueta Morado
('RNT-149', 'PRD-038', 2, 800, 1), -- Pantalón Morado

-- RNT-150
('RNT-150', 'PRD-081', 2, 500, 1), -- Pepino
('RNT-150', 'PRD-098', 1, 300, 1), -- Pollera Roja
('RNT-150', 'PRD-104', 1, 250, 1), -- Sombrero Blanco

-- RNT-151
('RNT-151', 'PRD-090', 2, 600, 1), -- Minero
('RNT-151', 'PRD-096', 2, 200, 1), -- Corbatas Tricolor

-- RNT-152
('RNT-152', 'PRD-041', 3, 1800, 1), -- Chaqueta Guindo

-- RNT-153
('RNT-153', 'PRD-056', 1, 900, 1), -- Chaqueta Plateado/Negro
('RNT-153', 'PRD-059', 5, 500, 1), -- Faja Plateado/Negro

-- RNT-154
('RNT-154', 'PRD-051', 4, 2400, 1), -- Chaqueta Dorado/Negro
('RNT-154', 'PRD-053', 4, 800, 1), -- Pantalón Dorado/Negro

-- RNT-155
('RNT-155', 'PRD-076', 2, 1200, 1), -- Chaqueta Azul/Celeste
('RNT-155', 'PRD-078', 2, 400, 1), -- Pantalón Azul/Celeste

-- RNT-156
('RNT-156', 'PRD-091', 3, 600, 1), -- Chavo
('RNT-156', 'PRD-106', 1, 350, 1), -- Máscara

-- RNT-157
('RNT-157', 'PRD-112', 4, 1680, 1), -- Zapatos

-- RNT-158
('RNT-158', 'PRD-021', 3, 1200, 1), -- Chaqueta Blanco/Plateado
('RNT-158', 'PRD-023', 4, 800, 1), -- Pantalón Blanco/Plateado
('RNT-158', 'PRD-024', 1, 100, 1), -- Faja Blanco/Plateado

-- RNT-159
('RNT-159', 'PRD-061', 2, 1200, 1), -- Chaqueta Celeste Bolívar

-- RNT-160
('RNT-160', 'PRD-066', 2, 1200, 1), -- Chaqueta Café
('RNT-160', 'PRD-069', 2, 200, 1), -- Faja Café

-- RNT-161
('RNT-161', 'PRD-031', 4, 2400, 1), -- Chaqueta Tricolor
('RNT-161', 'PRD-034', 4, 400, 1), -- Faja Tricolor

-- RNT-162
('RNT-162', 'PRD-016', 2, 1000, 1), -- Chaqueta Negro/Verde
('RNT-162', 'PRD-018', 2, 400, 1), -- Pantalón Negro/Verde
('RNT-162', 'PRD-020', 3, 300, 1), -- Chuspa Negro/Verde

-- RNT-163
('RNT-163', 'PRD-081', 3, 750, 1), -- Pepino
('RNT-163', 'PRD-099', 1, 300, 1), -- Pollera Azul
('RNT-163', 'PRD-105', 1, 250, 1), -- Sombrero Negro

-- RNT-164
('RNT-164', 'PRD-071', 3, 180, 1), -- Chaqueta Rosada
('RNT-164', 'PRD-073', 5, 600, 1), -- Pantalón Rosado
('RNT-164', 'PRD-081', 4, 1000, 1), -- Pepino
('RNT-164', 'PRD-107', 1, 350, 1), -- Máscara

-- RNT-165
('RNT-165', 'PRD-092', 2, 400, 1), -- Chapulín
('RNT-165', 'PRD-110', 1, 350, 1), -- Máscara

-- RNT-166
('RNT-166', 'PRD-006', 4, 2400, 1), -- Chaqueta Azul/Crema
('RNT-166', 'PRD-008', 3, 900, 1), -- Pantalón Azul/Crema
('RNT-166', 'PRD-009', 2, 200, 1), -- Faja Azul/Crema

-- RNT-167
('RNT-167', 'PRD-046', 2, 1200, 1), -- Chaqueta Verde Pacaí
('RNT-167', 'PRD-049', 1, 100, 1), -- Faja Verde Pacaí

-- RNT-168
('RNT-168', 'PRD-011', 3, 1800, 1), -- Chaqueta Rojo/Dorado
('RNT-168', 'PRD-013', 4, 800, 1), -- Pantalón Rojo/Dorado

-- RNT-169
('RNT-169', 'PRD-057', 1, 1000, 1), -- Chaquetilla Plateado/Negro
('RNT-169', 'PRD-058', 2, 800, 1), -- Pantalón Plateado/Negro

-- RNT-170
('RNT-170', 'PRD-077', 3, 1500, 1), -- Chaquetilla Azul/Celeste
('RNT-170', 'PRD-079', 2, 200, 1), -- Faja Azul/Celeste

-- RNT-171
('RNT-171', 'PRD-093', 3, 900, 1), -- Saya
('RNT-171', 'PRD-096', 2, 200, 1), -- Corbatas Tricolor

-- RNT-172
('RNT-172', 'PRD-032', 3, 1500, 1), -- Chaquetilla Tricolor
('RNT-172', 'PRD-033', 3, 600, 1), -- Pantalón Tricolor
('RNT-172', 'PRD-035', 1, 100, 1), -- Chuspa Tricolor

-- RNT-173
('RNT-173', 'PRD-062', 2, 1000, 1), -- Chaquetilla Celeste Bolívar
('RNT-173', 'PRD-064', 4, 400, 1), -- Faja Celeste Bolívar

-- RNT-174
('RNT-174', 'PRD-037', 2, 1400, 1), -- Chaquetilla Morado
('RNT-174', 'PRD-039', 3, 300, 1), -- Faja Morado

-- RNT-175
('RNT-175', 'PRD-082', 2, 500, 1), -- Pepino
('RNT-175', 'PRD-100', 1, 300, 1), -- Pollera Negra
('RNT-175', 'PRD-108', 1, 350, 1), -- Máscara

-- RNT-176
('RNT-176', 'PRD-042', 4, 2000, 1), -- Chaquetilla Guindo
('RNT-176', 'PRD-043', 5, 1000, 1), -- Pantalón Guindo
('RNT-176', 'PRD-045', 1, 100, 1), -- Chuspa Guindo

-- RNT-177
('RNT-177', 'PRD-067', 3, 1500, 1), -- Chaquetilla Café
('RNT-177', 'PRD-070', 2, 200, 1), -- Chuspa Café

-- RNT-178
('RNT-178', 'PRD-022', 4, 1200, 1), -- Chaquetilla Blanco/Plateado
('RNT-178', 'PRD-025', 3, 300, 1), -- Chuspa Blanco/Plateado

-- RNT-179
('RNT-179', 'PRD-027', 3, 1500, 1), -- Chaquetilla Verde Whatsapp
('RNT-179', 'PRD-028', 3, 900, 1), -- Pantalón Verde Whatsapp

-- RNT-180
('RNT-180', 'PRD-083', 2, 500, 1), -- Pepino
('RNT-180', 'PRD-101', 1, 300, 1), -- Pollera Blanca

-- RNT-181
('RNT-181', 'PRD-047', 4, 2000, 1), -- Chaquetilla Verde Pacaí
('RNT-181', 'PRD-048', 4, 800, 1), -- Pantalón Verde Pacaí
('RNT-181', 'PRD-050', 1, 100, 1), -- Chuspa Verde Pacaí

-- RNT-182
('RNT-182', 'PRD-072', 3, 150, 1), -- Chaquetilla Rosada
('RNT-182', 'PRD-074', 5, 500, 1), -- Faja Rosada
('RNT-182', 'PRD-075', 5, 500, 1), -- Chuspa Rosada
('RNT-182', 'PRD-097', 2, 200, 1), -- Corbatas Morado

-- RNT-183
('RNT-183', 'PRD-017', 3, 1200, 1), -- Chaquetilla Negro/Verde
('RNT-183', 'PRD-019', 5, 500, 1), -- Faja Negro/Verde
('RNT-183', 'PRD-112', 1, 420, 1), -- Zapatos

-- RNT-184
('RNT-184', 'PRD-012', 3, 1500, 1), -- Chaquetilla Rojo/Dorado
('RNT-184', 'PRD-014', 5, 500, 1), -- Faja Rojo/Dorado
('RNT-184', 'PRD-015', 1, 100, 1), -- Chuspa Rojo/Dorado

-- RNT-185
('RNT-185', 'PRD-052', 2, 1000, 1), -- Chaquetilla Dorado/Negro
('RNT-185', 'PRD-054', 3, 300, 1), -- Faja Dorado/Negro

-- RNT-186
('RNT-186', 'PRD-084', 3, 750, 1), -- Pepino
('RNT-186', 'PRD-102', 1, 300, 1), -- Pollera Verde
('RNT-186', 'PRD-109', 1, 350, 1), -- Máscara

-- RNT-187
('RNT-187', 'PRD-002', 4, 2000, 1), -- Chaquetilla Rojo/Negro
('RNT-187', 'PRD-003', 5, 1000, 1), -- Pantalón Rojo/Negro
('RNT-187', 'PRD-004', 2, 200, 1), -- Faja Rojo/Negro

-- RNT-188
('RNT-188', 'PRD-085', 2, 500, 1), -- Pepino
('RNT-188', 'PRD-103', 1, 300, 1), -- Pollera Morado
('RNT-188', 'PRD-111', 1, 350, 1), -- Máscara

-- RNT-189
('RNT-189', 'PRD-007', 3, 1500, 1), -- Chaquetilla Azul/Crema
('RNT-189', 'PRD-010', 4, 400, 1); -- Chuspa Azul/Crema

-- Inserts para tabla Garantia
INSERT INTO Garantia (RentaID, ClienteID, Tipo, Habilitado) VALUES 
-- RNT-147
('RNT-147', 'CLI-147-1', 'Cédula de Identidad', 1),
('RNT-147', 'CLI-147-1', 'Licencia de Conducir', 1),
('RNT-147', 'CLI-147-2', 'Cédula de Identidad', 1),

-- RNT-148
('RNT-148', 'CLI-148-1', 'Licencia de Conducir', 1),

-- RNT-149
('RNT-149', 'CLI-149-1', 'Cédula de Identidad', 1),
('RNT-149', 'CLI-149-2', 'Cédula de Identidad', 1),
('RNT-149', 'CLI-149-2', 'Pasaporte', 1),

-- RNT-150
('RNT-150', 'CLI-150-1', 'Licencia de Conducir', 1),

-- RNT-151
('RNT-151', 'CLI-151-1', 'Cédula de Identidad', 1),

-- RNT-152
('RNT-152', 'CLI-152-1', 'Cédula de Identidad', 1),
('RNT-152', 'CLI-152-2', 'Licencia de Conducir', 1),

-- RNT-153
('RNT-153', 'CLI-153-1', 'Pasaporte', 1),

-- RNT-154
('RNT-154', 'CLI-154-1', 'Cédula de Identidad', 1),
('RNT-154', 'CLI-154-2', 'Licencia de Conducir', 1),
('RNT-154', 'CLI-154-3', 'Cédula de Identidad', 1),

-- RNT-155
('RNT-155', 'CLI-155-1', 'Cédula de Identidad', 1),
('RNT-155', 'CLI-155-1', 'Licencia de Conducir', 1),

-- RNT-156
('RNT-156', 'CLI-156-1', 'Cédula de Identidad', 1),

-- RNT-157
('RNT-157', 'CLI-157-1', 'Licencia de Conducir', 1),

-- RNT-158
('RNT-158', 'CLI-158-1', 'Cédula de Identidad', 1),
('RNT-158', 'CLI-158-2', 'Pasaporte', 1),

-- RNT-159
('RNT-159', 'CLI-159-1', 'Cédula de Identidad', 1),

-- RNT-160
('RNT-160', 'CLI-160-1', 'Licencia de Conducir', 1),

-- RNT-161
('RNT-161', 'CLI-161-1', 'Cédula de Identidad', 1),
('RNT-161', 'CLI-161-2', 'Cédula de Identidad', 1),
('RNT-161', 'CLI-161-2', 'Licencia de Conducir', 1),

-- RNT-162
('RNT-162', 'CLI-162-1', 'Pasaporte', 1),

-- RNT-163
('RNT-163', 'CLI-163-1', 'Cédula de Identidad', 1),

-- RNT-164
('RNT-164', 'CLI-164-1', 'Licencia de Conducir', 1),
('RNT-164', 'CLI-164-2', 'Cédula de Identidad', 1),

-- RNT-165
('RNT-165', 'CLI-165-1', 'Cédula de Identidad', 1),

-- RNT-166
('RNT-166', 'CLI-166-1', 'Cédula de Identidad', 1),
('RNT-166', 'CLI-166-2', 'Licencia de Conducir', 1),
('RNT-166', 'CLI-166-3', 'Pasaporte', 1),

-- RNT-167
('RNT-167', 'CLI-167-1', 'Cédula de Identidad', 1),
('RNT-167', 'CLI-167-1', 'Licencia de Conducir', 1),

-- RNT-168
('RNT-168', 'CLI-168-1', 'Cédula de Identidad', 1),
('RNT-168', 'CLI-168-2', 'Cédula de Identidad', 1),

-- RNT-169
('RNT-169', 'CLI-169-1', 'Licencia de Conducir', 1),

-- RNT-170
('RNT-170', 'CLI-170-1', 'Cédula de Identidad', 1),
('RNT-170', 'CLI-170-2', 'Pasaporte', 1),

-- RNT-171
('RNT-171', 'CLI-171-1', 'Cédula de Identidad', 1),

-- RNT-172
('RNT-172', 'CLI-172-1', 'Licencia de Conducir', 1),
('RNT-172', 'CLI-172-2', 'Cédula de Identidad', 1),

-- RNT-173
('RNT-173', 'CLI-173-1', 'Cédula de Identidad', 1),

-- RNT-174
('RNT-174', 'CLI-174-1', 'Pasaporte', 1),

-- RNT-175
('RNT-175', 'CLI-175-1', 'Cédula de Identidad', 1),

-- RNT-176
('RNT-176', 'CLI-176-1', 'Cédula de Identidad', 1),
('RNT-176', 'CLI-176-2', 'Licencia de Conducir', 1),
('RNT-176', 'CLI-176-3', 'Cédula de Identidad', 1),
('RNT-176', 'CLI-176-3', 'Pasaporte', 1),

-- RNT-177
('RNT-177', 'CLI-177-1', 'Licencia de Conducir', 1),

-- RNT-178
('RNT-178', 'CLI-178-1', 'Cédula de Identidad', 1),
('RNT-178', 'CLI-178-1', 'Licencia de Conducir', 1),

-- RNT-179
('RNT-179', 'CLI-179-1', 'Cédula de Identidad', 1),
('RNT-179', 'CLI-179-2', 'Pasaporte', 1),

-- RNT-180
('RNT-180', 'CLI-180-1', 'Cédula de Identidad', 1),

-- RNT-181
('RNT-181', 'CLI-181-1', 'Licencia de Conducir', 1),
('RNT-181', 'CLI-181-2', 'Cédula de Identidad', 1),
('RNT-181', 'CLI-181-2', 'Licencia de Conducir', 1),

-- RNT-182
('RNT-182', 'CLI-182-1', 'Cédula de Identidad', 1),

-- RNT-183
('RNT-183', 'CLI-183-1', 'Pasaporte', 1),
('RNT-183', 'CLI-183-2', 'Cédula de Identidad', 1),

-- RNT-184
('RNT-184', 'CLI-184-1', 'Cédula de Identidad', 1),
('RNT-184', 'CLI-184-2', 'Licencia de Conducir', 1),

-- RNT-185
('RNT-185', 'CLI-185-1', 'Cédula de Identidad', 1),
('RNT-185', 'CLI-185-1', 'Pasaporte', 1),

-- RNT-186
('RNT-186', 'CLI-186-1', 'Licencia de Conducir', 1),

-- RNT-187
('RNT-187', 'CLI-187-1', 'Cédula de Identidad', 1),
('RNT-187', 'CLI-187-2', 'Cédula de Identidad', 1),
('RNT-187', 'CLI-187-3', 'Pasaporte', 1),

-- RNT-188
('RNT-188', 'CLI-188-1', 'Cédula de Identidad', 1),

-- RNT-189
('RNT-189', 'CLI-189-1', 'Licencia de Conducir', 1),
('RNT-189', 'CLI-189-2', 'Cédula de Identidad', 1);

-- RENTAS FEBRERO 2025 (20 días hábiles)
-- Formato: Cada día 1-3 rentas, múltiples clientes, productos y garantías

-- ============= RENTAS =============
INSERT INTO Renta (RentaID, EmpleadoID, FechaRenta, FechaDevolucion, FechaDevuelto, Descuento, Total, Multa) VALUES 
-- Lunes 3 de Febrero
('RNT-190', 'MGR-001', '2025-02-03', '2025-02-08', NULL, 0, 1800, 0),
('RNT-191', 'MGR-002', '2025-02-03', '2025-02-10', NULL, 5, 1425, 0),

-- Martes 4 de Febrero  
('RNT-192', 'MGR-001', '2025-02-04', '2025-02-09', NULL, 0, 2100, 0),
('RNT-193', 'MGR-002', '2025-02-04', '2025-02-11', NULL, 0, 950, 0),
('RNT-194', 'MGR-001', '2025-02-04', '2025-02-09', NULL, 10, 1440, 0),

-- Miércoles 5 de Febrero
('RNT-195', 'MGR-002', '2025-02-05', '2025-02-12', NULL, 0, 1350, 0),
('RNT-196', 'MGR-001', '2025-02-05', '2025-02-10', NULL, 0, 1600, 0),

-- Jueves 6 de Febrero
('RNT-197', 'MGR-001', '2025-02-06', '2025-02-13', NULL, 0, 2250, 0),
('RNT-198', 'MGR-002', '2025-02-06', '2025-02-11', NULL, 15, 1275, 0),
('RNT-199', 'MGR-001', '2025-02-06', '2025-02-13', NULL, 0, 800, 0),

-- Viernes 7 de Febrero
('RNT-200', 'MGR-002', '2025-02-07', '2025-02-14', NULL, 0, 1700, 0),
('RNT-201', 'MGR-001', '2025-02-07', '2025-02-12', NULL, 0, 1200, 0),

-- Lunes 10 de Febrero
('RNT-202', 'MGR-001', '2025-02-10', '2025-02-17', NULL, 0, 1900, 0),
('RNT-203', 'MGR-002', '2025-02-10', '2025-02-15', NULL, 0, 1100, 0),
('RNT-204', 'MGR-001', '2025-02-10', '2025-02-17', NULL, 20, 1200, 0),

-- Martes 11 de Febrero
('RNT-205', 'MGR-002', '2025-02-11', '2025-02-18', NULL, 0, 1650, 0),
('RNT-206', 'MGR-001', '2025-02-11', '2025-02-16', NULL, 0, 2000, 0),

-- Miércoles 12 de Febrero
('RNT-207', 'MGR-001', '2025-02-12', '2025-02-19', NULL, 0, 1400, 0),
('RNT-208', 'MGR-002', '2025-02-12', '2025-02-17', NULL, 0, 1750, 0),
('RNT-209', 'MGR-001', '2025-02-12', '2025-02-19', NULL, 5, 1425, 0),

-- Jueves 13 de Febrero
('RNT-210', 'MGR-002', '2025-02-13', '2025-02-20', NULL, 0, 1550, 0),
('RNT-211', 'MGR-001', '2025-02-13', '2025-02-18', NULL, 0, 900, 0),

-- Viernes 14 de Febrero (San Valentín - más actividad)
('RNT-212', 'MGR-001', '2025-02-14', '2025-02-21', NULL, 0, 2400, 0),
('RNT-213', 'MGR-002', '2025-02-14', '2025-02-19', NULL, 10, 1350, 0),
('RNT-214', 'MGR-001', '2025-02-14', '2025-02-21', NULL, 0, 1800, 0),

-- Lunes 17 de Febrero
('RNT-215', 'MGR-002', '2025-02-17', '2025-02-24', NULL, 0, 1600, 0),
('RNT-216', 'MGR-001', '2025-02-17', '2025-02-22', NULL, 0, 1950, 0),

-- Martes 18 de Febrero
('RNT-217', 'MGR-001', '2025-02-18', '2025-02-25', NULL, 0, 1300, 0),
('RNT-218', 'MGR-002', '2025-02-18', '2025-02-23', NULL, 0, 2100, 0),
('RNT-219', 'MGR-001', '2025-02-18', '2025-02-25', NULL, 15, 1275, 0),

-- Miércoles 19 de Febrero
('RNT-220', 'MGR-002', '2025-02-19', '2025-02-26', NULL, 0, 1450, 0),
('RNT-221', 'MGR-001', '2025-02-19', '2025-02-24', NULL, 0, 1750, 0),

-- Jueves 20 de Febrero
('RNT-222', 'MGR-001', '2025-02-20', '2025-02-27', NULL, 0, 1850, 0),
('RNT-223', 'MGR-002', '2025-02-20', '2025-02-25', NULL, 0, 1200, 0),
('RNT-224', 'MGR-001', '2025-02-20', '2025-02-27', NULL, 0, 1650, 0),

-- Viernes 21 de Febrero
('RNT-225', 'MGR-002', '2025-02-21', '2025-02-28', NULL, 0, 2200, 0);

-- ============= CLIENTES =============
INSERT INTO Cliente (ClienteID, RentaID, Nombre, Apellido, Telefono, Garantia, Habilitado) VALUES 
-- RNT-190 (2 clientes)
('CLI-190-1', 'RNT-190', 'Ana María', 'Condori', 78912345, 1, 1),
('CLI-191-1', 'RNT-190', 'Jorge Luis', 'Mamani', 76543210, 1, 1),

-- RNT-191 (1 cliente)
('CLI-192-1', 'RNT-191', 'Patricia', 'Flores', 77234567, 1, 1),

-- RNT-192 (2 clientes)
('CLI-193-1', 'RNT-192', 'Miguel', 'Torrez', 76789012, 1, 1),
('CLI-194-1', 'RNT-192', 'Rosa Elena', 'Choque', 78345678, 1, 1),

-- RNT-193 (1 cliente)
('CLI-195-1', 'RNT-193', 'Carlos David', 'Quispe', 77456789, 1, 1),

-- RNT-194 (2 clientes)
('CLI-196-1', 'RNT-194', 'Lucia', 'Vargas', 76234567, 1, 1),
('CLI-197-1', 'RNT-194', 'Fernando', 'Gutierrez', 78567890, 1, 1),

-- RNT-195 (1 cliente)
('CLI-198-1', 'RNT-195', 'Sandra', 'Morales', 77890123, 1, 1),

-- RNT-196 (2 clientes)
('CLI-199-1', 'RNT-196', 'Roberto', 'Salinas', 76456789, 1, 1),
('CLI-200-1', 'RNT-196', 'Elena', 'Carvajal', 78123456, 1, 1),

-- RNT-197 (3 clientes)
('CLI-201-1', 'RNT-197', 'Antonio', 'Mendez', 77567890, 1, 1),
('CLI-202-1', 'RNT-197', 'Carmen', 'Perez', 76890123, 1, 1),
('CLI-203-1', 'RNT-197', 'Daniel', 'Rojas', 78234567, 1, 1),

-- RNT-198 (1 cliente)
('CLI-204-1', 'RNT-198', 'Gabriela', 'Vega', 77345678, 1, 1),

-- RNT-199 (1 cliente)
('CLI-205-1', 'RNT-199', 'Hernan', 'Castro', 76567890, 1, 1),

-- RNT-200 (2 clientes)
('CLI-206-1', 'RNT-200', 'Silvia', 'Jimenez', 78456789, 1, 1),
('CLI-207-1', 'RNT-200', 'Pablo', 'Ramos', 77678901, 1, 1),

-- RNT-201 (1 cliente)
('CLI-208-1', 'RNT-201', 'Maritza', 'Herrera', 76789012, 1, 1),

-- RNT-202 (2 clientes)
('CLI-209-1', 'RNT-202', 'Alejandro', 'Cordova', 78567890, 1, 1),
('CLI-210-1', 'RNT-202', 'Beatriz', 'Aguilar', 77234567, 1, 1),

-- RNT-203 (1 cliente)
('CLI-211-1', 'RNT-203', 'Raul', 'Delgado', 76345678, 1, 1),

-- RNT-204 (2 clientes)
('CLI-212-1', 'RNT-204', 'Veronica', 'Solis', 78678901, 1, 1),
('CLI-213-1', 'RNT-204', 'Oscar', 'Medina', 77456789, 1, 1),

-- RNT-205 (1 cliente)
('CLI-214-1', 'RNT-205', 'Claudia', 'Ortega', 76567890, 1, 1),

-- RNT-206 (2 clientes)
('CLI-215-1', 'RNT-206', 'Eduardo', 'Paredes', 78789012, 1, 1),
('CLI-216-1', 'RNT-206', 'Monica', 'Cabrera', 77890123, 1, 1),

-- RNT-207 (1 cliente)
('CLI-217-1', 'RNT-207', 'Javier', 'Espinoza', 76678901, 1, 1),

-- RNT-208 (2 clientes)
('CLI-218-1', 'RNT-208', 'Adriana', 'Quiroga', 78234567, 1, 1),
('CLI-219-1', 'RNT-208', 'Mauricio', 'Velasco', 77345678, 1, 1),

-- RNT-209 (2 clientes)
('CLI-220-1', 'RNT-209', 'Rocio', 'Navarro', 76456789, 1, 1),
('CLI-221-1', 'RNT-209', 'Gonzalo', 'Ibarra', 78567890, 1, 1),

-- RNT-210 (1 cliente)
('CLI-222-1', 'RNT-210', 'Fabiola', 'Arce', 77678901, 1, 1),

-- RNT-211 (1 cliente)
('CLI-223-1', 'RNT-211', 'Andres', 'Saavedra', 76234567, 1, 1),

-- RNT-212 (3 clientes - San Valentín)
('CLI-224-1', 'RNT-212', 'Carla', 'Montaño', 78345678, 1, 1),
('CLI-225-1', 'RNT-212', 'Sergio', 'Bernal', 77456789, 1, 1),
('CLI-226-1', 'RNT-212', 'Vanessa', 'Alarcon', 76567890, 1, 1),

-- RNT-213 (1 cliente)
('CLI-227-1', 'RNT-213', 'Diego', 'Pacheco', 78678901, 1, 1),

-- RNT-214 (2 clientes)
('CLI-228-1', 'RNT-214', 'Natalia', 'Coronado', 77789012, 1, 1),
('CLI-229-1', 'RNT-214', 'Ivan', 'Burgos', 76890123, 1, 1),

-- RNT-215 (1 cliente)
('CLI-230-1', 'RNT-215', 'Leticia', 'Sandoval', 78234567, 1, 1),

-- RNT-216 (2 clientes)
('CLI-231-1', 'RNT-216', 'Alfredo', 'Villarroel', 77345678, 1, 1),
('CLI-232-1', 'RNT-216', 'Paola', 'Mercado', 76456789, 1, 1),

-- RNT-217 (1 cliente)
('CLI-233-1', 'RNT-217', 'Marcelo', 'Sejas', 78567890, 1, 1),

-- RNT-218 (2 clientes)
('CLI-234-1', 'RNT-218', 'Karina', 'Baldivieso', 77678901, 1, 1),
('CLI-235-1', 'RNT-218', 'Ruben', 'Camacho', 76789012, 1, 1),

-- RNT-219 (2 clientes)
('CLI-236-1', 'RNT-219', 'Ingrid', 'Ticona', 78890123, 1, 1),
('CLI-237-1', 'RNT-219', 'Edgar', 'Laime', 77234567, 1, 1),

-- RNT-220 (1 cliente)
('CLI-238-1', 'RNT-220', 'Yolanda', 'Pinto', 76345678, 1, 1),

-- RNT-221 (2 clientes)
('CLI-239-1', 'RNT-221', 'Victor', 'Apaza', 78456789, 1, 1),
('CLI-240-1', 'RNT-221', 'Gladys', 'Colque', 77567890, 1, 1),

-- RNT-222 (2 clientes)
('CLI-241-1', 'RNT-222', 'Ramiro', 'Huanca', 76678901, 1, 1),
('CLI-242-1', 'RNT-222', 'Susana', 'Chura', 78789012, 1, 1),

-- RNT-223 (1 cliente)
('CLI-243-1', 'RNT-223', 'Wilfredo', 'Limachi', 77890123, 1, 1),

-- RNT-224 (2 clientes)
('CLI-244-1', 'RNT-224', 'Miriam', 'Tacuri', 76234567, 1, 1),
('CLI-245-1', 'RNT-224', 'Freddy', 'Villca', 78345678, 1, 1),

-- RNT-225 (3 clientes)
('CLI-246-1', 'RNT-225', 'Lourdes', 'Tarqui', 77456789, 1, 1),
('CLI-247-1', 'RNT-225', 'Marcelo', 'Yujra', 76567890, 1, 1),
('CLI-248-1', 'RNT-225', 'Roxana', 'Guarachi', 78678901, 1, 1);

-- ============= DETALLE RENTA =============
INSERT INTO DetalleRenta (RentaID, ProductoID, Cantidad, Subtotal, Habilitado) VALUES 
-- RNT-190: Ana María Condori + Jorge Luis Mamani
('RNT-190', 'PRD-001', 2, 1200, 1), -- Chaqueta Rojo/Negro
('RNT-190', 'PRD-003', 3, 600, 1), -- Pantalón Rojo/Negro

-- RNT-191: Patricia Flores
('RNT-191', 'PRD-026', 1, 600, 1), -- Chaqueta Verde Whatsapp
('RNT-191', 'PRD-028', 2, 600, 1), -- Pantalón Verde Whatsapp
('RNT-191', 'PRD-094', 3, 300, 1), -- Corbatas

-- RNT-192: Miguel Torrez + Rosa Elena Choque
('RNT-192', 'PRD-006', 2, 1200, 1), -- Chaqueta Azul/Crema
('RNT-192', 'PRD-008', 3, 900, 1), -- Pantalón Azul/Crema

-- RNT-193: Carlos David Quispe
('RNT-193', 'PRD-081', 1, 250, 1), -- Pepino
('RNT-193', 'PRD-098', 2, 600, 1), -- Pollera Roja
('RNT-193', 'PRD-104', 1, 250, 1), -- Sombrero Blanco
('RNT-193', 'PRD-106', 1, 350, 1), -- Máscara

-- RNT-194: Lucia Vargas + Fernando Gutierrez
('RNT-194', 'PRD-031', 1, 600, 1), -- Chaqueta Tricolor
('RNT-194', 'PRD-033', 2, 400, 1), -- Pantalón Tricolor
('RNT-194', 'PRD-034', 5, 500, 1), -- Faja Tricolor

-- RNT-195: Sandra Morales
('RNT-195', 'PRD-036', 1, 600, 1), -- Chaqueta Morada
('RNT-195', 'PRD-038', 2, 800, 1), -- Pantalón Morado

-- RNT-196: Roberto Salinas + Elena Carvajal
('RNT-196', 'PRD-016', 2, 1000, 1), -- Chaqueta Negro/Verde
('RNT-196', 'PRD-018', 3, 600, 1), -- Pantalón Negro/Verde

-- RNT-197: Antonio Mendez + Carmen Perez + Daniel Rojas
('RNT-197', 'PRD-011', 2, 1200, 1), -- Chaqueta Rojo/Dorado
('RNT-197', 'PRD-013', 1, 200, 1), -- Pantalón Rojo/Dorado
('RNT-197', 'PRD-082', 1, 250, 1), -- Pepino
('RNT-197', 'PRD-098', 2, 600, 1), -- Pollera

-- RNT-198: Gabriela Vega
('RNT-198', 'PRD-021', 2, 800, 1), -- Chaqueta Blanco/Plateado
('RNT-198', 'PRD-023', 2, 400, 1), -- Pantalón Blanco/Plateado
('RNT-198', 'PRD-024', 1, 100, 1), -- Faja

-- RNT-199: Hernan Castro
('RNT-199', 'PRD-090', 1, 300, 1), -- Minero
('RNT-199', 'PRD-091', 1, 200, 1), -- Chavo
('RNT-199', 'PRD-092', 1, 200, 1), -- Chapulin
('RNT-199', 'PRD-093', 1, 300, 1), -- Saya

-- RNT-200: Silvia Jimenez + Pablo Ramos
('RNT-200', 'PRD-041', 2, 1200, 1), -- Chaqueta Guindo
('RNT-200', 'PRD-043', 2, 400, 1), -- Pantalón Guindo
('RNT-200', 'PRD-044', 1, 100, 1), -- Faja Guindo

-- RNT-201: Maritza Herrera
('RNT-201', 'PRD-046', 1, 600, 1), -- Chaqueta Verde Pacai
('RNT-201', 'PRD-048', 3, 600, 1), -- Pantalón Verde Pacai

-- RNT-202: Alejandro Cordova + Beatriz Aguilar
('RNT-202', 'PRD-051', 2, 1200, 1), -- Chaqueta Dorado/Negro
('RNT-202', 'PRD-053', 2, 400, 1), -- Pantalón Dorado/Negro
('RNT-202', 'PRD-054', 3, 300, 1), -- Faja Dorado/Negro

-- RNT-203: Raul Delgado
('RNT-203', 'PRD-056', 1, 900, 1), -- Chaqueta Plateado/Negro
('RNT-203', 'PRD-058', 1, 400, 1), -- Pantalón Plateado/Negro

-- RNT-204: Veronica Solis + Oscar Medina
('RNT-204', 'PRD-061', 1, 600, 1), -- Chaqueta Celeste Bolivar
('RNT-204', 'PRD-063', 3, 600, 1), -- Pantalón Celeste Bolivar
('RNT-204', 'PRD-064', 2, 200, 1), -- Faja Celeste

-- RNT-205: Claudia Ortega
('RNT-205', 'PRD-066', 2, 1200, 1), -- Chaqueta Café
('RNT-205', 'PRD-068', 2, 400, 1), -- Pantalón Café
('RNT-205', 'PRD-069', 1, 100, 1), -- Faja Café

-- RNT-206: Eduardo Paredes + Monica Cabrera
('RNT-206', 'PRD-071', 2, 120, 1), -- Chaqueta Rosada
('RNT-206', 'PRD-073', 4, 480, 1), -- Pantalón Rosado
('RNT-206', 'PRD-074', 5, 500, 1), -- Faja Rosada
('RNT-206', 'PRD-099', 3, 900, 1), -- Pollera Azul

-- RNT-207: Javier Espinoza
('RNT-207', 'PRD-076', 1, 600, 1), -- Chaqueta Azul/Celeste
('RNT-207', 'PRD-078', 4, 800, 1), -- Pantalón Azul/Celeste

-- RNT-208: Adriana Quiroga + Mauricio Velasco
('RNT-208', 'PRD-001', 2, 1200, 1), -- Chaqueta Rojo/Negro
('RNT-208', 'PRD-003', 2, 400, 1), -- Pantalón Rojo/Negro
('RNT-208', 'PRD-081', 1, 250, 1), -- Pepino

-- RNT-209: Rocio Navarro + Gonzalo Ibarra
('RNT-209', 'PRD-011', 1, 600, 1), -- Chaqueta Rojo/Dorado
('RNT-209', 'PRD-013', 1, 200, 1), -- Pantalón Rojo/Dorado
('RNT-209', 'PRD-095', 4, 400, 1), -- Corbatas Azul/Crema
('RNT-209', 'PRD-104', 1, 250, 1), -- Sombrero

-- RNT-210: Fabiola Arce
('RNT-210', 'PRD-026', 1, 600, 1), -- Chaqueta Verde Whatsapp
('RNT-210', 'PRD-028', 3, 900, 1), -- Pantalón Verde Whatsapp
('RNT-210', 'PRD-029', 1, 100, 1), -- Faja Verde

-- RNT-211: Andres Saavedra
('RNT-211', 'PRD-090', 1, 300, 1), -- Minero
('RNT-211', 'PRD-091', 1, 200, 1), -- Chavo
('RNT-211', 'PRD-092', 1, 200, 1), -- Chapulin
('RNT-211', 'PRD-093', 1, 300, 1), -- Saya

-- RNT-212: Carla Montaño + Sergio Bernal + Vanessa Alarcon (San Valentín)
('RNT-212', 'PRD-071', 3, 180, 1), -- Chaqueta Rosada
('RNT-212', 'PRD-072', 2, 100, 1), -- Chaquetilla Rosada
('RNT-212', 'PRD-006', 2, 1200, 1), -- Chaqueta Azul/Crema
('RNT-212', 'PRD-008', 3, 900, 1), -- Pantalón Azul/Crema
('RNT-212', 'PRD-106', 2, 700, 1), -- Máscaras
('RNT-212', 'PRD-098', 1, 300, 1), -- Pollera

-- RNT-213: Diego Pacheco
('RNT-213', 'PRD-031', 1, 600, 1), -- Chaqueta Tricolor
('RNT-213', 'PRD-033', 2, 400, 1), -- Pantalón Tricolor
('RNT-213', 'PRD-096', 3, 300, 1), -- Corbatas Tricolor
('RNT-213', 'PRD-105', 1, 250, 1), -- Sombrero Negro

-- RNT-214: Natalia Coronado + Ivan Burgos
('RNT-214', 'PRD-036', 2, 1200, 1), -- Chaqueta Morada
('RNT-214', 'PRD-038', 1, 400, 1), -- Pantalón Morado
('RNT-214', 'PRD-039', 2, 200, 1), -- Faja Morada

-- RNT-215: Leticia Sandoval
('RNT-215', 'PRD-016', 2, 1000, 1), -- Chaqueta Negro/Verde
('RNT-215', 'PRD-018', 3, 600, 1), -- Pantalón Negro/Verde

-- RNT-216: Alfredo Villarroel + Paola Mercado
('RNT-216', 'PRD-021', 2, 800, 1), -- Chaqueta Blanco/Plateado
('RNT-216', 'PRD-023', 3, 600, 1), -- Pantalón Blanco/Plateado
('RNT-216', 'PRD-082', 1, 250, 1), -- Pepino
('RNT-216', 'PRD-098', 1, 300, 1), -- Pollera

-- RNT-217: Marcelo Sejas
('RNT-217', 'PRD-041', 1, 600, 1), -- Chaqueta Guindo
('RNT-217', 'PRD-043', 3, 600, 1), -- Pantalón Guindo
('RNT-217', 'PRD-044', 1, 100, 1), -- Faja Guindo

-- RNT-218: Karina Baldivieso + Ruben Camacho
('RNT-218', 'PRD-046', 2, 1200, 1), -- Chaqueta Verde Pacai
('RNT-218', 'PRD-048', 3, 600, 1), -- Pantalón Verde Pacai
('RNT-218', 'PRD-083', 1, 250, 1), -- Pepino
('RNT-218', 'PRD-105', 1, 250, 1), -- Sombrero

-- RNT-219: Ingrid Ticona + Edgar Laime
('RNT-219', 'PRD-051', 1, 600, 1), -- Chaqueta Dorado/Negro
('RNT-219', 'PRD-053', 2, 400, 1), -- Pantalón Dorado/Negro
('RNT-219', 'PRD-054', 3, 300, 1), -- Faja Dorado/Negro

-- RNT-220: Yolanda Pinto
('RNT-220', 'PRD-056', 1, 900, 1), -- Chaqueta Plateado/Negro
('RNT-220', 'PRD-058', 1, 400, 1), -- Pantalón Plateado/Negro
('RNT-220', 'PRD-059', 1, 100, 1), -- Faja Plateado/Negro
('RNT-220', 'PRD-104', 1, 250, 1), -- Sombrero

-- RNT-221: Victor Apaza + Gladys Colque
('RNT-221', 'PRD-061', 2, 1200, 1), -- Chaqueta Celeste Bolivar
('RNT-221', 'PRD-063', 2, 400, 1), -- Pantalón Celeste Bolivar
('RNT-221', 'PRD-064', 1, 100, 1), -- Faja Celeste
('RNT-221', 'PRD-106', 1, 350, 1), -- Máscara

-- RNT-222: Ramiro Huanca + Susana Chura
('RNT-222', 'PRD-066', 1, 600, 1), -- Chaqueta Café
('RNT-222', 'PRD-068', 3, 600, 1), -- Pantalón Café
('RNT-222', 'PRD-084', 1, 250, 1), -- Pepino
('RNT-222', 'PRD-098', 1, 300, 1), -- Pollera
('RNT-222', 'PRD-107', 1, 350, 1), -- Máscara

-- RNT-223: Wilfredo Limachi
('RNT-223', 'PRD-071', 2, 120, 1), -- Chaqueta Rosada
('RNT-223', 'PRD-073', 4, 480, 1), -- Pantalón Rosado
('RNT-223', 'PRD-074', 3, 300, 1), -- Faja Rosada
('RNT-223', 'PRD-099', 1, 300, 1), -- Pollera

-- RNT-224: Miriam Tacuri + Freddy Villca
('RNT-224', 'PRD-076', 2, 1200, 1), -- Chaqueta Azul/Celeste
('RNT-224', 'PRD-078', 2, 400, 1), -- Pantalón Azul/Celeste
('RNT-224', 'PRD-079', 1, 100, 1), -- Faja Azul/Celeste

-- RNT-225: Lourdes Tarqui + Marcelo Yujra + Roxana Guarachi
('RNT-225', 'PRD-001', 3, 1800, 1), -- Chaqueta Rojo/Negro
('RNT-225', 'PRD-003', 2, 400, 1); -- Pantalón Rojo/Negro

-- ============= GARANTÍAS =============
INSERT INTO Garantia (RentaID, ClienteID, Tipo, Habilitado) VALUES 
-- RNT-190: Ana María Condori + Jorge Luis Mamani
('RNT-190', 'CLI-190-1', 'Cédula de Identidad', 1),
('RNT-190', 'CLI-190-1', 'Licencia de Conducir', 1),
('RNT-190', 'CLI-191-1', 'Cédula de Identidad', 1),

-- RNT-191: Patricia Flores
('RNT-191', 'CLI-192-1', 'Cédula de Identidad', 1),
('RNT-191', 'CLI-192-1', 'Pasaporte', 1),

-- RNT-192: Miguel Torrez + Rosa Elena Choque
('RNT-192', 'CLI-193-1', 'Cédula de Identidad', 1),
('RNT-192', 'CLI-194-1', 'Licencia de Conducir', 1),
('RNT-192', 'CLI-194-1', 'Cédula de Identidad', 1),

-- RNT-193: Carlos David Quispe
('RNT-193', 'CLI-195-1', 'Cédula de Identidad', 1),

-- RNT-194: Lucia Vargas + Fernando Gutierrez
('RNT-194', 'CLI-196-1', 'Cédula de Identidad', 1),
('RNT-194', 'CLI-196-1', 'Licencia de Conducir', 1),
('RNT-194', 'CLI-197-1', 'Cédula de Identidad', 1),

-- RNT-195: Sandra Morales
('RNT-195', 'CLI-198-1', 'Licencia de Conducir', 1),
('RNT-195', 'CLI-198-1', 'Pasaporte', 1),

-- RNT-196: Roberto Salinas + Elena Carvajal
('RNT-196', 'CLI-199-1', 'Cédula de Identidad', 1),
('RNT-196', 'CLI-200-1', 'Cédula de Identidad', 1),
('RNT-196', 'CLI-200-1', 'Licencia de Conducir', 1),

-- RNT-197: Antonio Mendez + Carmen Perez + Daniel Rojas
('RNT-197', 'CLI-201-1', 'Cédula de Identidad', 1),
('RNT-197', 'CLI-202-1', 'Licencia de Conducir', 1),
('RNT-197', 'CLI-202-1', 'Cédula de Identidad', 1),
('RNT-197', 'CLI-203-1', 'Cédula de Identidad', 1),

-- RNT-198: Gabriela Vega
('RNT-198', 'CLI-204-1', 'Cédula de Identidad', 1),
('RNT-198', 'CLI-204-1', 'Pasaporte', 1),

-- RNT-199: Hernan Castro
('RNT-199', 'CLI-205-1', 'Licencia de Conducir', 1),

-- RNT-200: Silvia Jimenez + Pablo Ramos
('RNT-200', 'CLI-206-1', 'Cédula de Identidad', 1),
('RNT-200', 'CLI-207-1', 'Cédula de Identidad', 1),
('RNT-200', 'CLI-207-1', 'Licencia de Conducir', 1),

-- RNT-201: Maritza Herrera
('RNT-201', 'CLI-208-1', 'Cédula de Identidad', 1),

-- RNT-202: Alejandro Cordova + Beatriz Aguilar
('RNT-202', 'CLI-209-1', 'Licencia de Conducir', 1),
('RNT-202', 'CLI-209-1', 'Cédula de Identidad', 1),
('RNT-202', 'CLI-210-1', 'Cédula de Identidad', 1),

-- RNT-203: Raul Delgado
('RNT-203', 'CLI-211-1', 'Cédula de Identidad', 1),
('RNT-203', 'CLI-211-1', 'Pasaporte', 1),

-- RNT-204: Veronica Solis + Oscar Medina
('RNT-204', 'CLI-212-1', 'Cédula de Identidad', 1),
('RNT-204', 'CLI-213-1', 'Licencia de Conducir', 1),
('RNT-204', 'CLI-213-1', 'Cédula de Identidad', 1),

-- RNT-205: Claudia Ortega
('RNT-205', 'CLI-214-1', 'Cédula de Identidad', 1),

-- RNT-206: Eduardo Paredes + Monica Cabrera
('RNT-206', 'CLI-215-1', 'Licencia de Conducir', 1),
('RNT-206', 'CLI-216-1', 'Cédula de Identidad', 1),
('RNT-206', 'CLI-216-1', 'Pasaporte', 1),

-- RNT-207: Javier Espinoza
('RNT-207', 'CLI-217-1', 'Cédula de Identidad', 1),
('RNT-207', 'CLI-217-1', 'Licencia de Conducir', 1),

-- RNT-208: Adriana Quiroga + Mauricio Velasco
('RNT-208', 'CLI-218-1', 'Cédula de Identidad', 1),
('RNT-208', 'CLI-219-1', 'Cédula de Identidad', 1),
('RNT-208', 'CLI-219-1', 'Licencia de Conducir', 1),

-- RNT-209: Rocio Navarro + Gonzalo Ibarra
('RNT-209', 'CLI-220-1', 'Cédula de Identidad', 1),
('RNT-209', 'CLI-221-1', 'Licencia de Conducir', 1),
('RNT-209', 'CLI-221-1', 'Cédula de Identidad', 1),

-- RNT-210: Fabiola Arce
('RNT-210', 'CLI-222-1', 'Cédula de Identidad', 1),
('RNT-210', 'CLI-222-1', 'Pasaporte', 1),

-- RNT-211: Andres Saavedra
('RNT-211', 'CLI-223-1', 'Licencia de Conducir', 1),

-- RNT-212: Carla Montaño + Sergio Bernal + Vanessa Alarcon (San Valentín)
('RNT-212', 'CLI-224-1', 'Cédula de Identidad', 1),
('RNT-212', 'CLI-224-1', 'Licencia de Conducir', 1),
('RNT-212', 'CLI-225-1', 'Cédula de Identidad', 1),
('RNT-212', 'CLI-226-1', 'Cédula de Identidad', 1),
('RNT-212', 'CLI-226-1', 'Pasaporte', 1),

-- RNT-213: Diego Pacheco
('RNT-213', 'CLI-227-1', 'Cédula de Identidad', 1),

-- RNT-214: Natalia Coronado + Ivan Burgos
('RNT-214', 'CLI-228-1', 'Licencia de Conducir', 1),
('RNT-214', 'CLI-228-1', 'Cédula de Identidad', 1),
('RNT-214', 'CLI-229-1', 'Cédula de Identidad', 1),

-- RNT-215: Leticia Sandoval
('RNT-215', 'CLI-230-1', 'Cédula de Identidad', 1),
('RNT-215', 'CLI-230-1', 'Pasaporte', 1),

-- RNT-216: Alfredo Villarroel + Paola Mercado
('RNT-216', 'CLI-231-1', 'Cédula de Identidad', 1),
('RNT-216', 'CLI-232-1', 'Licencia de Conducir', 1),
('RNT-216', 'CLI-232-1', 'Cédula de Identidad', 1),

-- RNT-217: Marcelo Sejas
('RNT-217', 'CLI-233-1', 'Cédula de Identidad', 1),

-- RNT-218: Karina Baldivieso + Ruben Camacho
('RNT-218', 'CLI-234-1', 'Cédula de Identidad', 1),
('RNT-218', 'CLI-234-1', 'Licencia de Conducir', 1),
('RNT-218', 'CLI-235-1', 'Cédula de Identidad', 1),

-- RNT-219: Ingrid Ticona + Edgar Laime
('RNT-219', 'CLI-236-1', 'Cédula de Identidad', 1),
('RNT-219', 'CLI-237-1', 'Licencia de Conducir', 1),
('RNT-219', 'CLI-237-1', 'Cédula de Identidad', 1),

-- RNT-220: Yolanda Pinto
('RNT-220', 'CLI-238-1', 'Cédula de Identidad', 1),
('RNT-220', 'CLI-238-1', 'Pasaporte', 1),

-- RNT-221: Victor Apaza + Gladys Colque
('RNT-221', 'CLI-239-1', 'Cédula de Identidad', 1),
('RNT-221', 'CLI-240-1', 'Cédula de Identidad', 1),
('RNT-221', 'CLI-240-1', 'Licencia de Conducir', 1),

-- RNT-222: Ramiro Huanca + Susana Chura
('RNT-222', 'CLI-241-1', 'Licencia de Conducir', 1),
('RNT-222', 'CLI-241-1', 'Cédula de Identidad', 1),
('RNT-222', 'CLI-242-1', 'Cédula de Identidad', 1),

-- RNT-223: Wilfredo Limachi
('RNT-223', 'CLI-243-1', 'Cédula de Identidad', 1),

-- RNT-224: Miriam Tacuri + Freddy Villca
('RNT-224', 'CLI-244-1', 'Cédula de Identidad', 1),
('RNT-224', 'CLI-244-1', 'Pasaporte', 1),
('RNT-224', 'CLI-245-1', 'Licencia de Conducir', 1),

-- RNT-225: Lourdes Tarqui + Marcelo Yujra + Roxana Guarachi
('RNT-225', 'CLI-246-1', 'Cédula de Identidad', 1),
('RNT-225', 'CLI-247-1', 'Cédula de Identidad', 1),
('RNT-225', 'CLI-247-1', 'Licencia de Conducir', 1),
('RNT-225', 'CLI-248-1', 'Cédula de Identidad', 1);

-- RENTAS MARZO 2025 (20 días hábiles aproximadamente)
-- ID inicial: RNT-226

-- Inserts para tabla Renta
INSERT INTO Renta (RentaID, EmpleadoID, FechaRenta, FechaDevolucion, FechaDevuelto, Descuento, Total, Multa) VALUES 
-- Día 3 marzo (lunes)
('RNT-226', 'MGR-001', '2025-03-03', '2025-03-08', '2025-03-08', 0, 1200, 0),
('RNT-227', 'MGR-002', '2025-03-03', '2025-03-10', '2025-03-10', 10, 540, 0),

-- Día 4 marzo (martes)
('RNT-228', 'MGR-001', '2025-03-04', '2025-03-09', '2025-03-09', 0, 800, 0),
('RNT-229', 'MGR-002', '2025-03-04', '2025-03-11', '2025-03-11', 5, 475, 0),
('RNT-230', 'MGR-001', '2025-03-04', '2025-03-12', '2025-03-13', 0, 1100, 25),

-- Día 5 marzo (miércoles)
('RNT-231', 'MGR-002', '2025-03-05', '2025-03-10', '2025-03-10', 0, 950, 0),
('RNT-232', 'MGR-001', '2025-03-05', '2025-03-13', '2025-03-13', 15, 595, 0),

-- Día 6 marzo (jueves)
('RNT-233', 'MGR-001', '2025-03-06', '2025-03-11', '2025-03-11', 0, 1500, 0),
('RNT-234', 'MGR-002', '2025-03-06', '2025-03-14', '2025-03-14', 0, 700, 0),
('RNT-235', 'MGR-001', '2025-03-06', '2025-03-15', '2025-03-16', 0, 1300, 30),

-- Día 7 marzo (viernes)
('RNT-236', 'MGR-002', '2025-03-07', '2025-03-12', '2025-03-12', 0, 600, 0),

-- Día 10 marzo (lunes)
('RNT-237', 'MGR-001', '2025-03-10', '2025-03-15', '2025-03-15', 20, 480, 0),
('RNT-238', 'MGR-002', '2025-03-10', '2025-03-18', '2025-03-18', 0, 1800, 0),
('RNT-239', 'MGR-001', '2025-03-10', '2025-03-17', '2025-03-17', 0, 900, 0),

-- Día 11 marzo (martes)
('RNT-240', 'MGR-002', '2025-03-11', '2025-03-16', '2025-03-16', 0, 750, 0),
('RNT-241', 'MGR-001', '2025-03-11', '2025-03-19', '2025-03-20', 5, 665, 40),

-- Día 12 marzo (miércoles)
('RNT-242', 'MGR-001', '2025-03-12', '2025-03-17', '2025-03-17', 0, 1400, 0),
('RNT-243', 'MGR-002', '2025-03-12', '2025-03-20', '2025-03-20', 10, 630, 0),
('RNT-244', 'MGR-001', '2025-03-12', '2025-03-19', '2025-03-19', 0, 850, 0),

-- Día 13 marzo (jueves)
('RNT-245', 'MGR-002', '2025-03-13', '2025-03-18', '2025-03-18', 0, 1050, 0),
('RNT-246', 'MGR-001', '2025-03-13', '2025-03-21', '2025-03-21', 0, 1250, 0),

-- Día 14 marzo (viernes)
('RNT-247', 'MGR-001', '2025-03-14', '2025-03-19', '2025-03-19', 15, 595, 0),
('RNT-248', 'MGR-002', '2025-03-14', '2025-03-22', '2025-03-23', 0, 920, 35),

-- Día 17 marzo (lunes)
('RNT-249', 'MGR-002', '2025-03-17', '2025-03-22', '2025-03-22', 0, 1600, 0),
('RNT-250', 'MGR-001', '2025-03-17', '2025-03-25', '2025-03-25', 5, 475, 0),
('RNT-251', 'MGR-002', '2025-03-17', '2025-03-24', '2025-03-24', 0, 1100, 0),

-- Día 18 marzo (martes)
('RNT-252', 'MGR-001', '2025-03-18', '2025-03-23', '2025-03-23', 0, 800, 0),
('RNT-253', 'MGR-002', '2025-03-18', '2025-03-26', '2025-03-27', 0, 1350, 45),

-- Día 19 marzo (miércoles)
('RNT-254', 'MGR-001', '2025-03-19', '2025-03-24', '2025-03-24', 20, 480, 0),
('RNT-255', 'MGR-002', '2025-03-19', '2025-03-27', '2025-03-27', 0, 1700, 0),
('RNT-256', 'MGR-001', '2025-03-19', '2025-03-25', '2025-03-25', 0, 650, 0),

-- Día 20 marzo (jueves)
('RNT-257', 'MGR-002', '2025-03-20', '2025-03-25', '2025-03-25', 0, 900, 0),
('RNT-258', 'MGR-001', '2025-03-20', '2025-03-28', '2025-03-28', 10, 630, 0),

-- Día 21 marzo (viernes)
('RNT-259', 'MGR-001', '2025-03-21', '2025-03-26', '2025-03-26', 0, 1200, 0),
('RNT-260', 'MGR-002', '2025-03-21', '2025-03-29', '2025-03-30', 0, 1450, 50),
('RNT-261', 'MGR-001', '2025-03-21', '2025-03-27', '2025-03-27', 5, 475, 0),

-- Día 24 marzo (lunes)
('RNT-262', 'MGR-002', '2025-03-24', '2025-03-29', '2025-03-29', 0, 750, 0),
('RNT-263', 'MGR-001', '2025-03-24', '2025-04-01', '2025-04-01', 15, 595, 0),

-- Día 25 marzo (martes)
('RNT-264', 'MGR-001', '2025-03-25', '2025-03-30', '2025-03-30', 0, 1000, 0),
('RNT-265', 'MGR-002', '2025-03-25', '2025-04-02', '2025-04-02', 0, 1300, 0),
('RNT-266', 'MGR-001', '2025-03-25', '2025-03-31', '2025-03-31', 0, 850, 0),

-- Día 26 marzo (miércoles)
('RNT-267', 'MGR-002', '2025-03-26', '2025-03-31', '2025-03-31', 0, 600, 0),
('RNT-268', 'MGR-001', '2025-03-26', '2025-04-03', '2025-04-04', 0, 1550, 60),

-- Día 27 marzo (jueves)
('RNT-269', 'MGR-001', '2025-03-27', '2025-04-01', '2025-04-01', 10, 540, 0),
('RNT-270', 'MGR-002', '2025-03-27', '2025-04-04', '2025-04-04', 0, 1200, 0),
('RNT-271', 'MGR-001', '2025-03-27', '2025-04-02', '2025-04-02', 0, 950, 0),

-- Día 28 marzo (viernes)
('RNT-272', 'MGR-002', '2025-03-28', '2025-04-02', '2025-04-02', 0, 700, 0),

-- Día 31 marzo (lunes)
('RNT-273', 'MGR-001', '2025-03-31', '2025-04-05', '2025-04-05', 0, 1400, 0),
('RNT-274', 'MGR-002', '2025-03-31', '2025-04-07', '2025-04-07', 5, 665, 0),
('RNT-275', 'MGR-001', '2025-03-31', '2025-04-06', '2025-04-06', 0, 800, 0);

-- Inserts para tabla Cliente
INSERT INTO Cliente (ClienteID, RentaID, Nombre, Apellido, Telefono, Garantia, Habilitado) VALUES 
('CLI-226', 'RNT-226', 'Ana María', 'Gonzalez', 78451236, 1, 1),
('CLI-227', 'RNT-227', 'Pedro José', 'Mamani', 76523478, 1, 1),
('CLI-228', 'RNT-227', 'Rosa Elena', 'Condori', 77896541, 1, 1),
('CLI-229', 'RNT-228', 'Miguel Angel', 'Vargas', 78965412, 1, 1),
('CLI-230', 'RNT-229', 'Carmen Isabel', 'Flores', 76234789, 1, 1),
('CLI-231', 'RNT-230', 'Luis Alberto', 'Quispe', 77541236, 1, 1),
('CLI-232', 'RNT-230', 'María Teresa', 'Choque', 78632147, 1, 1),
('CLI-233', 'RNT-231', 'Carlos Eduardo', 'Poma', 76741852, 1, 1),
('CLI-234', 'RNT-232', 'Silvia Patricia', 'Marca', 77852963, 1, 1),
('CLI-235', 'RNT-232', 'Roberto Daniel', 'Alanoca', 78963741, 1, 1),
('CLI-236', 'RNT-233', 'Gloria Esperanza', 'Chipana', 76147258, 1, 1),
('CLI-237', 'RNT-234', 'Juan Carlos', 'Limachi', 77258369, 1, 1),
('CLI-238', 'RNT-235', 'Mónica Beatriz', 'Calle', 78369147, 1, 1),
('CLI-239', 'RNT-235', 'Fernando José', 'Huanca', 76471852, 1, 1),
('CLI-240', 'RNT-236', 'Adriana Soledad', 'Paxi', 77582963, 1, 1),
('CLI-241', 'RNT-237', 'Gonzalo Ramiro', 'Tola', 78694752, 1, 1),
('CLI-242', 'RNT-238', 'Verónica Andrea', 'Chuquimia', 76258147, 1, 1),
('CLI-243', 'RNT-238', 'Alberto Waldo', 'Nina', 77369258, 1, 1),
('CLI-244', 'RNT-238', 'Diana Elizabeth', 'Mamani', 78147369, 1, 1),
('CLI-245', 'RNT-239', 'Ricardo Patricio', 'Condori', 76852741, 1, 1),
('CLI-246', 'RNT-240', 'Janeth Roxana', 'Ticona', 77963852, 1, 1),
('CLI-247', 'RNT-241', 'Ramiro Javier', 'Apaza', 78741963, 1, 1),
('CLI-248', 'RNT-241', 'Sandra Miriam', 'Chura', 76369147, 1, 1),
('CLI-249', 'RNT-242', 'Wilmer Freddy', 'Coaquira', 77147258, 1, 1),
('CLI-250', 'RNT-243', 'Natalia Carmen', 'Machaca', 78258369, 1, 1),
('CLI-251', 'RNT-244', 'Oscar Vladimir', 'Callisaya', 76741852, 1, 1),
('CLI-252', 'RNT-244', 'Paola Fernanda', 'Tito', 77852963, 1, 1),
('CLI-253', 'RNT-245', 'Mario Rubén', 'Colque', 78963147, 1, 1),
('CLI-254', 'RNT-246', 'Graciela Norma', 'Yampara', 76147852, 1, 1),
('CLI-255', 'RNT-246', 'Hector Manuel', 'Cutipa', 77258963, 1, 1),
('CLI-256', 'RNT-247', 'Carla Vanessa', 'Quelca', 78369741, 1, 1),
('CLI-257', 'RNT-248', 'Edgar Nelson', 'Charca', 76471258, 1, 1),
('CLI-258', 'RNT-248', 'Lourdes Maribel', 'Tarqui', 77582369, 1, 1),
('CLI-259', 'RNT-249', 'Daniel Marcelo', 'Ichuta', 78693147, 1, 1),
('CLI-260', 'RNT-249', 'Lucía Alejandra', 'Chambi', 76147258, 1, 1),
('CLI-261', 'RNT-250', 'Sergio Antonio', 'Condori', 77258369, 1, 1),
('CLI-262', 'RNT-251', 'Cristina Paola', 'Mamani', 78369147, 1, 1),
('CLI-263', 'RNT-251', 'Jorge Luis', 'Quispe', 76471852, 1, 1),
('CLI-264', 'RNT-252', 'Ángela María', 'Flores', 77582963, 1, 1),
('CLI-265', 'RNT-253', 'Hugo Enrique', 'Vargas', 78693741, 1, 1),
('CLI-266', 'RNT-253', 'Beatriz Elena', 'Poma', 76147369, 1, 1),
('CLI-267', 'RNT-253', 'Fabián Rodrigo', 'Choque', 77258147, 1, 1),
('CLI-268', 'RNT-254', 'Rosario Carmen', 'Marca', 78369258, 1, 1),
('CLI-269', 'RNT-255', 'Julio César', 'Alanoca', 76471369, 1, 1),
('CLI-270', 'RNT-255', 'Gladys Victoria', 'Chipana', 77582147, 1, 1),
('CLI-271', 'RNT-255', 'Wilson Roberto', 'Limachi', 78693258, 1, 1),
('CLI-272', 'RNT-256', 'Sonia Esperanza', 'Calle', 76147471, 1, 1),
('CLI-273', 'RNT-257', 'Freddy Vladimir', 'Huanca', 77258582, 1, 1),
('CLI-274', 'RNT-257', 'Patricia Rosa', 'Paxi', 78369693, 1, 1),
('CLI-275', 'RNT-258', 'Germán Rolando', 'Tola', 76471147, 1, 1),
('CLI-276-2', 'RNT-259', 'Yolanda Inés', 'Chuquimia', 77582258, 1, 1),
('CLI-277-2', 'RNT-260', 'Jaime Fernando', 'Nina', 78693369, 1, 1),
('CLI-278-2', 'RNT-260', 'Martha Soledad', 'Mamani', 76147582, 1, 1),
('CLI-279-2', 'RNT-260', 'Víctor Hugo', 'Condori', 77258693, 1, 1),
('CLI-280-2', 'RNT-261', 'Lidia Carmen', 'Ticona', 78369147, 1, 1),
('CLI-281-2', 'RNT-262', 'Eduardo René', 'Apaza', 76471258, 1, 1),
('CLI-282-2', 'RNT-262', 'Claudia Patricia', 'Chura', 77582369, 1, 1),
('CLI-283-2', 'RNT-263', 'Ruben Dario', 'Coaquira', 78693471, 1, 1),
('CLI-284-2', 'RNT-264', 'Isabel Cristina', 'Machaca', 76147582, 1, 1),
('CLI-285-2', 'RNT-265', 'Marcelo Antonio', 'Callisaya', 77258693, 1, 1),
('CLI-286-2', 'RNT-265', 'Alicia Norma', 'Tito', 78369147, 1, 1),
('CLI-287-2', 'RNT-266', 'Franz Roberto', 'Colque', 76471258, 1, 1),
('CLI-288-2', 'RNT-266', 'Mirtha Elena', 'Yampara', 77582369, 1, 1),
('CLI-289-2', 'RNT-267', 'Gustavo Ramón', 'Cutipa', 78693471, 1, 1),
('CLI-290-2', 'RNT-268', 'Teresa Ángela', 'Quelca', 76147582, 1, 1),
('CLI-291-2', 'RNT-268', 'Armando Luis', 'Charca', 77258693, 1, 1),
('CLI-292-2', 'RNT-268', 'Nilda Rosa', 'Tarqui', 78369147, 1, 1),
('CLI-293-2', 'RNT-269', 'Hernán Oscar', 'Ichuta', 76471258, 1, 1),
('CLI-294-2', 'RNT-270', 'Magda Eliana', 'Chambi', 77582369, 1, 1),
('CLI-295-2', 'RNT-270', 'Percy Gonzalo', 'Condori', 78693471, 1, 1),
('CLI-296-2', 'RNT-271', 'Griselda María', 'Mamani', 76147582, 1, 1),
('CLI-297-2', 'RNT-271', 'Rolando César', 'Quispe', 77258693, 1, 1),
('CLI-298-2', 'RNT-272', 'Esther Guadalupe', 'Flores', 78369147, 1, 1),
('CLI-299-2', 'RNT-273', 'Mauricio René', 'Vargas', 76471258, 1, 1),
('CLI-300-2', 'RNT-273', 'Delia Esperanza', 'Poma', 77582369, 1, 1),
('CLI-301-2', 'RNT-274', 'Rodrigo Javier', 'Choque', 78693471, 1, 1),
('CLI-302-2', 'RNT-274', 'Elva Concepción', 'Marca', 76147582, 1, 1),
('CLI-303-2', 'RNT-275', 'Willy Hernán', 'Alanoca', 77258693, 1, 1);

-- Inserts para tabla DetalleRenta
INSERT INTO DetalleRenta (RentaID, ProductoID, Cantidad, Subtotal, Habilitado) VALUES 
-- RNT-226
('RNT-226', 'PRD-001', 2, 1200, 1),
-- RNT-227
('RNT-227', 'PRD-006', 1, 600, 1),
-- RNT-228
('RNT-228', 'PRD-003', 4, 800, 1),
-- RNT-229
('RNT-229', 'PRD-004', 5, 500, 1),
-- RNT-230
('RNT-230', 'PRD-011', 1, 600, 1),
('RNT-230', 'PRD-013', 1, 200, 1),
('RNT-230', 'PRD-098', 1, 300, 1),
-- RNT-231
('RNT-231', 'PRD-007', 1, 500, 1),
('RNT-231', 'PRD-081', 1, 250, 1),
('RNT-231', 'PRD-104', 1, 250, 1),
-- RNT-232
('RNT-232', 'PRD-016', 1, 500, 1),
('RNT-232', 'PRD-019', 1, 100, 1),
-- RNT-233
('RNT-233', 'PRD-021', 2, 800, 1),
('RNT-233', 'PRD-023', 3, 600, 1),
('RNT-233', 'PRD-024', 1, 100, 1),
-- RNT-234
('RNT-234', 'PRD-026', 1, 600, 1),
('RNT-234', 'PRD-029', 1, 100, 1),
-- RNT-235
('RNT-235', 'PRD-031', 2, 1200, 1),
('RNT-235', 'PRD-033', 1, 200, 1),
-- RNT-236
('RNT-236', 'PRD-036', 1, 600, 1),
-- RNT-237
('RNT-237', 'PRD-041', 1, 600, 1),
-- RNT-238
('RNT-238', 'PRD-051', 3, 1800, 1),
-- RNT-239
('RNT-239', 'PRD-056', 1, 900, 1),
-- RNT-240
('RNT-240', 'PRD-061', 1, 600, 1),
('RNT-240', 'PRD-064', 1, 100, 1),
('RNT-240', 'PRD-072', 1, 50, 1),
-- RNT-241
('RNT-241', 'PRD-076', 1, 600, 1),
('RNT-241', 'PRD-079', 1, 100, 1),
-- RNT-242
('RNT-242', 'PRD-001', 1, 600, 1),
('RNT-242', 'PRD-002', 1, 500, 1),
('RNT-242', 'PRD-098', 1, 300, 1),
-- RNT-243
('RNT-243', 'PRD-006', 1, 600, 1),
('RNT-243', 'PRD-009', 1, 100, 1),
-- RNT-244
('RNT-244', 'PRD-011', 1, 600, 1),
('RNT-244', 'PRD-081', 1, 250, 1),
-- RNT-245
('RNT-245', 'PRD-016', 1, 500, 1),
('RNT-245', 'PRD-017', 1, 400, 1),
('RNT-245', 'PRD-019', 1, 100, 1),
('RNT-245', 'PRD-072', 1, 50, 1),
-- RNT-246
('RNT-246', 'PRD-021', 2, 800, 1),
('RNT-246', 'PRD-022', 1, 300, 1),
('RNT-246', 'PRD-024', 1, 100, 1),
('RNT-246', 'PRD-072', 1, 50, 1),
-- RNT-247
('RNT-247', 'PRD-026', 1, 600, 1),
('RNT-247', 'PRD-029', 1, 100, 1),
-- RNT-248
('RNT-248', 'PRD-031', 1, 600, 1),
('RNT-248', 'PRD-098', 1, 300, 1),
('RNT-248', 'PRD-073', 1, 120, 1),
-- RNT-249
('RNT-249', 'PRD-036', 2, 1200, 1),
('RNT-249', 'PRD-038', 1, 400, 1),
-- RNT-250
('RNT-250', 'PRD-041', 1, 600, 1),
-- RNT-251
('RNT-251', 'PRD-051', 1, 600, 1),
('RNT-251', 'PRD-053', 2, 400, 1),
('RNT-251', 'PRD-054', 1, 100, 1),
-- RNT-252
('RNT-252', 'PRD-056', 1, 900, 1),
-- RNT-253
('RNT-253', 'PRD-061', 2, 1200, 1),
('RNT-253', 'PRD-063', 1, 200, 1),
-- RNT-254
('RNT-254', 'PRD-066', 1, 600, 1),
-- RNT-255
('RNT-255', 'PRD-071', 2, 120, 1),
('RNT-255', 'PRD-076', 2, 1200, 1),
('RNT-255', 'PRD-078', 2, 400, 1),
-- RNT-256
('RNT-256', 'PRD-081', 1, 250, 1),
('RNT-256', 'PRD-098', 1, 300, 1),
('RNT-256', 'PRD-073', 1, 120, 1),
-- RNT-257
('RNT-257', 'PRD-001', 1, 600, 1),
('RNT-257', 'PRD-098', 1, 300, 1),
-- RNT-258
('RNT-258', 'PRD-006', 1, 600, 1),
('RNT-258', 'PRD-009', 1, 100, 1),
-- RNT-259
('RNT-259', 'PRD-011', 2, 1200, 1),
-- RNT-260
('RNT-260', 'PRD-016', 2, 1000, 1),
('RNT-260', 'PRD-017', 1, 400, 1),
('RNT-260', 'PRD-072', 1, 50, 1),
-- RNT-261
('RNT-261', 'PRD-021', 1, 400, 1),
('RNT-261', 'PRD-024', 1, 100, 1),
-- RNT-262
('RNT-262', 'PRD-026', 1, 600, 1),
('RNT-262', 'PRD-073', 1, 120, 1),
('RNT-262', 'PRD-074', 1, 100, 1),
-- RNT-263
('RNT-263', 'PRD-031', 1, 600, 1),
-- RNT-264
('RNT-264', 'PRD-036', 1, 600, 1),
('RNT-264', 'PRD-038', 1, 400, 1),
-- RNT-265
('RNT-265', 'PRD-041', 2, 1200, 1),
('RNT-265', 'PRD-043', 1, 200, 1),
-- RNT-266
('RNT-266', 'PRD-051', 1, 600, 1),
('RNT-266', 'PRD-081', 1, 250, 1),
-- RNT-267
('RNT-267', 'PRD-056', 1, 900, 1),
-- RNT-268
('RNT-268', 'PRD-061', 2, 1200, 1),
('RNT-268', 'PRD-098', 1, 300, 1),
('RNT-268', 'PRD-072', 1, 50, 1),
-- RNT-269
('RNT-269', 'PRD-066', 1, 600, 1),
-- RNT-270
('RNT-270', 'PRD-071', 2, 120, 1),
('RNT-270', 'PRD-076', 1, 600, 1),
('RNT-270', 'PRD-078', 2, 400, 1),
('RNT-270', 'PRD-079', 1, 100, 1),
-- RNT-271
('RNT-271', 'PRD-001', 1, 600, 1),
('RNT-271', 'PRD-003', 1, 200, 1),
('RNT-271', 'PRD-073', 1, 120, 1),
('RNT-271', 'PRD-074', 1, 100, 1),
-- RNT-272
('RNT-272', 'PRD-006', 1, 600, 1),
('RNT-272', 'PRD-009', 1, 100, 1),
-- RNT-273
('RNT-273', 'PRD-011', 2, 1200, 1),
('RNT-273', 'PRD-013', 1, 200, 1),
-- RNT-274
('RNT-274', 'PRD-016', 1, 500, 1),
('RNT-274', 'PRD-018', 1, 200, 1),
-- RNT-275
('RNT-275', 'PRD-021', 2, 800, 1);

-- Inserts para tabla Garantia
INSERT INTO Garantia (RentaID, ClienteID, Tipo, Habilitado) VALUES 
-- Una garantía por cliente (algunas con múltiples garantías)
('RNT-226', 'CLI-226', 'Cédula de Identidad', 1),
('RNT-227', 'CLI-227', 'Licencia de Conducir', 1),
('RNT-227', 'CLI-228', 'Cédula de Identidad', 1),
('RNT-228', 'CLI-229', 'Pasaporte', 1),
('RNT-229', 'CLI-230', 'Cédula de Identidad', 1),
('RNT-230', 'CLI-231', 'Licencia de Conducir', 1),
('RNT-230', 'CLI-231', 'Cédula de Identidad', 1),
('RNT-230', 'CLI-232', 'Pasaporte', 1),
('RNT-231', 'CLI-233', 'Cédula de Identidad', 1),
('RNT-232', 'CLI-234', 'Licencia de Conducir', 1),
('RNT-232', 'CLI-235', 'Cédula de Identidad', 1),
('RNT-232', 'CLI-235', 'Carnet Universitario', 1),
('RNT-233', 'CLI-236', 'Pasaporte', 1),
('RNT-234', 'CLI-237', 'Cédula de Identidad', 1),
('RNT-235', 'CLI-238', 'Licencia de Conducir', 1),
('RNT-235', 'CLI-239', 'Cédula de Identidad', 1),
('RNT-235', 'CLI-239', 'Carnet Militar', 1),
('RNT-236', 'CLI-240', 'Pasaporte', 1),
('RNT-237', 'CLI-241', 'Cédula de Identidad', 1),
('RNT-238', 'CLI-242', 'Licencia de Conducir', 1),
('RNT-238', 'CLI-243', 'Cédula de Identidad', 1),
('RNT-238', 'CLI-244', 'Pasaporte', 1),
('RNT-238', 'CLI-244', 'Carnet Universitario', 1),
('RNT-239', 'CLI-245', 'Cédula de Identidad', 1),
('RNT-240', 'CLI-246', 'Licencia de Conducir', 1),
('RNT-241', 'CLI-247', 'Cédula de Identidad', 1),
('RNT-241', 'CLI-248', 'Pasaporte', 1),
('RNT-242', 'CLI-249', 'Cédula de Identidad', 1),
('RNT-242', 'CLI-249', 'Licencia de Conducir', 1),
('RNT-243', 'CLI-250', 'Carnet Universitario', 1),
('RNT-244', 'CLI-251', 'Cédula de Identidad', 1),
('RNT-244', 'CLI-252', 'Pasaporte', 1),
('RNT-245', 'CLI-253', 'Licencia de Conducir', 1),
('RNT-246', 'CLI-254', 'Cédula de Identidad', 1),
('RNT-246', 'CLI-255', 'Carnet Militar', 1),
('RNT-246', 'CLI-255', 'Cédula de Identidad', 1),
('RNT-247', 'CLI-256', 'Pasaporte', 1),
('RNT-248', 'CLI-257', 'Cédula de Identidad', 1),
('RNT-248', 'CLI-258', 'Licencia de Conducir', 1),
('RNT-249', 'CLI-259', 'Cédula de Identidad', 1),
('RNT-249', 'CLI-260', 'Carnet Universitario', 1),
('RNT-250', 'CLI-261', 'Pasaporte', 1),
('RNT-251', 'CLI-262', 'Cédula de Identidad', 1),
('RNT-251', 'CLI-263', 'Licencia de Conducir', 1),
('RNT-251', 'CLI-263', 'Carnet Militar', 1),
('RNT-252', 'CLI-264', 'Cédula de Identidad', 1),
('RNT-253', 'CLI-265', 'Pasaporte', 1),
('RNT-253', 'CLI-266', 'Cédula de Identidad', 1),
('RNT-253', 'CLI-267', 'Licencia de Conducir', 1),
('RNT-254', 'CLI-268', 'Carnet Universitario', 1),
('RNT-255', 'CLI-269', 'Cédula de Identidad', 1),
('RNT-255', 'CLI-270', 'Pasaporte', 1),
('RNT-255', 'CLI-271', 'Licencia de Conducir', 1),
('RNT-255', 'CLI-271', 'Carnet Militar', 1),
('RNT-256', 'CLI-272', 'Cédula de Identidad', 1),
('RNT-257', 'CLI-273', 'Licencia de Conducir', 1),
('RNT-257', 'CLI-274', 'Pasaporte', 1),
('RNT-258', 'CLI-275', 'Cédula de Identidad', 1),
('RNT-258', 'CLI-275', 'Carnet Universitario', 1),
('RNT-259', 'CLI-276-2', 'Licencia de Conducir', 1),
('RNT-260', 'CLI-277-2', 'Cédula de Identidad', 1),
('RNT-260', 'CLI-278-2', 'Pasaporte', 1),
('RNT-260', 'CLI-279-2', 'Carnet Militar', 1),
('RNT-260', 'CLI-279-2', 'Cédula de Identidad', 1),
('RNT-261', 'CLI-280-2', 'Licencia de Conducir', 1),
('RNT-262', 'CLI-281-2', 'Cédula de Identidad', 1),
('RNT-262', 'CLI-282-2', 'Pasaporte', 1),
('RNT-263', 'CLI-283-2', 'Carnet Universitario', 1),
('RNT-264', 'CLI-284-2', 'Cédula de Identidad', 1),
('RNT-265', 'CLI-285-2', 'Licencia de Conducir', 1),
('RNT-265', 'CLI-286-2', 'Pasaporte', 1),
('RNT-265', 'CLI-286-2', 'Carnet Militar', 1),
('RNT-266', 'CLI-287-2', 'Cédula de Identidad', 1),
('RNT-266', 'CLI-288-2', 'Licencia de Conducir', 1),
('RNT-267', 'CLI-289-2', 'Pasaporte', 1),
('RNT-268', 'CLI-290-2', 'Cédula de Identidad', 1),
('RNT-268', 'CLI-291-2', 'Carnet Universitario', 1),
('RNT-268', 'CLI-292-2', 'Licencia de Conducir', 1),
('RNT-268', 'CLI-292-2', 'Cédula de Identidad', 1),
('RNT-269', 'CLI-293-2', 'Pasaporte', 1),
('RNT-270', 'CLI-294-2', 'Cédula de Identidad', 1),
('RNT-270', 'CLI-295-2', 'Licencia de Conducir', 1),
('RNT-271', 'CLI-296-2', 'Carnet Militar', 1),
('RNT-271', 'CLI-297-2', 'Cédula de Identidad', 1),
('RNT-271', 'CLI-297-2', 'Pasaporte', 1),
('RNT-272', 'CLI-298-2', 'Licencia de Conducir', 1),
('RNT-273', 'CLI-299-2', 'Cédula de Identidad', 1),
('RNT-273', 'CLI-300-2', 'Carnet Universitario', 1),
('RNT-274', 'CLI-301-2', 'Pasaporte', 1),
('RNT-274', 'CLI-302-2', 'Cédula de Identidad', 1),
('RNT-274', 'CLI-302-2', 'Licencia de Conducir', 1),
('RNT-275', 'CLI-303-2', 'Carnet Militar', 1);

-- RENTAS ABRIL 2025
-- Inserts para tabla Renta
INSERT INTO Renta (RentaID, EmpleadoID, FechaRenta, FechaDevolucion, FechaDevuelto, Descuento, Total, Multa) VALUES 
-- Día 1 - Martes 1 de abril
('RNT-276', 'MGR-001', '2025-04-01', '2025-04-06', '2025-04-06', 0, 1400, 0),
('RNT-277', 'MGR-002', '2025-04-01', '2025-04-08', '2025-04-08', 10, 1800, 0),

-- Día 2 - Miércoles 2 de abril  
('RNT-278', 'MGR-001', '2025-04-02', '2025-04-07', '2025-04-09', 0, 950, 100),
('RNT-279', 'MGR-002', '2025-04-02', '2025-04-09', NULL, 5, 1650, 0),

-- Día 3 - Jueves 3 de abril
('RNT-280', 'MGR-001', '2025-04-03', '2025-04-10', '2025-04-10', 0, 2200, 0),

-- Día 4 - Viernes 4 de abril
('RNT-281', 'MGR-002', '2025-04-04', '2025-04-11', '2025-04-12', 0, 1100, 50),
('RNT-282', 'MGR-001', '2025-04-04', '2025-04-09', '2025-04-09', 15, 750, 0),

-- Día 7 - Lunes 7 de abril
('RNT-283', 'MGR-001', '2025-04-07', '2025-04-14', NULL, 0, 1850, 0),
('RNT-284', 'MGR-002', '2025-04-07', '2025-04-12', '2025-04-12', 0, 900, 0),

-- Día 8 - Martes 8 de abril
('RNT-285', 'MGR-001', '2025-04-08', '2025-04-15', '2025-04-15', 5, 1300, 0),

-- Día 9 - Miércoles 9 de abril
('RNT-286', 'MGR-002', '2025-04-09', '2025-04-16', NULL, 0, 2100, 0),
('RNT-287', 'MGR-001', '2025-04-09', '2025-04-14', '2025-04-14', 0, 1600, 0),

-- Día 10 - Jueves 10 de abril
('RNT-288', 'MGR-001', '2025-04-10', '2025-04-17', '2025-04-18', 0, 1750, 75),

-- Día 11 - Viernes 11 de abril
('RNT-289', 'MGR-002', '2025-04-11', '2025-04-18', NULL, 10, 1450, 0),
('RNT-290', 'MGR-001', '2025-04-11', '2025-04-16', '2025-04-16', 0, 800, 0),

-- Día 14 - Lunes 14 de abril
('RNT-291', 'MGR-001', '2025-04-14', '2025-04-21', NULL, 0, 2000, 0),
('RNT-292', 'MGR-002', '2025-04-14', '2025-04-19', '2025-04-19', 0, 1200, 0),
('RNT-293', 'MGR-001', '2025-04-14', '2025-04-21', '2025-04-21', 5, 950, 0),

-- Día 15 - Martes 15 de abril
('RNT-294', 'MGR-002', '2025-04-15', '2025-04-22', NULL, 0, 1800, 0),

-- Día 16 - Miércoles 16 de abril
('RNT-295', 'MGR-001', '2025-04-16', '2025-04-23', NULL, 0, 1500, 0),
('RNT-296', 'MGR-002', '2025-04-16', '2025-04-21', '2025-04-21', 0, 1100, 0),

-- Día 17 - Jueves 17 de abril
('RNT-297', 'MGR-001', '2025-04-17', '2025-04-24', NULL, 15, 1750, 0),

-- Día 18 - Viernes 18 de abril
('RNT-298', 'MGR-002', '2025-04-18', '2025-04-25', NULL, 0, 2200, 0),
('RNT-299', 'MGR-001', '2025-04-18', '2025-04-23', '2025-04-25', 0, 900, 100),

-- Día 21 - Lunes 21 de abril
('RNT-300', 'MGR-001', '2025-04-21', '2025-04-28', NULL, 0, 1650, 0),

-- Día 22 - Martes 22 de abril
('RNT-301', 'MGR-002', '2025-04-22', '2025-04-29', NULL, 5, 1400, 0),
('RNT-302', 'MGR-001', '2025-04-22', '2025-04-29', NULL, 0, 1000, 0),

-- Día 23 - Miércoles 23 de abril
('RNT-303', 'MGR-002', '2025-04-23', '2025-04-30', NULL, 0, 1850, 0),

-- Día 24 - Jueves 24 de abril
('RNT-304', 'MGR-001', '2025-04-24', '2025-05-01', NULL, 10, 1300, 0),
('RNT-305', 'MGR-002', '2025-04-24', '2025-05-01', NULL, 0, 1950, 0),

-- Día 25 - Viernes 25 de abril
('RNT-306', 'MGR-001', '2025-04-25', '2025-05-02', NULL, 0, 2100, 0),

-- Día 28 - Lunes 28 de abril
('RNT-307', 'MGR-002', '2025-04-28', '2025-05-05', NULL, 0, 1600, 0),
('RNT-308', 'MGR-001', '2025-04-28', '2025-05-03', NULL, 5, 1200, 0),

-- Día 29 - Martes 29 de abril
('RNT-309', 'MGR-001', '2025-04-29', '2025-05-06', NULL, 0, 1750, 0),

-- Día 30 - Miércoles 30 de abril
('RNT-310', 'MGR-002', '2025-04-30', '2025-05-07', NULL, 0, 1400, 0),
('RNT-311', 'MGR-001', '2025-04-30', '2025-05-05', NULL, 10, 1100, 0);

-- Inserts para tabla Cliente
INSERT INTO Cliente (ClienteID, RentaID, Nombre, Apellido, Telefono, Garantia, Habilitado) VALUES 
-- Clientes RNT-276
('CLI-276', 'RNT-276', 'Ana María', 'López', 78456123, 1, 1),
-- Clientes RNT-277
('CLI-277', 'RNT-277', 'Roberto', 'Silva', 76542189, 1, 1),
('CLI-278', 'RNT-277', 'Carmen', 'Flores', 71234567, 1, 1),
-- Clientes RNT-278
('CLI-279', 'RNT-278', 'Luis', 'Mamani', 79876543, 1, 1),
-- Clientes RNT-279
('CLI-280', 'RNT-279', 'Patricia', 'Condori', 76543210, 1, 1),
('CLI-281', 'RNT-279', 'Miguel', 'Quispe', 78901234, 1, 1),
-- Clientes RNT-280
('CLI-282', 'RNT-280', 'Rosa', 'Vargas', 77654321, 1, 1),
('CLI-283', 'RNT-280', 'Daniel', 'Choque', 76789012, 1, 1),
-- Clientes RNT-281
('CLI-284', 'RNT-281', 'Elena', 'Morales', 78123456, 1, 1),
-- Clientes RNT-282
('CLI-285', 'RNT-282', 'Fernando', 'Apaza', 79345678, 1, 1),
-- Clientes RNT-283
('CLI-286', 'RNT-283', 'Mariana', 'Cruz', 76890123, 1, 1),
-- Clientes RNT-284
('CLI-287', 'RNT-284', 'Jorge', 'Huanca', 78567890, 1, 1),
-- Clientes RNT-285
('CLI-288', 'RNT-285', 'Silvia', 'Poma', 77890123, 1, 1),
-- Clientes RNT-286
('CLI-289', 'RNT-286', 'Pedro', 'Calle', 76456789, 1, 1),
('CLI-290', 'RNT-286', 'Claudia', 'Nina', 78234567, 1, 1),
-- Clientes RNT-287
('CLI-291', 'RNT-287', 'Alberto', 'Mamani', 79567890, 1, 1),
-- Clientes RNT-288
('CLI-292', 'RNT-288', 'Gloria', 'Ticona', 77123456, 1, 1),
('CLI-293', 'RNT-288', 'Raúl', 'Limachi', 76678901, 1, 1),
-- Clientes RNT-289
('CLI-294', 'RNT-289', 'Verónica', 'Chura', 78345678, 1, 1),
-- Clientes RNT-290
('CLI-295', 'RNT-290', 'Oscar', 'Jaliri', 79234567, 1, 1),
-- Clientes RNT-291
('CLI-296', 'RNT-291', 'Mónica', 'Quisbert', 77456789, 1, 1),
('CLI-297', 'RNT-291', 'Julio', 'Arce', 76123456, 1, 1),
-- Clientes RNT-292
('CLI-298', 'RNT-292', 'Isabel', 'Colque', 78789012, 1, 1),
-- Clientes RNT-293
('CLI-299', 'RNT-293', 'Andrés', 'Tarqui', 79123456, 1, 1),
-- Clientes RNT-294
('CLI-300', 'RNT-294', 'Lucía', 'Alanoca', 77234567, 1, 1),
('CLI-301', 'RNT-294', 'Carlos', 'Yujra', 76345678, 1, 1),
-- Clientes RNT-295
('CLI-302', 'RNT-295', 'Sandra', 'Cutipa', 78456789, 1, 1),
-- Clientes RNT-296
('CLI-303', 'RNT-296', 'Ricardo', 'Callisaya', 79345678, 1, 1),
-- Clientes RNT-297
('CLI-304', 'RNT-297', 'Martha', 'Condori', 77567890, 1, 1),
('CLI-305', 'RNT-297', 'Gonzalo', 'Mamani', 76234567, 1, 1),
-- Clientes RNT-298
('CLI-306', 'RNT-298', 'Alejandra', 'Quispe', 78678901, 1, 1),
('CLI-307', 'RNT-298', 'Víctor', 'Choque', 79456789, 1, 1),
-- Clientes RNT-299
('CLI-308', 'RNT-299', 'Beatriz', 'Flores', 77345678, 1, 1),
-- Clientes RNT-300
('CLI-309', 'RNT-300', 'Héctor', 'Silva', 76567890, 1, 1),
-- Clientes RNT-301
('CLI-310', 'RNT-301', 'Cristina', 'López', 78890123, 1, 1),
-- Clientes RNT-302
('CLI-311', 'RNT-302', 'Manuel', 'Vargas', 79678901, 1, 1),
-- Clientes RNT-303
('CLI-312', 'RNT-303', 'Diana', 'Morales', 77678901, 1, 1),
('CLI-313', 'RNT-303', 'Rubén', 'Apaza', 76789012, 1, 1),
-- Clientes RNT-304
('CLI-314', 'RNT-304', 'Carla', 'Cruz', 78234567, 1, 1),
-- Clientes RNT-305
('CLI-315', 'RNT-305', 'Esteban', 'Huanca', 79890123, 1, 1),
('CLI-316', 'RNT-305', 'Paola', 'Poma', 77789012, 1, 1),
-- Clientes RNT-306
('CLI-317', 'RNT-306', 'Francisco', 'Calle', 76456789, 1, 1),
('CLI-318', 'RNT-306', 'Rosario', 'Nina', 78567890, 1, 1),
-- Clientes RNT-307
('CLI-319', 'RNT-307', 'Diego', 'Mamani', 79234567, 1, 1),
-- Clientes RNT-308
('CLI-320', 'RNT-308', 'Lorena', 'Ticona', 77456789, 1, 1),
-- Clientes RNT-309
('CLI-321', 'RNT-309', 'Sergio', 'Limachi', 76678901, 1, 1),
('CLI-322', 'RNT-309', 'Gabriela', 'Chura', 78345678, 1, 1),
-- Clientes RNT-310
('CLI-323', 'RNT-310', 'Eduardo', 'Jaliri', 79567890, 1, 1),
-- Clientes RNT-311
('CLI-324', 'RNT-311', 'Natalia', 'Quisbert', 77890123, 1, 1);

-- Inserts para tabla DetalleRenta
INSERT INTO DetalleRenta (RentaID, ProductoID, Cantidad, Subtotal, Habilitado) VALUES 
-- RNT-276: Ana María López
('RNT-276', 'PRD-001', 2, 1200, 1), -- Chaqueta Rojo/Negro
('RNT-276', 'PRD-004', 2, 200, 1), -- Faja Rojo/Negro

-- RNT-277: Roberto Silva y Carmen Flores
('RNT-277', 'PRD-011', 2, 1200, 1), -- Chaqueta Rojo/Dorado
('RNT-277', 'PRD-013', 2, 400, 1), -- Pantalón Rojo/Dorado
('RNT-277', 'PRD-098', 1, 300, 1), -- Pollera Roja

-- RNT-278: Luis Mamani
('RNT-278', 'PRD-081', 1, 250, 1), -- Pepino
('RNT-278', 'PRD-098', 2, 600, 1), -- Pollera Roja
('RNT-278', 'PRD-104', 1, 250, 1), -- Sombrero Blanco

-- RNT-279: Patricia Condori y Miguel Quispe
('RNT-279', 'PRD-026', 2, 1200, 1), -- Chaqueta Verde Whatsapp
('RNT-279', 'PRD-028', 2, 600, 1), -- Pantalón Verde Whatsapp

-- RNT-280: Rosa Vargas y Daniel Choque
('RNT-280', 'PRD-036', 3, 1800, 1), -- Chaqueta Morado
('RNT-280', 'PRD-038', 2, 800, 1), -- Pantalón Morado

-- RNT-281: Elena Morales
('RNT-281', 'PRD-046', 1, 600, 1), -- Chaqueta Verde Pacai
('RNT-281', 'PRD-048', 2, 400, 1), -- Pantalón Verde Pacai
('RNT-281', 'PRD-094', 1, 100, 1), -- Corbata

-- RNT-282: Fernando Apaza
('RNT-282', 'PRD-071', 1, 60, 1), -- Chaqueta Rosado
('RNT-282', 'PRD-073', 2, 240, 1), -- Pantalón Rosado
('RNT-282', 'PRD-090', 2, 600, 1), -- Minero

-- RNT-283: Mariana Cruz
('RNT-283', 'PRD-056', 2, 1800, 1), -- Chaqueta Plateado/Negro
('RNT-283', 'PRD-058', 1, 400, 1), -- Pantalón Plateado/Negro

-- RNT-284: Jorge Huanca
('RNT-284', 'PRD-066', 1, 600, 1), -- Chaqueta Café
('RNT-284', 'PRD-098', 1, 300, 1), -- Pollera Roja

-- RNT-285: Silvia Poma
('RNT-285', 'PRD-061', 2, 1200, 1), -- Chaqueta Celeste Bolívar
('RNT-285', 'PRD-095', 1, 100, 1), -- Corbata

-- RNT-286: Pedro Calle y Claudia Nina
('RNT-286', 'PRD-021', 3, 1200, 1), -- Chaqueta Blanco/Plateado
('RNT-286', 'PRD-023', 3, 600, 1), -- Pantalón Blanco/Plateado
('RNT-286', 'PRD-098', 1, 300, 1), -- Pollera

-- RNT-287: Alberto Mamani
('RNT-287', 'PRD-076', 2, 1200, 1), -- Chaqueta Azul/Celeste
('RNT-287', 'PRD-078', 2, 400, 1), -- Pantalón Azul/Celeste

-- RNT-288: Gloria Ticona y Raúl Limachi
('RNT-288', 'PRD-041', 2, 1200, 1), -- Chaqueta Guindo
('RNT-288', 'PRD-043', 2, 400, 1), -- Pantalón Guindo
('RNT-288', 'PRD-106', 1, 350, 1), -- Máscaras

-- RNT-289: Verónica Chura
('RNT-289', 'PRD-031', 2, 1200, 1), -- Chaqueta Tricolor
('RNT-289', 'PRD-033', 1, 200, 1), -- Pantalón Tricolor
('RNT-289', 'PRD-112', 1, 420, 1), -- Zapatos

-- RNT-290: Oscar Jaliri
('RNT-290', 'PRD-082', 1, 250, 1), -- Pepino
('RNT-290', 'PRD-091', 2, 400, 1), -- Chavo
('RNT-290', 'PRD-105', 1, 250, 1), -- Sombrero Negro

-- RNT-291: Mónica Quisbert y Julio Arce
('RNT-291', 'PRD-016', 3, 1500, 1), -- Chaqueta Negro/Verde
('RNT-291', 'PRD-018', 2, 400, 1), -- Pantalón Negro/Verde
('RNT-291', 'PRD-096', 1, 100, 1), -- Corbata Tricolor

-- RNT-292: Isabel Colque
('RNT-292', 'PRD-006', 2, 1200, 1), -- Chaqueta Azul/Crema

-- RNT-293: Andrés Tarqui
('RNT-293', 'PRD-083', 1, 250, 1), -- Pepino
('RNT-293', 'PRD-098', 2, 600, 1), -- Pollera
('RNT-293', 'PRD-097', 1, 100, 1), -- Corbata Morado

-- RNT-294: Lucía Alanoca y Carlos Yujra
('RNT-294', 'PRD-051', 2, 1200, 1), -- Chaqueta Dorado/Negro
('RNT-294', 'PRD-053', 2, 400, 1), -- Pantalón Dorado/Negro
('RNT-294', 'PRD-107', 2, 700, 1), -- Máscaras

-- RNT-295: Sandra Cutipa
('RNT-295', 'PRD-007', 2, 1000, 1), -- Chaquetilla Azul/Crema
('RNT-295', 'PRD-008', 2, 600, 1), -- Pantalón Azul/Crema

-- RNT-296: Ricardo Callisaya
('RNT-296', 'PRD-084', 1, 250, 1), -- Pepino
('RNT-296', 'PRD-092', 2, 400, 1), -- Chapulín
('RNT-296', 'PRD-108', 1, 350, 1), -- Máscaras
('RNT-296', 'PRD-095', 1, 100, 1), -- Corbata

-- RNT-297: Martha Condori y Gonzalo Mamani
('RNT-297', 'PRD-057', 1, 1000, 1), -- Chaquetilla Plateado/Negro
('RNT-297', 'PRD-058', 1, 400, 1), -- Pantalón Plateado/Negro
('RNT-297', 'PRD-109', 1, 350, 1), -- Máscaras

-- RNT-298: Alejandra Quispe y Víctor Choque
('RNT-298', 'PRD-011', 3, 1800, 1), -- Chaqueta Rojo/Dorado
('RNT-298', 'PRD-013', 2, 400, 1), -- Pantalón Rojo/Dorado

-- RNT-299: Beatriz Flores
('RNT-299', 'PRD-085', 1, 250, 1), -- Pepino
('RNT-299', 'PRD-093', 2, 600, 1), -- Saya
('RNT-299', 'PRD-112', 1, 420, 1), -- Zapatos

-- RNT-300: Héctor Silva
('RNT-300', 'PRD-042', 2, 1000, 1), -- Chaquetilla Guindo
('RNT-300', 'PRD-043', 3, 600, 1), -- Pantalón Guindo
('RNT-300', 'PRD-112', 1, 420, 1), -- Zapatos

-- RNT-301: Cristina López
('RNT-301', 'PRD-027', 2, 1000, 1), -- Chaquetilla Verde Whatsapp
('RNT-301', 'PRD-028', 2, 600, 1), -- Pantalón Verde Whatsapp

-- RNT-302: Manuel Vargas
('RNT-302', 'PRD-086', 1, 250, 1), -- Pepino
('RNT-302', 'PRD-098', 2, 600, 1), -- Pollera
('RNT-302', 'PRD-105', 1, 250, 1), -- Sombrero

-- RNT-303: Diana Morales y Rubén Apaza
('RNT-303', 'PRD-037', 2, 1400, 1), -- Chaquetilla Morado
('RNT-303', 'PRD-038', 1, 400, 1), -- Pantalón Morado
('RNT-303', 'PRD-112', 1, 420, 1), -- Zapatos

-- RNT-304: Carla Cruz
('RNT-304', 'PRD-032', 2, 1000, 1), -- Chaquetilla Tricolor
('RNT-304', 'PRD-033', 1, 200, 1), -- Pantalón Tricolor
('RNT-304', 'PRD-096', 1, 100, 1), -- Corbata

-- RNT-305: Esteban Huanca y Paola Poma
('RNT-305', 'PRD-022', 3, 900, 1), -- Chaquetilla Blanco/Plateado
('RNT-305', 'PRD-023', 3, 600, 1), -- Pantalón Blanco/Plateado
('RNT-305', 'PRD-110', 1, 350, 1), -- Máscaras
('RNT-305', 'PRD-094', 1, 100, 1), -- Corbata

-- RNT-306: Francisco Calle y Rosario Nina
('RNT-306', 'PRD-001', 3, 1800, 1), -- Chaqueta Rojo/Negro
('RNT-306', 'PRD-003', 1, 200, 1), -- Pantalón Rojo/Negro
('RNT-306', 'PRD-098', 1, 300, 1), -- Pollera

-- RNT-307: Diego Mamani
('RNT-307', 'PRD-062', 2, 1000, 1), -- Chaquetilla Celeste Bolívar
('RNT-307', 'PRD-063', 3, 600, 1), -- Pantalón Celeste Bolívar

-- RNT-308: Lorena Ticona
('RNT-308', 'PRD-077', 2, 1000, 1), -- Chaquetilla Azul/Celeste
('RNT-308', 'PRD-078', 1, 200, 1), -- Pantalón Azul/Celeste

-- RNT-309: Sergio Limachi y Gabriela Chura
('RNT-309', 'PRD-017', 3, 1200, 1), -- Chaquetilla Negro/Verde
('RNT-309', 'PRD-018', 2, 400, 1), -- Pantalón Negro/Verde
('RNT-309', 'PRD-106', 1, 350, 1), -- Máscaras

-- RNT-310: Eduardo Jaliri
('RNT-310', 'PRD-067', 2, 1000, 1), -- Chaquetilla Café
('RNT-310', 'PRD-068', 2, 400, 1), -- Pantalón Café

-- RNT-311: Natalia Quisbert
('RNT-311', 'PRD-087', 1, 250, 1), -- Pepino
('RNT-311', 'PRD-098', 2, 600, 1), -- Pollera
('RNT-311', 'PRD-104', 1, 250, 1); -- Sombrero

-- Inserts para tabla Garantia
INSERT INTO Garantia (RentaID, ClienteID, Tipo, Habilitado) VALUES 
-- Garantías RNT-276
('RNT-276', 'CLI-276', 'Cédula de Identidad', 1),
('RNT-276', 'CLI-276', 'Licencia de Conducir', 1),

-- Garantías RNT-277
('RNT-277', 'CLI-277', 'Cédula de Identidad', 1),
('RNT-277', 'CLI-278', 'Pasaporte', 1),
('RNT-277', 'CLI-278', 'Cédula de Identidad', 1),

-- Garantías RNT-278
('RNT-278', 'CLI-279', 'Licencia de Conducir', 1),

-- Garantías RNT-279
('RNT-279', 'CLI-280', 'Cédula de Identidad', 1),
('RNT-279', 'CLI-281', 'Licencia de Conducir', 1),
('RNT-279', 'CLI-281', 'Carnet Universitario', 1),

-- Garantías RNT-280
('RNT-280', 'CLI-282', 'Cédula de Identidad', 1),
('RNT-280', 'CLI-283', 'Licencia de Conducir', 1),
('RNT-280', 'CLI-283', 'Cédula de Identidad', 1),

-- Garantías RNT-281
('RNT-281', 'CLI-284', 'Pasaporte', 1),

-- Garantías RNT-282
('RNT-282', 'CLI-285', 'Cédula de Identidad', 1),

-- Garantías RNT-283
('RNT-283', 'CLI-286', 'Licencia de Conducir', 1),
('RNT-283', 'CLI-286', 'Cédula de Identidad', 1),

-- Garantías RNT-284
('RNT-284', 'CLI-287', 'Cédula de Identidad', 1),

-- Garantías RNT-285
('RNT-285', 'CLI-288', 'Licencia de Conducir', 1),

-- Garantías RNT-286
('RNT-286', 'CLI-289', 'Cédula de Identidad', 1),
('RNT-286', 'CLI-290', 'Pasaporte', 1),
('RNT-286', 'CLI-290', 'Cédula de Identidad', 1),

-- Garantías RNT-287
('RNT-287', 'CLI-291', 'Licencia de Conducir', 1),

-- Garantías RNT-288
('RNT-288', 'CLI-292', 'Cédula de Identidad', 1),
('RNT-288', 'CLI-293', 'Licencia de Conducir', 1),
('RNT-288', 'CLI-293', 'Carnet Universitario', 1),

-- Garantías RNT-289
('RNT-289', 'CLI-294', 'Cédula de Identidad', 1),
('RNT-289', 'CLI-294', 'Pasaporte', 1),

-- Garantías RNT-290
('RNT-290', 'CLI-295', 'Licencia de Conducir', 1),

-- Garantías RNT-291
('RNT-291', 'CLI-296', 'Cédula de Identidad', 1),
('RNT-291', 'CLI-297', 'Licencia de Conducir', 1),
('RNT-291', 'CLI-297', 'Cédula de Identidad', 1),

-- Garantías RNT-292
('RNT-292', 'CLI-298', 'Pasaporte', 1),

-- Garantías RNT-293
('RNT-293', 'CLI-299', 'Cédula de Identidad', 1),

-- Garantías RNT-294
('RNT-294', 'CLI-300', 'Licencia de Conducir', 1),
('RNT-294', 'CLI-301', 'Cédula de Identidad', 1),
('RNT-294', 'CLI-301', 'Carnet Universitario', 1),

-- Garantías RNT-295
('RNT-295', 'CLI-302', 'Cédula de Identidad', 1),

-- Garantías RNT-296
('RNT-296', 'CLI-303', 'Licencia de Conducir', 1),
('RNT-296', 'CLI-303', 'Cédula de Identidad', 1),

-- Garantías RNT-297
('RNT-297', 'CLI-304', 'Pasaporte', 1),
('RNT-297', 'CLI-305', 'Cédula de Identidad', 1),

-- Garantías RNT-298
('RNT-298', 'CLI-306', 'Licencia de Conducir', 1),
('RNT-298', 'CLI-307', 'Cédula de Identidad', 1),
('RNT-298', 'CLI-307', 'Carnet Universitario', 1),

-- Garantías RNT-299
('RNT-299', 'CLI-308', 'Cédula de Identidad', 1),

-- Garantías RNT-300
('RNT-300', 'CLI-309', 'Licencia de Conducir', 1),
('RNT-300', 'CLI-309', 'Cédula de Identidad', 1),

-- Garantías RNT-301
('RNT-301', 'CLI-310', 'Pasaporte', 1),

-- Garantías RNT-302
('RNT-302', 'CLI-311', 'Cédula de Identidad', 1),

-- Garantías RNT-303
('RNT-303', 'CLI-312', 'Licencia de Conducir', 1),
('RNT-303', 'CLI-313', 'Cédula de Identidad', 1),
('RNT-303', 'CLI-313', 'Carnet Universitario', 1),

-- Garantías RNT-304
('RNT-304', 'CLI-314', 'Cédula de Identidad', 1),

-- Garantías RNT-305
('RNT-305', 'CLI-315', 'Licencia de Conducir', 1),
('RNT-305', 'CLI-316', 'Pasaporte', 1),
('RNT-305', 'CLI-316', 'Cédula de Identidad', 1),

-- Garantías RNT-306
('RNT-306', 'CLI-317', 'Cédula de Identidad', 1),
('RNT-306', 'CLI-318', 'Licencia de Conducir', 1),
('RNT-306', 'CLI-318', 'Carnet Universitario', 1),

-- Garantías RNT-307
('RNT-307', 'CLI-319', 'Cédula de Identidad', 1),

-- Garantías RNT-308
('RNT-308', 'CLI-320', 'Licencia de Conducir', 1),

-- Garantías RNT-309
('RNT-309', 'CLI-321', 'Pasaporte', 1),
('RNT-309', 'CLI-322', 'Cédula de Identidad', 1),
('RNT-309', 'CLI-322', 'Licencia de Conducir', 1),

-- Garantías RNT-310
('RNT-310', 'CLI-323', 'Cédula de Identidad', 1),

-- Garantías RNT-311
('RNT-311', 'CLI-324', 'Licencia de Conducir', 1),
('RNT-311', 'CLI-324', 'Cédula de Identidad', 1);

-- Inserts para tabla Renta (Febrero y principios de Marzo 2025)
INSERT INTO Renta (RentaID, EmpleadoID, FechaRenta, FechaDevolucion, FechaDevuelto, Descuento, Total, Multa) VALUES
-- Febrero 2025
('RNT-312', 'MGR-001', '2025-02-03', '2025-02-08', '2025-02-08', 0, 1500, 0),
('RNT-313', 'MGR-002', '2025-02-03', '2025-02-10', '2025-02-11', 0, 800, 25),
('RNT-314', 'MGR-001', '2025-02-04', '2025-02-09', '2025-02-09', 5, 1200, 0),
('RNT-315', 'MGR-002', '2025-02-04', '2025-02-11', '2025-02-11', 0, 950, 0),
('RNT-316', 'MGR-001', '2025-02-05', '2025-02-12', '2025-02-12', 10, 700, 0),
('RNT-317', 'MGR-002', '2025-02-05', '2025-02-10', '2025-02-10', 0, 1100, 0),
('RNT-318', 'MGR-001', '2025-02-06', '2025-02-13', '2025-02-14', 0, 1350, 30),
('RNT-319', 'MGR-002', '2025-02-06', '2025-02-11', '2025-02-11', 0, 600, 0),
('RNT-320', 'MGR-001', '2025-02-07', '2025-02-14', '2025-02-14', 15, 900, 0),
('RNT-321', 'MGR-002', '2025-02-07', '2025-02-12', '2025-02-12', 0, 1250, 0),
('RNT-322', 'MGR-001', '2025-02-10', '2025-02-17', '2025-02-17', 0, 800, 0),
('RNT-323', 'MGR-002', '2025-02-10', '2025-02-15', '2025-02-15', 0, 1400, 0),
('RNT-324', 'MGR-001', '2025-02-11', '2025-02-18', '2025-02-18', 5, 650, 0),
('RNT-325', 'MGR-002', '2025-02-11', '2025-02-16', '2025-02-17', 0, 1050, 20);

-- Inserts para tabla Cliente
INSERT INTO Cliente (ClienteID, RentaID, Nombre, Apellido, Telefono, Garantia, Habilitado) VALUES
-- Febrero 2025
('CLI-325', 'RNT-312', 'Ana Lucia', 'Mamani', 78456123, 1, 1),
('CLI-326', 'RNT-312', 'Pedro', 'Choque', 76123456, 1, 1),
('CLI-327', 'RNT-313', 'Rosa María', 'Ticona', 77889945, 1, 1),
('CLI-328', 'RNT-314', 'Miguel Angel', 'Condori', 76543210, 1, 1),
('CLI-329', 'RNT-315', 'Carmen', 'Huanca', 78965412, 1, 1),
('CLI-330', 'RNT-315', 'Jorge Luis', 'Apaza', 77456789, 1, 1),
('CLI-331', 'RNT-316', 'Silvia', 'Marca', 76234567, 1, 1),
('CLI-332', 'RNT-317', 'Roberto', 'Churata', 78123456, 1, 1),
('CLI-333', 'RNT-317', 'Elena', 'Poma', 77654321, 1, 1),
('CLI-334', 'RNT-318', 'Fernando', 'Callisaya', 76987654, 1, 1),
('CLI-335', 'RNT-319', 'Gloria', 'Nina', 78321654, 1, 1),
('CLI-336', 'RNT-320', 'Daniel', 'Chuquimia', 77159753, 1, 1),
('CLI-337', 'RNT-321', 'Patricia', 'Flores', 76852741, 1, 1),
('CLI-338', 'RNT-321', 'Andrés', 'Vargas', 78963258, 1, 1),
('CLI-339', 'RNT-322', 'Mónica', 'Torrez', 77741852, 1, 1),
('CLI-340', 'RNT-323', 'Oscar', 'Limachi', 76369258, 1, 1),
('CLI-341', 'RNT-323', 'Verónica', 'Siles', 78147963, 1, 1),
('CLI-342', 'RNT-324', 'Luis Carlos', 'Patana', 77258963, 1, 1),
('CLI-343', 'RNT-325', 'Beatriz', 'Calle', 76951847, 1, 1);

-- Inserts para tabla DetalleRenta
INSERT INTO DetalleRenta (RentaID, ProductoID, Cantidad, Subtotal, Habilitado) VALUES
-- RNT-312: Ana Lucia Mamani y Pedro Choque
('RNT-312', 'PRD-001', 2, 1200, 1), -- Chaqueta Rojo/Negro
('RNT-312', 'PRD-003', 1, 200, 1),  -- Pantalón Rojo/Negro
('RNT-312', 'PRD-004', 1, 100, 1),  -- Faja Rojo/Negro

-- RNT-313: Rosa María Ticona
('RNT-313', 'PRD-081', 1, 250, 1),  -- Pepino
('RNT-313', 'PRD-098', 1, 300, 1),  -- Pollera Roja
('RNT-313', 'PRD-104', 1, 250, 1),  -- Sombrero

-- RNT-314: Miguel Angel Condori
('RNT-314', 'PRD-036', 2, 1200, 1), -- Chaqueta Morada

-- RNT-315: Carmen Huanca y Jorge Luis Apaza
('RNT-315', 'PRD-021', 1, 400, 1),  -- Chaqueta Blanco/Plateado
('RNT-315', 'PRD-023', 1, 200, 1),  -- Pantalón Blanco/Plateado
('RNT-315', 'PRD-112', 1, 420, 1),  -- Zapatos

-- RNT-316: Silvia Marca
('RNT-316', 'PRD-090', 1, 300, 1),  -- Minero
('RNT-316', 'PRD-091', 2, 400, 1),  -- Chavo

-- RNT-317: Roberto Churata y Elena Poma
('RNT-317', 'PRD-026', 1, 600, 1),  -- Chaqueta Verde Whatsapp
('RNT-317', 'PRD-028', 1, 300, 1),  -- Pantalón Verde Whatsapp
('RNT-317', 'PRD-029', 2, 200, 1),  -- Faja Verde Whatsapp

-- RNT-318: Fernando Callisaya
('RNT-318', 'PRD-056', 2, 1800, 1), -- Chaqueta Plateado/Negro

-- RNT-319: Gloria Nina
('RNT-319', 'PRD-031', 1, 600, 1),  -- Chaqueta Tricolor

-- RNT-320: Daniel Chuquimia
('RNT-320', 'PRD-081', 1, 250, 1),  -- Pepino
('RNT-320', 'PRD-099', 2, 600, 1),  -- Pollera Azul

-- RNT-321: Patricia Flores y Andrés Vargas
('RNT-321', 'PRD-041', 2, 1200, 1), -- Chaqueta Guindo
('RNT-321', 'PRD-043', 1, 200, 1),  -- Pantalón Guindo

-- RNT-322: Mónica Torrez
('RNT-322', 'PRD-093', 1, 200, 1),  -- Chapulin
('RNT-322', 'PRD-101', 2, 600, 1),  -- Pollera Blanca

-- RNT-323: Oscar Limachi y Verónica Siles
('RNT-323', 'PRD-061', 2, 1200, 1), -- Chaqueta Celeste Bolivar
('RNT-323', 'PRD-063', 1, 200, 1),  -- Pantalón Celeste Bolivar

-- RNT-324: Luis Carlos Patana
('RNT-324', 'PRD-082', 1, 250, 1),  -- Pepino
('RNT-324', 'PRD-104', 1, 250, 1),  -- Sombrero
('RNT-324', 'PRD-106', 1, 350, 1),  -- Mascara

-- RNT-325: Beatriz Calle
('RNT-325', 'PRD-066', 1, 600, 1),  -- Chaqueta Café
('RNT-325', 'PRD-068', 2, 400, 1);

-- Inserts para tabla Garantia
INSERT INTO Garantia (RentaID, ClienteID, Tipo, Habilitado) VALUES
-- Febrero 2025
('RNT-312', 'CLI-325', 'Cédula de Identidad', 1),
('RNT-312', 'CLI-326', 'Licencia de Conducir', 1),
('RNT-313', 'CLI-327', 'Cédula de Identidad', 1),
('RNT-313', 'CLI-327', 'Carnet de Estudiante', 1),
('RNT-314', 'CLI-328', 'Licencia de Conducir', 1),
('RNT-315', 'CLI-329', 'Cédula de Identidad', 1),
('RNT-315', 'CLI-330', 'Cédula de Identidad', 1),
('RNT-315', 'CLI-330', 'Carnet de Trabajo', 1),
('RNT-316', 'CLI-331', 'Licencia de Conducir', 1),
('RNT-317', 'CLI-332', 'Cédula de Identidad', 1),
('RNT-317', 'CLI-333', 'Cédula de Identidad', 1),
('RNT-318', 'CLI-334', 'Licencia de Conducir', 1),
('RNT-318', 'CLI-334', 'Carnet de Estudiante', 1),
('RNT-319', 'CLI-335', 'Cédula de Identidad', 1),
('RNT-320', 'CLI-336', 'Licencia de Conducir', 1),
('RNT-321', 'CLI-337', 'Cédula de Identidad', 1),
('RNT-321', 'CLI-338', 'Cédula de Identidad', 1),
('RNT-321', 'CLI-338', 'Carnet de Trabajo', 1),
('RNT-322', 'CLI-339', 'Licencia de Conducir', 1),
('RNT-323', 'CLI-340', 'Cédula de Identidad', 1),
('RNT-323', 'CLI-341', 'Cédula de Identidad', 1),
('RNT-324', 'CLI-342', 'Licencia de Conducir', 1),
('RNT-324', 'CLI-342', 'Carnet de Estudiante', 1),
('RNT-325', 'CLI-343', 'Cédula de Identidad', 1);

-- ===== RENTAS MAYO 2025 =====
-- Inserts para tabla Renta
INSERT INTO Renta (RentaID, EmpleadoID, FechaRenta, FechaDevolucion, FechaDevuelto, Descuento, Total, Multa) VALUES
-- Día 1 Mayo (Jueves)
('RNT-326', 'MGR-001', '2025-05-01', '2025-05-06', '2025-05-06', 0, 1500, 0),
('RNT-327', 'MGR-002', '2025-05-01', '2025-05-04', '2025-05-04', 5, 950, 0),

-- Día 2 Mayo (Viernes)
('RNT-328', 'MGR-001', '2025-05-02', '2025-05-07', '2025-05-07', 0, 1800, 0),
('RNT-329', 'MGR-003', '2025-05-02', '2025-05-05', '2025-05-06', 0, 800, 25),

-- Día 5 Mayo (Lunes)
('RNT-330', 'MGR-002', '2025-05-05', '2025-05-10', '2025-05-10', 10, 1350, 0),
('RNT-331', 'MGR-001', '2025-05-05', '2025-05-08', '2025-05-08', 0, 700, 0),
('RNT-332', 'MGR-003', '2025-05-05', '2025-05-09', '2025-05-09', 0, 1200, 0),

-- Día 6 Mayo (Martes)
('RNT-333', 'MGR-001', '2025-05-06', '2025-05-11', '2025-05-11', 0, 2200, 0),

-- Día 7 Mayo (Miércoles)
('RNT-334', 'MGR-002', '2025-05-07', '2025-05-12', '2025-05-12', 0, 1600, 0),
('RNT-335', 'MGR-003', '2025-05-07', '2025-05-10', '2025-05-11', 0, 950, 15),

-- Día 8 Mayo (Jueves)
('RNT-336', 'MGR-001', '2025-05-08', '2025-05-13', '2025-05-13', 5, 1425, 0),
('RNT-337', 'MGR-002', '2025-05-08', '2025-05-11', '2025-05-11', 0, 800, 0),

-- Día 9 Mayo (Viernes)
('RNT-338', 'MGR-003', '2025-05-09', '2025-05-14', '2025-05-14', 0, 1900, 0),

-- Día 12 Mayo (Lunes)
('RNT-339', 'MGR-001', '2025-05-12', '2025-05-17', '2025-05-17', 0, 1100, 0),
('RNT-340', 'MGR-002', '2025-05-12', '2025-05-15', '2025-05-15', 0, 750, 0),
('RNT-341', 'MGR-003', '2025-05-12', '2025-05-16', '2025-05-16', 15, 1275, 0),

-- Día 13 Mayo (Martes)
('RNT-342', 'MGR-001', '2025-05-13', '2025-05-18', '2025-05-18', 0, 2100, 0),
('RNT-343', 'MGR-002', '2025-05-13', '2025-05-16', '2025-05-17', 0, 600, 20),

-- Día 14 Mayo (Miércoles)
('RNT-344', 'MGR-003', '2025-05-14', '2025-05-19', '2025-05-19', 0, 1800, 0),

-- Día 15 Mayo (Jueves)
('RNT-345', 'MGR-001', '2025-05-15', '2025-05-20', '2025-05-20', 10, 1440, 0),
('RNT-346', 'MGR-002', '2025-05-15', '2025-05-18', '2025-05-18', 0, 900, 0),
('RNT-347', 'MGR-003', '2025-05-15', '2025-05-19', '2025-05-19', 0, 1300, 0),

-- Día 16 Mayo (Viernes)
('RNT-348', 'MGR-001', '2025-05-16', '2025-05-21', '2025-05-21', 0, 1700, 0),

-- Día 19 Mayo (Lunes)
('RNT-349', 'MGR-002', '2025-05-19', '2025-05-24', '2025-05-24', 0, 2000, 0),
('RNT-350', 'MGR-003', '2025-05-19', '2025-05-22', '2025-05-22', 5, 1425, 0),

-- Día 20 Mayo (Martes)
('RNT-351', 'MGR-001', '2025-05-20', '2025-05-25', '2025-05-25', 0, 850, 0),
('RNT-352', 'MGR-002', '2025-05-20', '2025-05-23', '2025-05-24', 0, 1200, 10),

-- Día 21 Mayo (Miércoles)
('RNT-353', 'MGR-003', '2025-05-21', '2025-05-26', '2025-05-26', 0, 1600, 0),
('RNT-354', 'MGR-001', '2025-05-21', '2025-05-24', '2025-05-24', 0, 700, 0),

-- Día 22 Mayo (Jueves)
('RNT-355', 'MGR-002', '2025-05-22', '2025-05-27', '2025-05-27', 0, 1900, 0),

-- Día 23 Mayo (Viernes)
('RNT-356', 'MGR-003', '2025-05-23', '2025-05-28', '2025-05-28', 10, 1350, 0),
('RNT-357', 'MGR-001', '2025-05-23', '2025-05-26', '2025-05-26', 0, 950, 0),

-- Día 26 Mayo (Lunes)
('RNT-358', 'MGR-002', '2025-05-26', '2025-05-31', '2025-05-31', 0, 2300, 0),
('RNT-359', 'MGR-003', '2025-05-26', '2025-05-29', '2025-05-29', 0, 800, 0),

-- Día 27 Mayo (Martes)
('RNT-360', 'MGR-001', '2025-05-27', '2025-06-01', '2025-06-01', 5, 1425, 0),
('RNT-361', 'MGR-002', '2025-05-27', '2025-05-30', '2025-05-30', 0, 1100, 0),

-- Día 28 Mayo (Miércoles)
('RNT-362', 'MGR-003', '2025-05-28', '2025-06-02', '2025-06-02', 0, 1800, 0),

-- Día 29 Mayo (Jueves)
('RNT-363', 'MGR-001', '2025-05-29', '2025-06-03', '2025-06-03', 0, 1500, 0),
('RNT-364', 'MGR-002', '2025-05-29', '2025-06-01', '2025-06-02', 0, 900, 15),

-- Día 30 Mayo (Viernes)
('RNT-365', 'MGR-003', '2025-05-30', '2025-06-04', NULL, 0, 2100, 0),
('RNT-366', 'MGR-001', '2025-05-30', '2025-06-02', NULL, 0, 750, 0);

-- ===== CLIENTES =====
INSERT INTO Cliente (ClienteID, RentaID, Nombre, Apellido, Telefono, Garantia, Habilitado) VALUES
-- RNT-326 (2 clientes)
('CLI-344', 'RNT-326', 'Ana María', 'López', 78965432, 1, 1),
('CLI-345', 'RNT-326', 'Pedro', 'García', 76543218, 1, 1),

-- RNT-327 (1 cliente)
('CLI-346', 'RNT-327', 'Sofía', 'Martínez', 79234567, 1, 1),

-- RNT-328 (1 cliente)
('CLI-347', 'RNT-328', 'Miguel', 'Fernández', 76789012, 1, 1),

-- RNT-329 (2 clientes)
('CLI-348', 'RNT-329', 'Carmen', 'Silva', 78123456, 1, 1),
('CLI-349', 'RNT-329', 'Roberto', 'Vega', 79876543, 1, 1),

-- RNT-330 (1 cliente)
('CLI-350', 'RNT-330', 'Lucía', 'Morales', 76456789, 1, 1),

-- RNT-331 (1 cliente)
('CLI-351', 'RNT-331', 'Diego', 'Herrera', 78654321, 1, 1),

-- RNT-332 (2 clientes)
('CLI-352', 'RNT-332', 'Patricia', 'Ruiz', 79345678, 1, 1),
('CLI-353', 'RNT-332', 'Andrés', 'Castillo', 76234567, 1, 1),

-- RNT-333 (1 cliente)
('CLI-354', 'RNT-333', 'Valentina', 'Jiménez', 78987654, 1, 1),

-- RNT-334 (2 clientes)
('CLI-355', 'RNT-334', 'Fernando', 'Torres', 79567890, 1, 1),
('CLI-356', 'RNT-334', 'Isabella', 'Ramírez', 76890123, 1, 1),

-- RNT-335 (1 cliente)
('CLI-357', 'RNT-335', 'Javier', 'Mendoza', 78234567, 1, 1),

-- RNT-336 (1 cliente)
('CLI-358', 'RNT-336', 'Camila', 'Guerrero', 79678901, 1, 1),

-- RNT-337 (2 clientes)
('CLI-359', 'RNT-337', 'Sebastián', 'Peña', 76567890, 1, 1),
('CLI-360', 'RNT-337', 'Gabriela', 'Ortiz', 78345678, 1, 1),

-- RNT-338 (1 cliente)
('CLI-361', 'RNT-338', 'Mateo', 'Vargas', 79123456, 1, 1),

-- RNT-339 (2 clientes)
('CLI-362', 'RNT-339', 'Natalia', 'Cruz', 76678901, 1, 1),
('CLI-363', 'RNT-339', 'Alejandro', 'Sánchez', 78456789, 1, 1),

-- RNT-340 (1 cliente)
('CLI-364', 'RNT-340', 'Daniela', 'Flores', 79234568, 1, 1),

-- RNT-341 (1 cliente)
('CLI-365', 'RNT-341', 'Nicolás', 'Molina', 76789013, 1, 1),

-- RNT-342 (2 clientes)
('CLI-366', 'RNT-342', 'Valeria', 'Paredes', 78567890, 1, 1),
('CLI-367', 'RNT-342', 'Emilio', 'Aguilar', 79345679, 1, 1),

-- RNT-343 (1 cliente)
('CLI-368', 'RNT-343', 'Regina', 'Delgado', 76456790, 1, 1),

-- RNT-344 (1 cliente)
('CLI-369', 'RNT-344', 'Adrián', 'Medina', 78678902, 1, 1),

-- RNT-345 (2 clientes)
('CLI-370', 'RNT-345', 'Paola', 'Reyes', 79456789, 1, 1),
('CLI-371', 'RNT-345', 'Ricardo', 'Cortés', 76234568, 1, 1),

-- RNT-346 (1 cliente)
('CLI-372', 'RNT-346', 'Martina', 'Espinoza', 78789012, 1, 1),

-- RNT-347 (1 cliente)
('CLI-373', 'RNT-347', 'Joaquín', 'Romero', 79567891, 1, 1),

-- RNT-348 (2 clientes)
('CLI-374', 'RNT-348', 'Renata', 'Navarro', 76345679, 1, 1),
('CLI-375', 'RNT-348', 'Esteban', 'Campos', 78890123, 1, 1),

-- RNT-349 (1 cliente)
('CLI-376', 'RNT-349', 'Constanza', 'Ramos', 79678902, 1, 1),

-- RNT-350 (1 cliente)
('CLI-377', 'RNT-350', 'Bruno', 'Lara', 76456791, 1, 1),

-- RNT-351 (2 clientes)
('CLI-378', 'RNT-351', 'Alejandra', 'Ibáñez', 78567891, 1, 1),
('CLI-379', 'RNT-351', 'Tomás', 'Vila', 79234569, 1, 1),

-- RNT-352 (1 cliente)
('CLI-380', 'RNT-352', 'Antonella', 'Cabrera', 76678902, 1, 1),

-- RNT-353 (1 cliente)
('CLI-381', 'RNT-353', 'Leonardo', 'Ponce', 78345679, 1, 1),

-- RNT-354 (2 clientes)
('CLI-382', 'RNT-354', 'Florencia', 'Arias', 79456790, 1, 1),
('CLI-383', 'RNT-354', 'Maximiliano', 'Vera', 76567891, 1, 1),

-- RNT-355 (1 cliente)
('CLI-384', 'RNT-355', 'Rocío', 'Pereira', 78789013, 1, 1),

-- RNT-356 (1 cliente)
('CLI-385', 'RNT-356', 'Ignacio', 'Miranda', 79123457, 1, 1),

-- RNT-357 (2 clientes)
('CLI-386', 'RNT-357', 'Catalina', 'Figueroa', 76890124, 1, 1),
('CLI-387', 'RNT-357', 'Santiago', 'Cárdenas', 78234568, 1, 1),

-- RNT-358 (1 cliente)
('CLI-388', 'RNT-358', 'Francisca', 'Rojas', 79567892, 1, 1),

-- RNT-359 (2 clientes)
('CLI-389', 'RNT-359', 'Benjamín', 'Muñoz', 76345680, 1, 1),
('CLI-390', 'RNT-359', 'Esperanza', 'Bravo', 78456790, 1, 1),

-- RNT-360 (1 cliente)
('CLI-391', 'RNT-360', 'Gonzalo', 'Sandoval', 79678903, 1, 1),

-- RNT-361 (1 cliente)
('CLI-392', 'RNT-361', 'Amparo', 'Gallardo', 76789014, 1, 1),

-- RNT-362 (2 clientes)
('CLI-393', 'RNT-362', 'Cristóbal', 'Parra', 78567892, 1, 1),
('CLI-394', 'RNT-362', 'Macarena', 'Soto', 79345680, 1, 1),

-- RNT-363 (1 cliente)
('CLI-395', 'RNT-363', 'Vicente', 'Bustamante', 76456792, 1, 1),

-- RNT-364 (2 clientes)
('CLI-396', 'RNT-364', 'Javiera', 'Maldonado', 78678903, 1, 1),
('CLI-397', 'RNT-364', 'Agustín', 'Tapia', 79456791, 1, 1),

-- RNT-365 (1 cliente - renta activa)
('CLI-398', 'RNT-365', 'Isidora', 'Contreras', 76234569, 1, 1),

-- RNT-366 (1 cliente - renta activa)
('CLI-399', 'RNT-366', 'Maximiliano', 'Fuentes', 78890124, 1, 1);

-- ===== DETALLES DE RENTA =====
INSERT INTO DetalleRenta (RentaID, ProductoID, Cantidad, Subtotal, Habilitado) VALUES
-- RNT-326: Ana María López + Pedro García
('RNT-326', 'PRD-001', 2, 1200, 1), -- Chaqueta Rojo/Negro
('RNT-326', 'PRD-004', 3, 300, 1), -- Faja Rojo/Negro

-- RNT-327: Sofía Martínez
('RNT-327', 'PRD-026', 1, 600, 1), -- Chaqueta Verde Whatsapp
('RNT-327', 'PRD-098', 1, 300, 1), -- Pollera Roja
('RNT-327', 'PRD-094', 1, 100, 1), -- Corbata Rojo/Negro

-- RNT-328: Miguel Fernández
('RNT-328', 'PRD-051', 3, 1800, 1), -- Chaqueta Dorado/Negro

-- RNT-329: Carmen Silva + Roberto Vega
('RNT-329', 'PRD-081', 2, 500, 1), -- Pepino Verde/Blanco
('RNT-329', 'PRD-104', 1, 250, 1), -- Sombrero Blanco
('RNT-329', 'PRD-094', 1, 100, 1), -- Corbata

-- RNT-330: Lucía Morales
('RNT-330', 'PRD-036', 2, 1200, 1), -- Chaqueta Morada
('RNT-330', 'PRD-038', 1, 400, 1), -- Pantalón Morado

-- RNT-331: Diego Herrera
('RNT-331', 'PRD-098', 2, 600, 1), -- Pollera Roja
('RNT-331', 'PRD-096', 1, 100, 1), -- Corbata Tricolor

-- RNT-332: Patricia Ruiz + Andrés Castillo
('RNT-332', 'PRD-021', 2, 800, 1), -- Chaqueta Blanco/Plateado
('RNT-332', 'PRD-023', 2, 400, 1), -- Pantalón Blanco/Plateado

-- RNT-333: Valentina Jiménez
('RNT-333', 'PRD-056', 2, 1800, 1), -- Chaqueta Plateado/Negro
('RNT-333', 'PRD-058', 2, 800, 1), -- Pantalón Plateado/Negro

-- RNT-334: Fernando Torres + Isabella Ramírez
('RNT-334', 'PRD-076', 2, 1200, 1), -- Chaqueta Azul/Celeste
('RNT-334', 'PRD-078', 2, 400, 1), -- Pantalón Azul/Celeste

-- RNT-335: Javier Mendoza
('RNT-335', 'PRD-081', 3, 750, 1), -- Pepino
('RNT-335', 'PRD-106', 1, 350, 1), -- Máscara

-- RNT-336: Camila Guerrero
('RNT-336', 'PRD-031', 2, 1200, 1), -- Chaqueta Tricolor
('RNT-336', 'PRD-033', 1, 200, 1), -- Pantalón Tricolor
('RNT-336', 'PRD-096', 1, 100, 1), -- Corbata Tricolor

-- RNT-337: Sebastián Peña + Gabriela Ortiz
('RNT-337', 'PRD-099', 2, 600, 1), -- Pollera Azul
('RNT-337', 'PRD-105', 1, 250, 1), -- Sombrero Negro

-- RNT-338: Mateo Vargas
('RNT-338', 'PRD-061', 3, 1800, 1), -- Chaqueta Celeste Bolívar
('RNT-338', 'PRD-065', 1, 100, 1), -- Chuspa Celeste Bolívar

-- RNT-339: Natalia Cruz + Alejandro Sánchez
('RNT-339', 'PRD-066', 1, 600, 1), -- Chaqueta Café
('RNT-339', 'PRD-082', 2, 500, 1), -- Pepino Dorado/Azul

-- RNT-340: Daniela Flores
('RNT-340', 'PRD-100', 2, 600, 1), -- Pollera Negra
('RNT-340', 'PRD-097', 1, 100, 1), -- Corbata Morada
('RNT-340', 'PRD-094', 1, 100, 1), -- Corbata Rojo/Negro

-- RNT-341: Nicolás Molina
('RNT-341', 'PRD-071', 2, 120, 1), -- Chaqueta Rosada
('RNT-341', 'PRD-073', 1, 120, 1), -- Pantalón Rosado
('RNT-341', 'PRD-081', 4, 1000, 1), -- Pepino

-- RNT-342: Valeria Paredes + Emilio Aguilar
('RNT-342', 'PRD-016', 3, 1500, 1), -- Chaqueta Negro/Verde
('RNT-342', 'PRD-018', 3, 600, 1), -- Pantalón Negro/Verde

-- RNT-343: Regina Delgado
('RNT-343', 'PRD-102', 2, 600, 1), -- Pollera Verde

-- RNT-344: Adrián Medina
('RNT-344', 'PRD-011', 3, 1800, 1), -- Chaqueta Rojo/Dorado

-- RNT-345: Paola Reyes + Ricardo Cortés
('RNT-345', 'PRD-046', 2, 1200, 1), -- Chaqueta Verde Pacai
('RNT-345', 'PRD-048', 1, 200, 1), -- Pantalón Verde Pacai
('RNT-345', 'PRD-107', 1, 350, 1), -- Máscara

-- RNT-346: Martina Espinoza
('RNT-346', 'PRD-083', 3, 750, 1), -- Pepino Rojo/Dorado
('RNT-346', 'PRD-097', 1, 100, 1), -- Corbata Morada
('RNT-346', 'PRD-094', 1, 100, 1), -- Corbata

-- RNT-347: Joaquín Romero
('RNT-347', 'PRD-067', 2, 1000, 1), -- Chaquetilla Café
('RNT-347', 'PRD-068', 1, 200, 1), -- Pantalón Café
('RNT-347', 'PRD-096', 1, 100, 1), -- Corbata Tricolor

-- RNT-348: Renata Navarro + Esteban Campos
('RNT-348', 'PRD-006', 2, 1200, 1), -- Chaqueta Azul/Crema
('RNT-348', 'PRD-008', 2, 600, 1), -- Pantalón Azul/Crema

-- RNT-349: Constanza Ramos
('RNT-349', 'PRD-031', 3, 1800, 1), -- Chaqueta Tricolor
('RNT-349', 'PRD-106', 1, 350, 1), -- Máscara

-- RNT-350: Bruno Lara
('RNT-350', 'PRD-057', 1, 1000, 1), -- Chaquetilla Plateado/Negro
('RNT-350', 'PRD-084', 1, 250, 1), -- Pepino Negro/Amarillo
('RNT-350', 'PRD-108', 1, 350, 1), -- Máscara

-- RNT-351: Alejandra Ibáñez + Tomás Vila
('RNT-351', 'PRD-101', 2, 600, 1), -- Pollera Blanca
('RNT-351', 'PRD-105', 1, 250, 1), -- Sombrero Negro

-- RNT-352: Antonella Cabrera
('RNT-352', 'PRD-041', 2, 1200, 1), -- Chaqueta Guindo

-- RNT-353: Leonardo Ponce
('RNT-353', 'PRD-076', 2, 1200, 1), -- Chaqueta Azul/Celeste
('RNT-353', 'PRD-078', 2, 400, 1), -- Pantalón Azul/Celeste

-- RNT-354: Florencia Arias + Maximiliano Vera
('RNT-354', 'PRD-085', 2, 500, 1), -- Pepino Verde/Amarillo
('RNT-354', 'PRD-106', 1, 350, 1), -- Máscara

-- RNT-355: Rocío Pereira
('RNT-355', 'PRD-036', 3, 1800, 1), -- Chaqueta Morada
('RNT-355', 'PRD-096', 1, 100, 1), -- Corbata Tricolor

-- RNT-356: Ignacio Miranda
('RNT-356', 'PRD-051', 2, 1200, 1), -- Chaqueta Dorado/Negro
('RNT-356', 'PRD-053', 1, 200, 1), -- Pantalón Dorado/Negro

-- RNT-357: Catalina Figueroa + Santiago Cárdenas
('RNT-357', 'PRD-086', 3, 750, 1), -- Pepino Azul/Rojo
('RNT-357', 'PRD-109', 1, 350, 1), -- Máscara

-- RNT-358: Francisca Rojas
('RNT-358', 'PRD-056', 2, 1800, 1), -- Chaqueta Plateado/Negro
('RNT-358', 'PRD-058', 1, 400, 1), -- Pantalón Plateado/Negro
('RNT-358', 'PRD-096', 1, 100, 1), -- Corbata Tricolor

-- RNT-359: Benjamín Muñoz + Esperanza Bravo
('RNT-359', 'PRD-087', 2, 500, 1), -- Pepino Rosado/Blanco
('RNT-359', 'PRD-103', 1, 300, 1), -- Pollera Morada

-- RNT-360: Gonzalo Sandoval
('RNT-360', 'PRD-021', 2, 800, 1), -- Chaqueta Blanco/Plateado
('RNT-360', 'PRD-023', 3, 600, 1), -- Pantalón Blanco/Plateado
('RNT-360', 'PRD-095', 1, 100, 1), -- Corbata Azul/Crema

-- RNT-361: Amparo Gallardo
('RNT-361', 'PRD-088', 4, 1000, 1), -- Pepino Morado/Blanco
('RNT-361', 'PRD-096', 1, 100, 1), -- Corbata Tricolor

-- RNT-362: Cristóbal Parra + Macarena Soto
('RNT-362', 'PRD-031', 3, 1800, 1), -- Chaqueta Tricolor

-- RNT-363: Vicente Bustamante
('RNT-363', 'PRD-026', 2, 1200, 1), -- Chaqueta Verde Whatsapp
('RNT-363', 'PRD-028', 1, 300, 1), -- Pantalón Verde Whatsapp

-- RNT-364: Javiera Maldonado + Agustín Tapia
('RNT-364', 'PRD-089', 3, 750, 1), -- Pepino Celeste/Blanco
('RNT-364', 'PRD-110', 1, 350, 1), -- Máscara

-- RNT-365: Isidora Contreras (renta activa)
('RNT-365', 'PRD-061', 3, 1800, 1), -- Chaqueta Celeste Bolívar
('RNT-365', 'PRD-063', 1, 200, 1), -- Pantalón Celeste Bolívar
('RNT-365', 'PRD-096', 1, 100, 1), -- Corbata Tricolor

-- RNT-366: Maximiliano Fuentes (renta activa)
('RNT-366', 'PRD-098', 2, 600, 1), -- Pollera Roja
('RNT-366', 'PRD-104', 1, 250, 1); -- Sombrero Blanco

-- ===== GARANTÍAS =====
INSERT INTO Garantia (RentaID, ClienteID, Tipo, Habilitado) VALUES
-- RNT-326
('RNT-326', 'CLI-344', 'Cédula de Identidad', 1),
('RNT-326', 'CLI-345', 'Licencia de Conducir', 1),

-- RNT-327
('RNT-327', 'CLI-346', 'Cédula de Identidad', 1),

-- RNT-328
('RNT-328', 'CLI-347', 'Licencia de Conducir', 1),
('RNT-328', 'CLI-347', 'Cédula de Identidad', 1),

-- RNT-329
('RNT-329', 'CLI-348', 'Cédula de Identidad', 1),
('RNT-329', 'CLI-349', 'Pasaporte', 1),

-- RNT-330
('RNT-330', 'CLI-350', 'Licencia de Conducir', 1),

-- RNT-331
('RNT-331', 'CLI-351', 'Cédula de Identidad', 1),

-- RNT-332
('RNT-332', 'CLI-352', 'Cédula de Identidad', 1),
('RNT-332', 'CLI-353', 'Licencia de Conducir', 1),

-- RNT-333
('RNT-333', 'CLI-354', 'Pasaporte', 1),
('RNT-333', 'CLI-354', 'Cédula de Identidad', 1),

-- RNT-334
('RNT-334', 'CLI-355', 'Licencia de Conducir', 1),
('RNT-334', 'CLI-356', 'Cédula de Identidad', 1),

-- RNT-335
('RNT-335', 'CLI-357', 'Cédula de Identidad', 1),

-- RNT-336
('RNT-336', 'CLI-358', 'Licencia de Conducir', 1),

-- RNT-337
('RNT-337', 'CLI-359', 'Cédula de Identidad', 1),
('RNT-337', 'CLI-360', 'Cédula de Identidad', 1),

-- RNT-338
('RNT-338', 'CLI-361', 'Pasaporte', 1),

-- RNT-339
('RNT-339', 'CLI-362', 'Cédula de Identidad', 1),
('RNT-339', 'CLI-363', 'Licencia de Conducir', 1),

-- RNT-340
('RNT-340', 'CLI-364', 'Cédula de Identidad', 1),

-- RNT-341
('RNT-341', 'CLI-365', 'Licencia de Conducir', 1),
('RNT-341', 'CLI-365', 'Cédula de Identidad', 1),

-- RNT-342
('RNT-342', 'CLI-366', 'Cédula de Identidad', 1),
('RNT-342', 'CLI-367', 'Pasaporte', 1),

-- RNT-343
('RNT-343', 'CLI-368', 'Cédula de Identidad', 1),

-- RNT-344
('RNT-344', 'CLI-369', 'Licencia de Conducir', 1),

-- RNT-345
('RNT-345', 'CLI-370', 'Cédula de Identidad', 1),
('RNT-345', 'CLI-371', 'Cédula de Identidad', 1),

-- RNT-346
('RNT-346', 'CLI-372', 'Licencia de Conducir', 1),

-- RNT-347
('RNT-347', 'CLI-373', 'Cédula de Identidad', 1),

-- RNT-348
('RNT-348', 'CLI-374', 'Pasaporte', 1),
('RNT-348', 'CLI-375', 'Licencia de Conducir', 1),

-- RNT-349
('RNT-349', 'CLI-376', 'Cédula de Identidad', 1),
('RNT-349', 'CLI-376', 'Licencia de Conducir', 1),

-- RNT-350
('RNT-350', 'CLI-377', 'Cédula de Identidad', 1),

-- RNT-351
('RNT-351', 'CLI-378', 'Cédula de Identidad', 1),
('RNT-351', 'CLI-379', 'Licencia de Conducir', 1),

-- RNT-352
('RNT-352', 'CLI-380', 'Cédula de Identidad', 1),

-- RNT-353
('RNT-353', 'CLI-381', 'Pasaporte', 1),

-- RNT-354
('RNT-354', 'CLI-382', 'Cédula de Identidad', 1),
('RNT-354', 'CLI-383', 'Cédula de Identidad', 1),

-- RNT-355
('RNT-355', 'CLI-384', 'Licencia de Conducir', 1),

-- RNT-356
('RNT-356', 'CLI-385', 'Cédula de Identidad', 1),

-- RNT-357
('RNT-357', 'CLI-386', 'Cédula de Identidad', 1),
('RNT-357', 'CLI-387', 'Pasaporte', 1),

-- RNT-358
('RNT-358', 'CLI-388', 'Licencia de Conducir', 1),
('RNT-358', 'CLI-388', 'Cédula de Identidad', 1),

-- RNT-359
('RNT-359', 'CLI-389', 'Cédula de Identidad', 1),
('RNT-359', 'CLI-390', 'Licencia de Conducir', 1),

-- RNT-360
('RNT-360', 'CLI-391', 'Cédula de Identidad', 1),

-- RNT-361
('RNT-361', 'CLI-392', 'Pasaporte', 1),

-- RNT-362
('RNT-362', 'CLI-393', 'Cédula de Identidad', 1),
('RNT-362', 'CLI-394', 'Cédula de Identidad', 1),

-- RNT-363
('RNT-363', 'CLI-395', 'Licencia de Conducir', 1),

-- RNT-364
('RNT-364', 'CLI-396', 'Cédula de Identidad', 1),
('RNT-364', 'CLI-397', 'Cédula de Identidad', 1),

-- RNT-365 (renta activa)
('RNT-365', 'CLI-398', 'Licencia de Conducir', 1),
('RNT-365', 'CLI-398', 'Cédula de Identidad', 1),

-- RNT-366 (renta activa)
('RNT-366', 'CLI-399', 'Cédula de Identidad', 1);

-- Inserts para tabla Renta (Junio 2025)
INSERT INTO Renta (RentaID, EmpleadoID, FechaRenta, FechaDevolucion, FechaDevuelto, Descuento, Total, Multa) VALUES 
-- Lunes 2 de Junio
('RNT-367', 'MGR-002', '2025-06-02', '2025-06-06', '2025-06-07', 0, 2200, 100),
-- Martes 3 de Junio
('RNT-368', 'MGR-001', '2025-06-03', '2025-06-06', '2025-06-06', 5, 1800, 0),
('RNT-369', 'MGR-003', '2025-06-03', '2025-06-07', '2025-06-07', 0, 950, 0),
('RNT-370', 'MGR-002', '2025-06-03', '2025-06-08', '2025-06-08', 10, 2500, 0),
-- Miércoles 4 de Junio
('RNT-371', 'MGR-001', '2025-06-04', '2025-06-07', '2025-06-06', 0, 1200, 0),
('RNT-372', 'MGR-002', '2025-06-04', '2025-06-09', '2025-06-10', 0, 1750, 50),
-- Jueves 5 de Junio
('RNT-373', 'MGR-003', '2025-06-05', '2025-06-08', '2025-06-08', 0, 2100, 0),
('RNT-374', 'MGR-001', '2025-06-05', '2025-06-10', '2025-06-10', 15, 1650, 0),
('RNT-375', 'MGR-002', '2025-06-05', '2025-06-09', '2025-06-09', 0, 800, 0),
-- Viernes 6 de Junio
('RNT-376', 'MGR-001', '2025-06-06', '2025-06-09', '2025-06-09', 0, 1900, 0),
('RNT-377', 'MGR-003', '2025-06-06', '2025-06-11', '2025-06-12', 0, 2300, 150),
-- Lunes 9 de Junio
('RNT-378', 'MGR-002', '2025-06-09', '2025-06-12', '2025-06-12', 0, 1400, 0),
('RNT-379', 'MGR-001', '2025-06-09', '2025-06-13', '2025-06-13', 5, 1950, 0),
('RNT-380', 'MGR-003', '2025-06-09', '2025-06-14', '2025-06-14', 0, 1100, 0),
-- Martes 10 de Junio
('RNT-381', 'MGR-001', '2025-06-10', '2025-06-13', '2025-06-13', 0, 2000, 0),
('RNT-382', 'MGR-002', '2025-06-10', '2025-06-15', '2025-06-14', 10, 1600, 0),
-- Miércoles 11 de Junio
('RNT-383', 'MGR-003', '2025-06-11', '2025-06-14', '2025-06-14', 0, 1750, 0),
('RNT-384', 'MGR-001', '2025-06-11', '2025-06-16', '2025-06-15', 0, 2400, 0),
('RNT-385', 'MGR-002', '2025-06-11', '2025-06-15', '2025-06-15', 0, 900, 0),
-- Jueves 12 de Junio
('RNT-386', 'MGR-001', '2025-06-12', '2025-06-15', '2025-06-15', 0, 1800, 0),
('RNT-387', 'MGR-003', '2025-06-12', '2025-06-17', '2025-06-15', 5, 2100, 0),
-- Viernes 13 de Junio
('RNT-388', 'MGR-002', '2025-06-13', '2025-06-16', '2025-06-15', 0, 1300, 0),
('RNT-389', 'MGR-001', '2025-06-13', '2025-06-18', '2025-06-15', 0, 2600, 0),
('RNT-390', 'MGR-003', '2025-06-13', '2025-06-17', '2025-06-15', 15, 1550, 0);

-- Inserts para tabla Cliente
INSERT INTO Cliente (ClienteID, RentaID, Nombre, Apellido, Telefono, Garantia, Habilitado) VALUES 

-- RNT-367 (1 cliente)
('CLI-401', 'RNT-367', 'Rosa Elena', 'Quispe', 77456789, 1, 1),
-- RNT-368 (1 cliente)
('CLI-402', 'RNT-368', 'Miguel Angel', 'Vargas', 78234567, 1, 1),
-- RNT-369 (2 clientes)
('CLI-403', 'RNT-369', 'Carmen Rosa', 'Flores', 76789012, 1, 1),
('CLI-404', 'RNT-369', 'Juan Carlos', 'Mendoza', 77890123, 1, 1),
-- RNT-370 (1 cliente)
('CLI-405', 'RNT-370', 'María Isabel', 'Choque', 78345678, 1, 1),
-- RNT-371 (2 clientes)
('CLI-406', 'RNT-371', 'Roberto Luis', 'Condori', 76456789, 1, 1),
('CLI-407', 'RNT-371', 'Lucia Patricia', 'Apaza', 77567890, 1, 1),
-- RNT-372 (1 cliente)
('CLI-408', 'RNT-372', 'Fernando Gabriel', 'Torrez', 78678901, 1, 1),
-- RNT-373 (2 clientes)
('CLI-409', 'RNT-373', 'Sandra Beatriz', 'Huanca', 76567890, 1, 1),
('CLI-410', 'RNT-373', 'Diego Armando', 'Calle', 77678901, 1, 1),
-- RNT-374 (1 cliente)
('CLI-411', 'RNT-374', 'Patricia Elena', 'Salinas', 78789012, 1, 1),
-- RNT-375 (2 clientes)
('CLI-412', 'RNT-375', 'Gonzalo Javier', 'Ramos', 76678901, 1, 1),
('CLI-413', 'RNT-375', 'Verónica Amparo', 'Cutipa', 77789012, 1, 1),
-- RNT-376 (1 cliente)
('CLI-414', 'RNT-376', 'Raúl Esteban', 'Mamani', 78890123, 1, 1),
-- RNT-377 (2 clientes)
('CLI-415', 'RNT-377', 'Silvia Marcela', 'Ticona', 76789123, 1, 1),
('CLI-416', 'RNT-377', 'Álvaro Jesús', 'Paredes', 77890234, 1, 1),
-- RNT-378 (1 cliente)
('CLI-417', 'RNT-378', 'Gloria Mercedes', 'Villca', 78901234, 1, 1),
-- RNT-379 (2 clientes)
('CLI-418', 'RNT-379', 'Andrés Felipe', 'Chura', 76890123, 1, 1),
('CLI-419', 'RNT-379', 'Mónica Alejandra', 'Quisbert', 77901234, 1, 1),
-- RNT-380 (1 cliente)
('CLI-420', 'RNT-380', 'Jorge Alberto', 'Nina', 78012345, 1, 1),
-- RNT-381 (2 clientes)
('CLI-421', 'RNT-381', 'Claudia Roxana', 'Marca', 76901234, 1, 1),
('CLI-422', 'RNT-381', 'Sergio Daniel', 'Colque', 77012345, 1, 1),
-- RNT-382 (1 cliente)
('CLI-423', 'RNT-382', 'Carla Vanessa', 'Limachi', 78123456, 1, 1),
-- RNT-383 (2 clientes)
('CLI-424', 'RNT-383', 'Osvaldo René', 'Callisaya', 76012345, 1, 1),
('CLI-425', 'RNT-383', 'Paola Fernanda', 'Yujra', 77123456, 1, 1),
-- RNT-384 (1 cliente)
('CLI-426', 'RNT-384', 'Ricardo Mauricio', 'Layme', 78234567, 1, 1),
-- RNT-385 (2 clientes)
('CLI-427', 'RNT-385', 'Elizabeth Soraya', 'Arce', 76123456, 1, 1),
('CLI-428', 'RNT-385', 'Víctor Hugo', 'Mamani', 77234567, 1, 1),
-- RNT-386 (1 cliente)
('CLI-429', 'RNT-386', 'Marlene Delia', 'Chuquimia', 78345678, 1, 1),
-- RNT-387 (2 clientes)
('CLI-430', 'RNT-387', 'Javier Rolando', 'Poma', 76234567, 1, 1),
('CLI-431', 'RNT-387', 'Yolanda Cristina', 'Chambilla', 77345678, 1, 1),
-- RNT-388 (1 cliente)
('CLI-432', 'RNT-388', 'Ramiro Edmundo', 'Alanoca', 78456789, 1, 1),
-- RNT-389 (2 clientes)
('CLI-433', 'RNT-389', 'Norma Susana', 'Gutiérrez', 76345678, 1, 1),
('CLI-434', 'RNT-389', 'Iván Patricio', 'Zenteno', 77456789, 1, 1),
-- RNT-390 (1 cliente)
('CLI-435', 'RNT-390', 'Gladys Mirian', 'Chipana', 78567890, 1, 1);

-- Inserts para tabla DetalleRenta
INSERT INTO DetalleRenta (RentaID, ProductoID, Cantidad, Subtotal, Habilitado) VALUES 

-- RNT-367: Rosa Elena Quispe
('RNT-367', 'PRD-041', 4, 2400, 1), -- Chaqueta Guindo
('RNT-367', 'PRD-043', 3, 600, 1), -- Pantalón Guindo
-- RNT-368: Miguel Angel Vargas
('RNT-368', 'PRD-081', 2, 500, 1), -- Pepino
('RNT-368', 'PRD-098', 3, 900, 1), -- Pollera Roja
('RNT-368', 'PRD-104', 2, 500, 1), -- Sombrero Blanco
-- RNT-369: Carmen Rosa Flores y Juan Carlos Mendoza
('RNT-369', 'PRD-001', 2, 1200, 1), -- Chaqueta Rojo/Negro
('RNT-369', 'PRD-004', 3, 300, 1), -- Faja Rojo/Negro
-- RNT-370: María Isabel Choque
('RNT-370', 'PRD-041', 5, 3000, 1), -- Chaqueta Guindo
('RNT-370', 'PRD-043', 4, 800, 1), -- Pantalón Guindo
('RNT-370', 'PRD-045', 2, 200, 1), -- Faja Guindo
-- RNT-371: Roberto Luis Condori y Lucia Patricia Apaza
('RNT-371', 'PRD-098', 2, 600, 1), -- Pollera Roja
('RNT-371', 'PRD-081', 1, 250, 1), -- Pepino
('RNT-371', 'PRD-104', 1, 250, 1), -- Sombrero Blanco
-- RNT-372: Fernando Gabriel Torrez
('RNT-372', 'PRD-001', 3, 1800, 1), -- Chaqueta Rojo/Negro
('RNT-372', 'PRD-003', 2, 400, 1), -- Pantalón Rojo/Negro
-- RNT-373: Sandra Beatriz Huanca y Diego Armando Calle
('RNT-373', 'PRD-041', 4, 2400, 1), -- Chaqueta Guindo
('RNT-373', 'PRD-043', 3, 600, 1), -- Pantalón Guindo
('RNT-373', 'PRD-045', 1, 100, 1), -- Faja Guindo
-- RNT-374: Patricia Elena Salinas
('RNT-374', 'PRD-098', 3, 900, 1), -- Pollera Roja
('RNT-374', 'PRD-104', 3, 750, 1), -- Sombrero Blanco
-- RNT-375: Gonzalo Javier Ramos y Verónica Amparo Cutipa
('RNT-375', 'PRD-081', 2, 500, 1), -- Pepino
('RNT-375', 'PRD-001', 1, 600, 1), -- Chaqueta Rojo/Negro
-- RNT-376: Raúl Esteban Mamani
('RNT-376', 'PRD-041', 3, 1800, 1), -- Chaqueta Guindo
('RNT-376', 'PRD-043', 2, 400, 1), -- Pantalón Guindo
-- RNT-377: Silvia Marcela Ticona y Álvaro Jesús Paredes
('RNT-377', 'PRD-001', 4, 2400, 1), -- Chaqueta Rojo/Negro
('RNT-377', 'PRD-003', 3, 600, 1), -- Pantalón Rojo/Negro
('RNT-377', 'PRD-004', 2, 200, 1), -- Faja Rojo/Negro
-- RNT-378: Gloria Mercedes Villca
('RNT-378', 'PRD-098', 2, 600, 1), -- Pollera Roja
('RNT-378', 'PRD-081', 1, 250, 1), -- Pepino
('RNT-378', 'PRD-104', 2, 500, 1), -- Sombrero Blanco
-- RNT-379: Andrés Felipe Chura y Mónica Alejandra Quisbert
('RNT-379', 'PRD-041', 3, 1800, 1), -- Chaqueta Guindo
('RNT-379', 'PRD-043', 2, 400, 1), -- Pantalón Guindo
('RNT-379', 'PRD-045', 1, 100, 1), -- Faja Guindo
-- RNT-380: Jorge Alberto Nina
('RNT-380', 'PRD-001', 2, 1200, 1), -- Chaqueta Rojo/Negro
('RNT-380', 'PRD-003', 1, 200, 1), -- Pantalón Rojo/Negro
-- RNT-381: Claudia Roxana Marca y Sergio Daniel Colque
('RNT-381', 'PRD-041', 4, 2400, 1), -- Chaqueta Guindo
('RNT-381', 'PRD-043', 3, 600, 1), -- Pantalón Guindo
-- RNT-382: Carla Vanessa Limachi
('RNT-382', 'PRD-098', 3, 900, 1), -- Pollera Roja
('RNT-382', 'PRD-104', 2, 500, 1), -- Sombrero Blanco
('RNT-382', 'PRD-081', 1, 250, 1), -- Pepino
-- RNT-383: Osvaldo René Callisaya y Paola Fernanda Yujra
('RNT-383', 'PRD-001', 3, 1800, 1), -- Chaqueta Rojo/Negro
('RNT-383', 'PRD-003', 2, 400, 1), -- Pantalón Rojo/Negro
-- RNT-384: Ricardo Mauricio Layme
('RNT-384', 'PRD-041', 5, 3000, 1), -- Chaqueta Guindo
('RNT-384', 'PRD-043', 4, 800, 1), -- Pantalón Guindo
('RNT-384', 'PRD-045', 2, 200, 1), -- Faja Guindo
-- RNT-385: Elizabeth Soraya Arce y Víctor Hugo Mamani
('RNT-385', 'PRD-081', 2, 500, 1), -- Pepino
('RNT-385', 'PRD-098', 1, 300, 1), -- Pollera Roja
('RNT-385', 'PRD-104', 1, 250, 1), -- Sombrero Blanco
-- RNT-386: Marlene Delia Chuquimia
('RNT-386', 'PRD-001', 3, 1800, 1), -- Chaqueta Rojo/Negro
('RNT-386', 'PRD-003', 2, 400, 1), -- Pantalón Rojo/Negro
-- RNT-387: Javier Rolando Poma y Yolanda Cristina Chambilla
('RNT-387', 'PRD-041', 4, 2400, 1), -- Chaqueta Guindo
('RNT-387', 'PRD-043', 3, 600, 1), -- Pantalón Guindo
-- RNT-388: Ramiro Edmundo Alanoca
('RNT-388', 'PRD-098', 2, 600, 1), -- Pollera Roja
('RNT-388', 'PRD-081', 1, 250, 1), -- Pepino
('RNT-388', 'PRD-104', 2, 500, 1), -- Sombrero Blanco
-- RNT-389: Norma Susana Gutiérrez y Iván Patricio Zenteno
('RNT-389', 'PRD-001', 5, 3000, 1), -- Chaqueta Rojo/Negro
('RNT-389', 'PRD-003', 4, 800, 1), -- Pantalón Rojo/Negro
('RNT-389', 'PRD-004', 3, 300, 1), -- Faja Rojo/Negro
-- RNT-390: Gladys Mirian Chipana
('RNT-390', 'PRD-041', 2, 1200, 1), -- Chaqueta Guindo
('RNT-390', 'PRD-043', 1, 200, 1), -- Pantalón Guindo
('RNT-390', 'PRD-045', 1, 100, 1); -- Faja Guindo

-- Inserts para tabla Garantia
INSERT INTO Garantia (RentaID, ClienteID, Tipo, Habilitado) VALUES 
-- RNT-367: Rosa Elena Quispe (1 garantía)
('RNT-367', 'CLI-401', 'Licencia de Conducir', 1),
-- RNT-368: Miguel Angel Vargas (2 garantías)
('RNT-368', 'CLI-402', 'Cédula de Identidad', 1),
('RNT-368', 'CLI-402', 'Pasaporte', 1),
-- RNT-369: Carmen Rosa Flores (1 garantía) y Juan Carlos Mendoza (1 garantía)
('RNT-369', 'CLI-403', 'Cédula de Identidad', 1),
('RNT-369', 'CLI-404', 'Licencia de Conducir', 1),
-- RNT-370: María Isabel Choque (2 garantías)
('RNT-370', 'CLI-405', 'Cédula de Identidad', 1),
('RNT-370', 'CLI-405', 'Licencia de Conducir', 1),
-- RNT-371: Roberto Luis Condori (1 garantía) y Lucia Patricia Apaza (1 garantía)
('RNT-371', 'CLI-406', 'Cédula de Identidad', 1),
('RNT-371', 'CLI-407', 'Licencia de Conducir', 1),
-- RNT-372: Fernando Gabriel Torrez (1 garantía)
('RNT-372', 'CLI-408', 'Cédula de Identidad', 1),
-- RNT-373: Sandra Beatriz Huanca (2 garantías) y Diego Armando Calle (1 garantía)
('RNT-373', 'CLI-409', 'Cédula de Identidad', 1),
('RNT-373', 'CLI-409', 'Pasaporte', 1),
('RNT-373', 'CLI-410', 'Licencia de Conducir', 1),
-- RNT-374: Patricia Elena Salinas (1 garantía)
('RNT-374', 'CLI-411', 'Cédula de Identidad', 1),
-- RNT-375: Gonzalo Javier Ramos (1 garantía) y Verónica Amparo Cutipa (1 garantía)
('RNT-375', 'CLI-412', 'Licencia de Conducir', 1),
('RNT-375', 'CLI-413', 'Cédula de Identidad', 1),
-- RNT-376: Raúl Esteban Mamani (2 garantías)
('RNT-376', 'CLI-414', 'Cédula de Identidad', 1),
('RNT-376', 'CLI-414', 'Licencia de Conducir', 1),
-- RNT-377: Silvia Marcela Ticona (1 garantía) y Álvaro Jesús Paredes (2 garantías)
('RNT-377', 'CLI-415', 'Cédula de Identidad', 1),
('RNT-377', 'CLI-416', 'Licencia de Conducir', 1),
('RNT-377', 'CLI-416', 'Pasaporte', 1),
-- RNT-378: Gloria Mercedes Villca (1 garantía)
('RNT-378', 'CLI-417', 'Cédula de Identidad', 1),
-- RNT-379: Andrés Felipe Chura (1 garantía) y Mónica Alejandra Quisbert (1 garantía)
('RNT-379', 'CLI-418', 'Licencia de Conducir', 1),
('RNT-379', 'CLI-419', 'Cédula de Identidad', 1),
-- RNT-380: Jorge Alberto Nina (1 garantía)
('RNT-380', 'CLI-420', 'Cédula de Identidad', 1),
-- RNT-381: Claudia Roxana Marca (2 garantías) y Sergio Daniel Colque (1 garantía)
('RNT-381', 'CLI-421', 'Cédula de Identidad', 1),
('RNT-381', 'CLI-421', 'Licencia de Conducir', 1),
('RNT-381', 'CLI-422', 'Cédula de Identidad', 1),
-- RNT-382: Carla Vanessa Limachi (1 garantía)
('RNT-382', 'CLI-423', 'Licencia de Conducir', 1),
-- RNT-383: Osvaldo René Callisaya (1 garantía) y Paola Fernanda Yujra (2 garantías)
('RNT-383', 'CLI-424', 'Cédula de Identidad', 1),
('RNT-383', 'CLI-425', 'Cédula de Identidad', 1),
('RNT-383', 'CLI-425', 'Pasaporte', 1),
-- RNT-384: Ricardo Mauricio Layme (2 garantías)
('RNT-384', 'CLI-426', 'Cédula de Identidad', 1),
('RNT-384', 'CLI-426', 'Licencia de Conducir', 1),
-- RNT-385: Elizabeth Soraya Arce (1 garantía) y Víctor Hugo Mamani (1 garantía)
('RNT-385', 'CLI-427', 'Cédula de Identidad', 1),
('RNT-385', 'CLI-428', 'Licencia de Conducir', 1),
-- RNT-386: Marlene Delia Chuquimia (1 garantía)
('RNT-386', 'CLI-429', 'Cédula de Identidad', 1),
-- RNT-387: Javier Rolando Poma (2 garantías) y Yolanda Cristina Chambilla (1 garantía)
('RNT-387', 'CLI-430', 'Cédula de Identidad', 1),
('RNT-387', 'CLI-430', 'Licencia de Conducir', 1),
('RNT-387', 'CLI-431', 'Cédula de Identidad', 1),
-- RNT-388: Ramiro Edmundo Alanoca (1 garantía)
('RNT-388', 'CLI-432', 'Licencia de Conducir', 1),
-- RNT-389: Norma Susana Gutiérrez (2 garantías) y Iván Patricio Zenteno (1 garantía)
('RNT-389', 'CLI-433', 'Cédula de Identidad', 1),
('RNT-389', 'CLI-433', 'Pasaporte', 1),
('RNT-389', 'CLI-434', 'Licencia de Conducir', 1),
-- RNT-390: Gladys Mirian Chipana (1 garantía)
('RNT-390', 'CLI-435', 'Cédula de Identidad', 1);

-- Actualizar disponibilidad de productos después de las rentas
UPDATE Producto SET Disponible = Disponible - 1 WHERE ProductoID = 'PRD-016'; -- Usado en RNT-005 (2) y RNT-025 (4) = 6 total
UPDATE Producto SET Disponible = Disponible - 2 WHERE ProductoID = 'PRD-018'; -- Usado en RNT-005 (1) y RNT-025 (2) = 3 total
UPDATE Producto SET Disponible = Disponible - 1 WHERE ProductoID = 'PRD-021'; -- Usado en RNT-006 (2) y RNT-026 (3) = 5 total
UPDATE Producto SET Disponible = Disponible - 1 WHERE ProductoID = 'PRD-093'; -- Usado en RNT-019 (5)
-- SOLO descontar los productos de la renta activa (RNT-030)
UPDATE Producto SET Disponible = Disponible - 3 WHERE ProductoID = 'PRD-041'; -- Chaqueta Guindo
UPDATE Producto SET Disponible = Disponible - 2 WHERE ProductoID = 'PRD-043'; -- Pantalón Guindo



SELECT DATE(FechaRenta) AS Fecha, COUNT(*) AS Rentas, SUM(Total) AS Ingreso
FROM Renta
GROUP BY DATE(FechaRenta)
ORDER BY Fecha;

select count(rentaID) from renta;