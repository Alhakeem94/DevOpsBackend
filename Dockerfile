# Stage 1 : build with the full SDK
FROM mcr.microsoft.com/dotnet/sdk:10.0 as build
WORKDIR /src
COPY DevOpsBackend.csproj ./
RUN dotnet restore 
COPY . .
RUN dotnet publish -c Release -o /app/publish

# Stage 2 : run with the small runtime image only that contains the IL langage for the complied code
FROM mcr.microsoft.com/dotnet/aspnet:10.0 
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT [ "dotnet", "DevOpsBackend.dll" ]


