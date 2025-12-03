namespace UserRegistrationAPI.Models;

/// <summary>
/// Location entity models
/// </summary>
public class Country
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
}

public class Department
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public int CountryId { get; set; }
}

public class Municipality
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public int DepartmentId { get; set; }
}
