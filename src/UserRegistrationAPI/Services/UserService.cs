using UserRegistrationAPI.Models;
using UserRegistrationAPI.Repositories;

namespace UserRegistrationAPI.Services;

public class UserService : IUserService
{
    private readonly IUserRepository _userRepository;
    private readonly ILogger<UserService> _logger;

    public UserService(IUserRepository userRepository, ILogger<UserService> logger)
    {
        _userRepository = userRepository;
        _logger = logger;
    }

    public async Task<int> RegisterUserAsync(RegisterUserDto userDto)
    {
        try
        {
            _logger.LogInformation("Registering new user: {Name}", userDto.Name);
            
            var user = new User
            {
                Name = userDto.Name,
                Phone = userDto.Phone,
                Address = userDto.Address,
                CountryId = userDto.CountryId,
                DepartmentId = userDto.DepartmentId,
                MunicipalityId = userDto.MunicipalityId
            };

            var userId = await _userRepository.RegisterUserAsync(user);
            
            _logger.LogInformation("User registered successfully with ID: {UserId}", userId);
            
            return userId;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error registering user: {Name}", userDto.Name);
            throw;
        }
    }

    public async Task<IEnumerable<UserResponseDto>> GetAllUsersAsync()
    {
        try
        {
            _logger.LogInformation("Retrieving all users");
            
            var users = await _userRepository.GetAllUsersAsync();
            
            _logger.LogInformation("Retrieved {Count} users", users.Count());
            
            return users;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving users");
            throw;
        }
    }

    public async Task<IEnumerable<Country>> GetCountriesAsync()
    {
        try
        {
            return await _userRepository.GetCountriesAsync();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving countries");
            throw;
        }
    }

    public async Task<IEnumerable<Department>> GetDepartmentsByCountryAsync(int countryId)
    {
        try
        {
            return await _userRepository.GetDepartmentsByCountryAsync(countryId);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving departments for country {CountryId}", countryId);
            throw;
        }
    }

    public async Task<IEnumerable<Municipality>> GetMunicipalitiesByDepartmentAsync(int departmentId)
    {
        try
        {
            return await _userRepository.GetMunicipalitiesByDepartmentAsync(departmentId);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving municipalities for department {DepartmentId}", departmentId);
            throw;
        }
    }
}
