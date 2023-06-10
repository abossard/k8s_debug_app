FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
ARG PROJECT_NAME=k8s_debug_app
WORKDIR /app
COPY . ./
RUN dotnet restore "$PROJECT_NAME.csproj"
RUN dotnet publish "$PROJECT_NAME.csproj" -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:7.0
EXPOSE 80
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "k8s_debug_app.dll"]