
-- Tabla: pais
CREATE TABLE IF NOT EXISTS pais (
    id_pais SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

-- Tabla: departamento
CREATE TABLE IF NOT EXISTS departamento (
    id_departamento SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_pais INT NOT NULL,
    FOREIGN KEY (id_pais) REFERENCES pais(id_pais) ON DELETE CASCADE,
    UNIQUE(nombre, id_pais)
);

-- Tabla: municipio
CREATE TABLE IF NOT EXISTS municipio (
    id_municipio SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_departamento INT NOT NULL,
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento) ON DELETE CASCADE,
    UNIQUE(nombre, id_departamento)
);

-- Tabla: usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(500) NOT NULL,
    id_municipio INT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_municipio) REFERENCES municipio(id_municipio) ON DELETE RESTRICT
);

-- Indices para optimización

CREATE INDEX idx_departamento_id_pais ON departamento(id_pais);
CREATE INDEX idx_municipio_id_departamento ON municipio(id_departamento);
CREATE INDEX idx_usuarios_id_municipio ON usuarios(id_municipio);
CREATE INDEX idx_usuarios_fecha_creacion ON usuarios(fecha_creacion);

-- Seed Data


-- Insert Paises
INSERT INTO pais (nombre) VALUES 
('Colombia')
ON CONFLICT DO NOTHING;

-- Insert Departamentos (Colombia)
INSERT INTO departamento (nombre, id_pais) VALUES 
('Antioquia', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Cundinamarca', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Valle del Cauca', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Atlántico', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Santander', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Norte de Santander', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Risaralda', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Tolima', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Caldas', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Meta', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Quindío', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Huila', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Magdalena', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Bolívar', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Cesar', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Nariño', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Cauca', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Sucre', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Casanare', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Caquetá', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Putumayo', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Arauca', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Guaviare', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Amazonas', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('La Guajira', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Córdoba', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Boyacá', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Chocó', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Guainía', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Vaupés', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
('Vichada', (SELECT id_pais FROM pais WHERE nombre = 'Colombia'))
ON CONFLICT DO NOTHING;

INSERT INTO municipio (nombre, id_departamento) VALUES 
('Medellín', (SELECT id_departamento FROM departamento WHERE nombre = 'Antioquia')),
('Envigado', (SELECT id_departamento FROM departamento WHERE nombre = 'Antioquia')),
('Rionegro', (SELECT id_departamento FROM departamento WHERE nombre = 'Antioquia')),
('Bogotá', (SELECT id_departamento FROM departamento WHERE nombre = 'Cundinamarca')),
('Chía', (SELECT id_departamento FROM departamento WHERE nombre = 'Cundinamarca')),
('Zipaquirá', (SELECT id_departamento FROM departamento WHERE nombre = 'Cundinamarca')),
('Cali', (SELECT id_departamento FROM departamento WHERE nombre = 'Valle del Cauca')),
('Palmira', (SELECT id_departamento FROM departamento WHERE nombre = 'Valle del Cauca')),
('Santander de Quilichao', (SELECT id_departamento FROM departamento WHERE nombre = 'Valle del Cauca')),
('Barranquilla', (SELECT id_departamento FROM departamento WHERE nombre = 'Atlántico')),
('Soledad', (SELECT id_departamento FROM departamento WHERE nombre = 'Atlántico')),
('Bucaramanga', (SELECT id_departamento FROM departamento WHERE nombre = 'Santander')),
('Floridablanca', (SELECT id_departamento FROM departamento WHERE nombre = 'Santander')),
('Cúcuta', (SELECT id_departamento FROM departamento WHERE nombre = 'Norte de Santander')),
('Pereira', (SELECT id_departamento FROM departamento WHERE nombre = 'Risaralda')),
('Dosquebradas', (SELECT id_departamento FROM departamento WHERE nombre = 'Risaralda')),
('Ibagué', (SELECT id_departamento FROM departamento WHERE nombre = 'Tolima')),
('Espinal', (SELECT id_departamento FROM departamento WHERE nombre = 'Tolima')),
('Melgar', (SELECT id_departamento FROM departamento WHERE nombre = 'Tolima')),
('Manizales', (SELECT id_departamento FROM departamento WHERE nombre = 'Caldas')),
('La Dorada', (SELECT id_departamento FROM departamento WHERE nombre = 'Caldas')),
('Chinchiná', (SELECT id_departamento FROM departamento WHERE nombre = 'Caldas')),
('Villavicencio', (SELECT id_departamento FROM departamento WHERE nombre = 'Meta')),
('Acacías', (SELECT id_departamento FROM departamento WHERE nombre = 'Meta')),
('Armenia', (SELECT id_departamento FROM departamento WHERE nombre = 'Quindío')),
('Montenegro', (SELECT id_departamento FROM departamento WHERE nombre = 'Quindío')),
('Neiva', (SELECT id_departamento FROM departamento WHERE nombre = 'Huila')),
('Pitalito', (SELECT id_departamento FROM departamento WHERE nombre = 'Huila')),
('Santa Marta', (SELECT id_departamento FROM departamento WHERE nombre = 'Magdalena')),
('Cartagena', (SELECT id_departamento FROM departamento WHERE nombre = 'Bolívar')),
('Turbaco', (SELECT id_departamento FROM departamento WHERE nombre = 'Bolívar')),
('Valledupar', (SELECT id_departamento FROM departamento WHERE nombre = 'Cesar')),
('Pasto', (SELECT id_departamento FROM departamento WHERE nombre = 'Nariño')),
('Ipiales', (SELECT id_departamento FROM departamento WHERE nombre = 'Nariño')),
('Popayán', (SELECT id_departamento FROM departamento WHERE nombre = 'Cauca')),
('Sincelejo', (SELECT id_departamento FROM departamento WHERE nombre = 'Sucre')),
('Yopal', (SELECT id_departamento FROM departamento WHERE nombre = 'Casanare')),
('Florencia', (SELECT id_departamento FROM departamento WHERE nombre = 'Caquetá')),
('Mocoa', (SELECT id_departamento FROM departamento WHERE nombre = 'Putumayo')),
('Arauca', (SELECT id_departamento FROM departamento WHERE nombre = 'Arauca')),
('San José del Guaviare', (SELECT id_departamento FROM departamento WHERE nombre = 'Guaviare')),
('Leticia', (SELECT id_departamento FROM departamento WHERE nombre = 'Amazonas')),
('Riohacha', (SELECT id_departamento FROM departamento WHERE nombre = 'La Guajira')),
('Montería', (SELECT id_departamento FROM departamento WHERE nombre = 'Córdoba')),
('Lorica', (SELECT id_departamento FROM departamento WHERE nombre = 'Córdoba')),
('Tunja', (SELECT id_departamento FROM departamento WHERE nombre = 'Boyacá')),
('Duitama', (SELECT id_departamento FROM departamento WHERE nombre = 'Boyacá')),
('Quibdó', (SELECT id_departamento FROM departamento WHERE nombre = 'Chocó')),
('Inírida', (SELECT id_departamento FROM departamento WHERE nombre = 'Guainía')),
('Mitú', (SELECT id_departamento FROM departamento WHERE nombre = 'Vaupés')),
('Calamar', (SELECT id_departamento FROM departamento WHERE nombre = 'Vichada')),
('Jamundí', (SELECT id_departamento FROM departamento WHERE nombre = 'Valle del Cauca'))
ON CONFLICT DO NOTHING;

-- Insert Users
INSERT INTO usuarios (nombre, telefono, direccion, id_municipio) VALUES
('Juan Pérez', '+57 3124567890', 'Calle 10 #25-45, El Poblado', (SELECT id_municipio FROM municipio WHERE nombre = 'Medellín')),
('María González', '+57 3012456789', 'Carrera 45 #89-12, Suba', (SELECT id_municipio FROM municipio WHERE nombre = 'Bogotá')),
('Andrés López', '+57 3209876543', 'Av. 6N #23-80, Granada', (SELECT id_municipio FROM municipio WHERE nombre = 'Cali')),
('Laura Martínez', '+57 3112233445', 'Calle 72 #41-55, Alto Prado', (SELECT id_municipio FROM municipio WHERE nombre = 'Barranquilla')),
('Carlos Ramírez', '+57 3156549870', 'Cra 27 #45-20, Cabecera', (SELECT id_municipio FROM municipio WHERE nombre = 'Bucaramanga')),
('Sofía Herrera', '+57 3029988776', 'Calle 8 #3-25, La Riviera', (SELECT id_municipio FROM municipio WHERE nombre = 'Cúcuta')),
('Julián Torres', '+57 3103344556', 'Cra 7 #18-50, Circunvalar', (SELECT id_municipio FROM municipio WHERE nombre = 'Pereira')),
('Camila Mendoza', '+57 3198765432', 'Av. Ambalá #12-40', (SELECT id_municipio FROM municipio WHERE nombre = 'Ibagué')),
('Felipe Rojas', '+57 3164455667', 'Carrera 20 #15-18, Chipre', (SELECT id_municipio FROM municipio WHERE nombre = 'Manizales')),
('Natalia Suárez', '+57 3116677889', 'Calle 34 #28-90, La Esperanza', (SELECT id_municipio FROM municipio WHERE nombre = 'Villavicencio')),
('Santiago Rivera', '+57 3172233445', 'Cra 13 #21-40, Centro', (SELECT id_municipio FROM municipio WHERE nombre = 'Armenia')),
('Daniela Castro', '+57 3017788990', 'Calle 9 #5-12, Las Palmas', (SELECT id_municipio FROM municipio WHERE nombre = 'Neiva')),
('Mateo Vargas', '+57 3123344556', 'Av. del Libertador #45-60', (SELECT id_municipio FROM municipio WHERE nombre = 'Santa Marta')),
('Isabella Morales', '+57 3148899001', 'Calle Real #8-20, Getsemaní', (SELECT id_municipio FROM municipio WHERE nombre = 'Cartagena')),
('David Pérez', '+57 3157788990', 'Cra 19 #11-30, Novalito', (SELECT id_municipio FROM municipio WHERE nombre = 'Valledupar')),
('Valentina Ortiz', '+57 3022233445', 'Calle 12 #6-25, Centro', (SELECT id_municipio FROM municipio WHERE nombre = 'Pasto')),
('Sebastián Ramírez', '+57 3219988776', 'Cra 4 #15-50, Centro Histórico', (SELECT id_municipio FROM municipio WHERE nombre = 'Popayán')),
('Manuela Díaz', '+57 3186655443', 'Calle 20 #17-34, Las Colinas', (SELECT id_municipio FROM municipio WHERE nombre = 'Sincelejo')),
('Gabriel Silva', '+57 3108877665', 'Cra 21 #8-60, El Progreso', (SELECT id_municipio FROM municipio WHERE nombre = 'Yopal')),
('Lucía Castaño', '+57 3135544332', 'Av. Centenario #25-22', (SELECT id_municipio FROM municipio WHERE nombre = 'Florencia')),
('Esteban Gómez', '+57 3204455667', 'Calle 7 #10-15, San Miguel', (SELECT id_municipio FROM municipio WHERE nombre = 'Mocoa')),
('Sara Gil', '+57 3161122334', 'Cra 9 #6-50, Fundadores', (SELECT id_municipio FROM municipio WHERE nombre = 'Arauca')),
('Diego Navarro', '+57 3196677889', 'Calle 5 #3-45, Centro', (SELECT id_municipio FROM municipio WHERE nombre = 'San José del Guaviare')),
('Paula Cárdenas', '+57 3014455667', 'Av. Internacional #4-12', (SELECT id_municipio FROM municipio WHERE nombre = 'Leticia')),
('Tomás Castro', '+57 3127788990', 'Calle 2 #12-34, Centro', (SELECT id_municipio FROM municipio WHERE nombre = 'Riohacha')),
('Renata Blanco', '+57 3156677889', 'Cra 14 #21-50, Los Laureles', (SELECT id_municipio FROM municipio WHERE nombre = 'Montería')),
('Alejandro Peña', '+57 3183344556', 'Av. Norte #33-12', (SELECT id_municipio FROM municipio WHERE nombre = 'Tunja')),
('Valeria Ruiz', '+57 3029988775', 'Calle 11 #4-20, La Yesquita', (SELECT id_municipio FROM municipio WHERE nombre = 'Quibdó')),
('Juanita Vega', '+57 3105544332', 'Cra 3 #6-45, Centro', (SELECT id_municipio FROM municipio WHERE nombre = 'Inírida')),
('Pedro Andrade', '+57 3147788990', 'Calle 8 #3-12, La Floresta', (SELECT id_municipio FROM municipio WHERE nombre = 'Mitú')),
('Daniel Torres', '+57 3166655443', 'Cra 10 #9-40', (SELECT id_municipio FROM municipio WHERE nombre = 'Calamar')),
('Adriana Zapata', '+57 3123344556', 'Calle 14 #3-25, Centro', (SELECT id_municipio FROM municipio WHERE nombre = 'Chía')),
('Luis Pardo', '+57 3208899001', 'Cra 20 #10-30', (SELECT id_municipio FROM municipio WHERE nombre = 'Rionegro')),
('Andrea Rincón', '+57 3014455667', 'Calle 9 #8-15', (SELECT id_municipio FROM municipio WHERE nombre = 'Santander de Quilichao')),
('Ricardo Salazar', '+57 3199988776', 'Av. Simón Bolívar #22-10', (SELECT id_municipio FROM municipio WHERE nombre = 'La Dorada')),
('Mariana Cabrera', '+57 3126677889', 'Calle 13 #7-40', (SELECT id_municipio FROM municipio WHERE nombre = 'Espinal')),
('Samuel León', '+57 3119988775', 'Cra 11 #5-20', (SELECT id_municipio FROM municipio WHERE nombre = 'Acacías')),
('Nicole Arango', '+57 3152233445', 'Calle 29 #18-50', (SELECT id_municipio FROM municipio WHERE nombre = 'Floridablanca')),
('Jorge Cárdenas', '+57 3184455667', 'Av. Murillo #45-22', (SELECT id_municipio FROM municipio WHERE nombre = 'Soledad')),
('Lucía López', '+57 3106677889', 'Cra 6 #12-10', (SELECT id_municipio FROM municipio WHERE nombre = 'Montenegro')),
('Juan Esteban Álvarez', '+57 3128899001', 'Calle 22 #15-25', (SELECT id_municipio FROM municipio WHERE nombre = 'Palmira')),
('Carolina Navarro', '+57 3023344556', 'Cra 4 #9-34', (SELECT id_municipio FROM municipio WHERE nombre = 'Turbaco')),
('Camilo García', '+57 3157788990', 'Av. Circunvalar #18-20', (SELECT id_municipio FROM municipio WHERE nombre = 'Duitama')),
('María José Rojas', '+57 3174455667', 'Calle 11 #8-10', (SELECT id_municipio FROM municipio WHERE nombre = 'Dosquebradas')),
('Tomás Arias', '+57 3196677889', 'Cra 13 #14-50', (SELECT id_municipio FROM municipio WHERE nombre = 'Lorica')),
('Valentina Díaz', '+57 3121122334', 'Calle 10 #7-90', (SELECT id_municipio FROM municipio WHERE nombre = 'Ipiales')),
('Emilio Fernández', '+57 3109988776', 'Av. Central #25-22', (SELECT id_municipio FROM municipio WHERE nombre = 'Pitalito')),
('Gabriela Moreno', '+57 3162233445', 'Calle 4 #5-11', (SELECT id_municipio FROM municipio WHERE nombre = 'Melgar')),
('Pablo Gómez', '+57 3016677889', 'Cra 43 #34-20', (SELECT id_municipio FROM municipio WHERE nombre = 'Envigado')),
('Laura Castillo', '+57 3127788990', 'Calle 8 #9-22', (SELECT id_municipio FROM municipio WHERE nombre = 'Zipaquirá')),
('Felipe Torres', '+57 3155544332', 'Cra 12 #6-30', (SELECT id_municipio FROM municipio WHERE nombre = 'Chinchiná')),
('Isabela Ramírez', '+57 3188899001', 'Calle 20 #11-18', (SELECT id_municipio FROM municipio WHERE nombre = 'Jamundí'));
