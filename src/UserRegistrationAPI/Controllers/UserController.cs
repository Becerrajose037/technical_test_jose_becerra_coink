using Microsoft.AspNetCore.Mvc;
using UserRegistrationAPI.Models;
using UserRegistrationAPI.Services;

namespace UserRegistrationAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
public class UserController : ControllerBase
{
    private readonly IUserService _userService;
    private readonly ILogger<UserController> _logger;

    public UserController(IUserService userService, ILogger<UserController> logger)
    {
        _userService = userService;
        _logger = logger;
    }

    /// <summary>
    /// Registers a new user.
    /// </summary>
    [HttpPost("register")]
    [ProducesResponseType(typeof(object), StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<IActionResult> Register([FromBody] RegisterUserDto userDto)
    {
        try
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new
                {
                    success = false,
                    message = "Validation failed",
                    errors = ModelState.Values
                        .SelectMany(v => v.Errors)
                        .Select(e => e.ErrorMessage)
                });
            }

            var userId = await _userService.RegisterUserAsync(userDto);

            return CreatedAtAction(
                nameof(GetAll),
                new { id = userId },
                new
                {
                    success = true,
                    message = "User registered successfully",
                    userId = userId
                });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error in Register endpoint");
            return StatusCode(500, new
            {
                success = false,
                message = "An error occurred while registering the user",
                error = ex.Message
            });
        }
    }

    /// <summary>
    /// Retrieves all registered users.
    /// </summary>
    [HttpGet("all")]
    [ProducesResponseType(typeof(IEnumerable<UserResponseDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<IActionResult> GetAll()
    {
        try
        {
            var users = await _userService.GetAllUsersAsync();

            return Ok(new
            {
                success = true,
                count = users.Count(),
                data = users
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error in GetAll endpoint");
            return StatusCode(500, new
            {
                success = false,
                message = "An error occurred while retrieving users",
                error = ex.Message
            });
        }
    }

    /// <summary>
    /// Gets all available countries.
    /// </summary>
    [HttpGet("countries")]
    [ProducesResponseType(typeof(IEnumerable<Country>), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetCountries()
    {
        try
        {
            var countries = await _userService.GetCountriesAsync();
            return Ok(new { success = true, data = countries });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error in GetCountries endpoint");
            return StatusCode(500, new { success = false, error = ex.Message });
        }
    }

    /// <summary>
    /// Gets departments by country ID.
    /// </summary>
    [HttpGet("departments/{countryId}")]
    [ProducesResponseType(typeof(IEnumerable<Department>), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetDepartments(int countryId)
    {
        try
        {
            var departments = await _userService.GetDepartmentsByCountryAsync(countryId);
            return Ok(new { success = true, data = departments });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error in GetDepartments endpoint");
            return StatusCode(500, new { success = false, error = ex.Message });
        }
    }

    /// <summary>
    /// Gets municipalities by department ID.
    /// </summary>
    [HttpGet("municipalities/{departmentId}")]
    [ProducesResponseType(typeof(IEnumerable<Municipality>), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetMunicipalities(int departmentId)
    {
        try
        {
            var municipalities = await _userService.GetMunicipalitiesByDepartmentAsync(departmentId);
            return Ok(new { success = true, data = municipalities });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error in GetMunicipalities endpoint");
            return StatusCode(500, new { success = false, error = ex.Message });
        }
    }
}
