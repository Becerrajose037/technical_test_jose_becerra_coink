using UserRegistrationAPI.Models;

namespace UserRegistrationAPI.Services;

/// <summary>
/// Service interface for user business logic
/// </summary>
public interface IUserService
{
    /// <summary>
    /// Registers a new user
    /// </summary>
    Task<int> RegisterUserAsync(RegisterUserDto userDto);

    /// <summary>
    /// Gets all registered users
    /// </summary>
    Task<IEnumerable<UserResponseDto>> GetAllUsersAsync();

    /// <summary>
    /// Gets all countries
    /// </summary>
    Task<IEnumerable<Country>> GetCountriesAsync();

    /// <summary>
    /// Gets departments by country
    /// </summary>
    Task<IEnumerable<Department>> GetDepartmentsByCountryAsync(int countryId);

    /// <summary>
    /// Gets municipalities by department
    /// </summary>
    Task<IEnumerable<Municipality>> GetMunicipalitiesByDepartmentAsync(int departmentId);
}
