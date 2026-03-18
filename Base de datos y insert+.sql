Create table Usuarios(
IdUsuario int IDENTITY(1,1) PRIMARY KEY,
Nombre varchar(100) NOT NULL,
Email varchar(150) UNIQUE,
PasswordHash varchar(200),
Rol varchar(50),
Activo bit Default 1, --el valor bit es una verdadero falso o null--
);

Create table Fallas(
IdFalla int IDENTITY (1,1) PRIMARY KEY,
NombreFalla varchar(150) NOT NULL,
Descripcion varchar(300),
Solucion varchar (300),
NivelGravedad int);

Create table Sintomas(
IdSintoma int IDENTITY (1,1) PRIMARY KEY,
NombreSintoma Varchar(200) NOT NULL,
Activo Bit Default 1 
);

Create table Reglas(
IdRegla int IDENTITY (1,1) PRIMARY KEY,
IdFalla int NOT NULL,
Prioridad INT,
FOREIGN KEY (IdFalla) References Fallas(IdFalla)
);

CREATE TABLE DetalleRegla(
    IdDetalle INT IDENTITY(1,1) PRIMARY KEY,
    IdRegla INT NOT NULL,
    IdSintoma INT NOT NULL,
    Valor BIT, -- 1 = SI , 0 = NO
    FOREIGN KEY (IdRegla) REFERENCES Reglas(IdRegla),
    FOREIGN KEY (IdSintoma) REFERENCES Sintomas(IdSintoma)
);

CREATE TABLE SesionDiagnostico(
    IdSesion INT IDENTITY(1,1) PRIMARY KEY,
    IdUsuario INT NULL,
    Fecha DATETIME DEFAULT GETDATE(),
    ObservacionUsuario VARCHAR(500),
    FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);

CREATE TABLE RespuestaSesion(
    IdRespuesta INT IDENTITY(1,1) PRIMARY KEY,
    IdSesion INT,
    IdSintoma INT,
    Valor BIT,
    FOREIGN KEY (IdSesion) REFERENCES SesionDiagnostico(IdSesion),
    FOREIGN KEY (IdSintoma) REFERENCES Sintomas(IdSintoma)
);

CREATE TABLE ResultadoDiagnostico(
    IdResultado INT IDENTITY(1,1) PRIMARY KEY,
    IdSesion INT,
    IdFalla INT,
    Probabilidad DECIMAL(5,2),
    EsPrincipal BIT,
    FOREIGN KEY (IdSesion) REFERENCES SesionDiagnostico(IdSesion),
    FOREIGN KEY (IdFalla) REFERENCES Fallas(IdFalla)
);

INSERT INTO Sintomas (NombreSintoma) VALUES
('La PC enciende'),
('Hay imagen'),
('Está lenta'),
('Se apaga sola'),
('Está caliente');

INSERT INTO Fallas (NombreFalla,Descripcion,Solucion) VALUES
('Fuente dañada','No recibe energia','Cambiar fuente'),
('RAM dañada','No muestra imagen','Probar otra RAM');

INSERT INTO Reglas (IdFalla,Prioridad) VALUES (1,1);

INSERT INTO DetalleRegla (IdRegla,IdSintoma,Valor)
VALUES
(1,1,0), -- No enciende
(1,2,0); -- No hay imagen