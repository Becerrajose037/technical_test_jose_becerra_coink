using Dapper;
using Npgsql;
using UserRegistrationAPI.Models;
using System.Data;

namespace UserRegistrationAPI.Repositories;

public class UserRepository : IUserRepository
{
    private readonly string _connectionString;

    public UserRepository(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection")
            ?? throw new InvalidOperationException("Database connection string not configured");
    }

    public async Task<int> RegisterUserAsync(User user)
    {
        using var connection = new NpgsqlConnection(_connectionString);
        
        var parameters = new DynamicParameters();
        parameters.Add("p_nombre", user.Name);
        parameters.Add("p_telefono", user.Phone);
        parameters.Add("p_direccion", user.Address);
        parameters.Add("p_id_municipio", user.MunicipalityId);

        await connection.ExecuteAsync("sp_insertar_usuario", parameters, commandType: CommandType.StoredProcedure);
        
        return 1;
    }

    public async Task<IEnumerable<UserResponseDto>> GetAllUsersAsync()
    {
        using var connection = new NpgsqlConnection(_connectionString);
        
        var query = @"
            SELECT 
                id_usuario as UserId,
                nombre as UserName,
                telefono as Phone,
                direccion as Address,
                fecha_creacion as CreatedAt,
                municipio as MunicipalityName,
                id_municipio as MunicipalityId,
                departamento as DepartmentName,
                id_departamento as DepartmentId,
                pais as CountryName,
                id_pais as CountryId
            FROM sp_obtener_usuarios()";
            
        var users = await connection.QueryAsync<UserResponseDto>(query);
        
        return users;
    }

    public async Task<IEnumerable<Country>> GetCountriesAsync()
    {
        using var connection = new NpgsqlConnection(_connectionString);
        
        var query = "SELECT id_pais as Id, nombre as Name FROM obtener_paises()";
        var countries = await connection.QueryAsync<Country>(query);
        
        return countries;
    }

    public async Task<IEnumerable<Department>> GetDepartmentsByCountryAsync(int countryId)
    {
        using var connection = new NpgsqlConnection(_connectionString);
        
        var query = "SELECT id_departamento as Id, nombre as Name FROM obtener_departamentos_por_pais(@p_id_pais)";
        var departments = await connection.QueryAsync<Department>(
            query,
            new { p_id_pais = countryId }
        );
        
        return departments;
    }

    public async Task<IEnumerable<Municipality>> GetMunicipalitiesByDepartmentAsync(int departmentId)
    {
        using var connection = new NpgsqlConnection(_connectionString);
        
        var query = "SELECT id_municipio as Id, nombre as Name FROM obtener_municipios_por_departamento(@p_id_departamento)";
        var municipalities = await connection.QueryAsync<Municipality>(
            query,
            new { p_id_departamento = departmentId }
        );
        
        return municipalities;
    }
}
