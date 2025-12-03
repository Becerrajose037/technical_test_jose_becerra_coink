

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project file and restore dependencies
COPY ["src/UserRegistrationAPI/UserRegistrationAPI.csproj", "UserRegistrationAPI/"]
RUN dotnet restore "UserRegistrationAPI/UserRegistrationAPI.csproj"

# Copy source code and build
COPY ["src/UserRegistrationAPI/", "UserRegistrationAPI/"]
WORKDIR "/src/UserRegistrationAPI"
RUN dotnet build "UserRegistrationAPI.csproj" -c Release -o /app/build

# Publish stage
FROM build AS publish
RUN dotnet publish "UserRegistrationAPI.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
EXPOSE 8080

# Copy published application
COPY --from=publish /app/publish .

# Set environment variables
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Production

# Run the application
ENTRYPOINT ["dotnet", "UserRegistrationAPI.dll"]
