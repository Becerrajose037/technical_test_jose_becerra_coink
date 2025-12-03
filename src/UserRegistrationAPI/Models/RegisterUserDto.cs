using System.ComponentModel.DataAnnotations;

namespace UserRegistrationAPI.Models;

/// <summary>
/// Data Transfer Object for user registration
/// </summary>
public class RegisterUserDto
{
    [Required(ErrorMessage = "Name is required")]
    [StringLength(200, MinimumLength = 2, ErrorMessage = "Name must be between 2 and 200 characters")]
    public string Name { get; set; } = string.Empty;

    [Required(ErrorMessage = "Phone is required")]
    [StringLength(20, MinimumLength = 7, ErrorMessage = "Phone must be between 7 and 20 characters")]
    [Phone(ErrorMessage = "Invalid phone number format")]
    public string Phone { get; set; } = string.Empty;

    [Required(ErrorMessage = "Address is required")]
    [StringLength(500, MinimumLength = 5, ErrorMessage = "Address must be between 5 and 500 characters")]
    public string Address { get; set; } = string.Empty;

    [Required(ErrorMessage = "Country ID is required")]
    [Range(1, int.MaxValue, ErrorMessage = "Country ID must be a positive number")]
    public int CountryId { get; set; }

    [Required(ErrorMessage = "Department ID is required")]
    [Range(1, int.MaxValue, ErrorMessage = "Department ID must be a positive number")]
    public int DepartmentId { get; set; }

    [Required(ErrorMessage = "Municipality ID is required")]
    [Range(1, int.MaxValue, ErrorMessage = "Municipality ID must be a positive number")]
    public int MunicipalityId { get; set; }
}
