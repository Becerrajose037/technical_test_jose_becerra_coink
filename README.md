# Sistema de Registro de Usuarios - Coink

Una solución completa full-stack para el registro de usuarios con seguimiento de ubicación geográfica (País, Departamento, Municipio), construida con .NET 8, PostgreSQL y JavaScript Vanilla.
---

## � Instrucciones de Ejecución

### Opción 1: Docker (Recomendado)

La forma más sencilla de ejecutar la aplicación es utilizando Docker Compose.

1.  Asegúrese de tener Docker Desktop instalado y ejecutándose.
2.  Abra una terminal en la raíz del proyecto.
3.  Ejecute el siguiente comando:

```bash
docker compose up --build
```

4.  Acceda a la aplicación:
    *   **Frontend**: [http://localhost:5173](http://localhost:5173)
    *   **Swagger API**: [http://localhost:8080/swagger](http://localhost:8080/swagger)

### Opción 2: Ejecución Local (Sin Docker)

**Requisitos Previos:**
*   .NET 8 SDK
*   PostgreSQL 16+

**Pasos:**

1.  **Base de Datos**:
    *   Cree una base de datos llamada `user_registration`.
    *   Ejecute los scripts SQL ubicados en `DatabaseScripts/` en el siguiente orden:
        1.  `create_tables.sql`
        2.  `stored_procedures.sql`

2.  **Backend**:
    *   Navegue a `src/UserRegistrationAPI`.
    *   Actualice la cadena de conexión en `appsettings.json` si es necesario.
    *   Ejecute: `dotnet run`

3.  **Frontend**:
    *   Navegue a la carpeta `client`.
    *   Abra `index.html` en su navegador o utilice una extensión como "Live Server".

---

## 🛠️ Tecnologías Utilizadas

*   **Backend**: C# .NET 8, Dapper (ORM), Swagger/OpenAPI.
*   **Base de Datos**: PostgreSQL 16.
*   **Frontend**: HTML5, CSS3 (Diseño Moderno/Responsive), JavaScript (ES6+).
*   **DevOps**: Docker, Docker Compose, Nginx.

---

## 🚀 Execution Instructions

### Option 1: Docker (Recommended)

The easiest way to run the application is using Docker Compose.

1.  Ensure Docker Desktop is installed and running.
2.  Open a terminal at the project root.
3.  Run the following command:

```bash
docker compose up --build
```

4.  Access the application:
    *   **Frontend**: [http://localhost:5173](http://localhost:5173)
    *   **Swagger API**: [http://localhost:8080/swagger](http://localhost:8080/swagger)

### Option 2: Local Execution (Without Docker)

**Prerequisites:**
*   .NET 8 SDK
*   PostgreSQL 16+

**Steps:**

1.  **Database**:
    *   Create a database named `user_registration`.
    *   Run the SQL scripts located in `DatabaseScripts/` in the following order:
        1.  `create_tables.sql`
        2.  `stored_procedures.sql`

2.  **Backend**:
    *   Navigate to `src/UserRegistrationAPI`.
    *   Update the connection string in `appsettings.json` if necessary.
    *   Run: `dotnet run`

3.  **Frontend**:
    *   Navigate to the `client` folder.
    *   Open `index.html` in your browser or use an extension like "Live Server".

---

## 🛠️ Technologies Used

*   **Backend**: C# .NET 8, Dapper (ORM), Swagger/OpenAPI.
*   **Database**: PostgreSQL 16.
*   **Frontend**: HTML5, CSS3 (Modern/Responsive Design), JavaScript (ES6+).
*   **DevOps**: Docker, Docker Compose, Nginx.
