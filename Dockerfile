# Step 1: Build stage (use .NET 8 SDK)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy Website and Library (dependencies)
COPY Website/ ./Website/
COPY Library/ ./Library/

WORKDIR "/src/Website"
RUN dotnet publish -c Release -o /out

# Step 2: Runtime stage (use .NET 8 runtime)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /out .
ENTRYPOINT ["dotnet", "Website.dll"]
