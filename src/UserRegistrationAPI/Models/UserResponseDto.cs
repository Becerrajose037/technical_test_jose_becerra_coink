namespace UserRegistrationAPI.Models;

/// <summary>
/// Data Transfer Object for user response with flattened location data
/// </summary>
public class UserResponseDto
{
    public int UserId { get; set; }
    public string UserName { get; set; } = string.Empty;
    public string Phone { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public int CountryId { get; set; }
    public string CountryName { get; set; } = string.Empty;
    public int DepartmentId { get; set; }
    public string DepartmentName { get; set; } = string.Empty;
    public int MunicipalityId { get; set; }
    public string MunicipalityName { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
}
