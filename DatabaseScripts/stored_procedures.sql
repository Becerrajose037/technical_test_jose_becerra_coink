
-- Insertar nuevo usuario
CREATE OR REPLACE PROCEDURE sp_insertar_usuario(
    p_nombre VARCHAR,
    p_telefono VARCHAR,
    p_direccion VARCHAR,
    p_id_municipio INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO usuarios (nombre, telefono, direccion, id_municipio)
    VALUES (p_nombre, p_telefono, p_direccion, p_id_municipio);
END;
$$;

-- Obtener todos los usuarios con detalles de ubicación
CREATE OR REPLACE FUNCTION sp_obtener_usuarios()
RETURNS TABLE (
    id_usuario INT,
    nombre VARCHAR,
    telefono VARCHAR,
    direccion VARCHAR,
    fecha_creacion TIMESTAMP,
    municipio VARCHAR,
    id_municipio INT,
    departamento VARCHAR,
    id_departamento INT,
    pais VARCHAR,
    id_pais INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        u.id_usuario,
        u.nombre,
        u.telefono,
        u.direccion,
        u.fecha_creacion,
        m.nombre as municipio,
        m.id_municipio,
        d.nombre as departamento,
        d.id_departamento,
        p.nombre as pais,
        p.id_pais
    FROM usuarios u
    JOIN municipio m ON u.id_municipio = m.id_municipio
    JOIN departamento d ON m.id_departamento = d.id_departamento
    JOIN pais p ON d.id_pais = p.id_pais
    ORDER BY u.fecha_creacion DESC;
END;
$$;


-- Get All Countries
CREATE OR REPLACE FUNCTION obtener_paises()
RETURNS TABLE (
    id_pais INT,
    nombre VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT p.id_pais, p.nombre
    FROM pais p
    ORDER BY p.nombre;
END;
$$;

-- Get Departments by Country
CREATE OR REPLACE FUNCTION obtener_departamentos_por_pais(p_id_pais INT)
RETURNS TABLE (
    id_departamento INT,
    nombre VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT d.id_departamento, d.nombre
    FROM departamento d
    WHERE d.id_pais = p_id_pais
    ORDER BY d.nombre;
END;
$$;

-- Get Municipalities by Department
CREATE OR REPLACE FUNCTION obtener_municipios_por_departamento(p_id_departamento INT)
RETURNS TABLE (
    id_municipio INT,
    nombre VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT m.id_municipio, m.nombre
    FROM municipio m
    WHERE m.id_departamento = p_id_departamento
    ORDER BY m.nombre;
END;
$$;
