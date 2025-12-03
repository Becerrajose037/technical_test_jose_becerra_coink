namespace UserRegistrationAPI.Models;

/// <summary>
/// User entity representing a registered user with location information
/// </summary>
public class User
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Phone { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public int CountryId { get; set; }
    public int DepartmentId { get; set; }
    public int MunicipalityId { get; set; }
    public DateTime CreatedAt { get; set; }
}
