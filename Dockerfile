# Step 1: Build stage (SDK image)
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY . .
WORKDIR "/src/Website"
RUN dotnet publish -c Release -o /out

# Step 2: Runtime stage (ASP.NET runtime image)
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /out .
ENTRYPOINT ["dotnet", "Website.dll"]
