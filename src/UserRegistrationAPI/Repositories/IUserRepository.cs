using UserRegistrationAPI.Models;

namespace UserRegistrationAPI.Repositories;

/// <summary>
/// Repository interface for user data access
/// </summary>
public interface IUserRepository
{
    /// <summary>
    /// Registers a new user into the database
    /// </summary>
    Task<int> RegisterUserAsync(User user);

    /// <summary>
    /// Retrieves all users with their location information
    /// </summary>
    Task<IEnumerable<UserResponseDto>> GetAllUsersAsync();

    /// <summary>
    /// Gets all countries
    /// </summary>
    Task<IEnumerable<Country>> GetCountriesAsync();

    /// <summary>
    /// Gets departments by country ID
    /// </summary>
    Task<IEnumerable<Department>> GetDepartmentsByCountryAsync(int countryId);

    /// <summary>
    /// Gets municipalities by department ID
    /// </summary>
    Task<IEnumerable<Municipality>> GetMunicipalitiesByDepartmentAsync(int departmentId);
}
