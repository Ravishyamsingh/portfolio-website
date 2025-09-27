# Script to run both frontend and backend servers
Write-Host "Starting development servers..." -ForegroundColor Green

# Define paths
$frontendPath = Join-Path $PSScriptRoot "frontend"
$backendPath = Join-Path $PSScriptRoot "backend"
$pythonPath = "C:/Users/ravis/AppData/Local/Programs/Python/Python313/python.exe"

# Check if paths exist
if (-not (Test-Path $frontendPath)) {
    Write-Error "Frontend path not found: $frontendPath"
    exit 1
}

if (-not (Test-Path $backendPath)) {
    Write-Error "Backend path not found: $backendPath"
    exit 1
}

if (-not (Test-Path $pythonPath)) {
    Write-Error "Python executable not found: $pythonPath"
    exit 1
}

Write-Host "Starting Frontend (React) server..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-Command",
    "Set-Location '$frontendPath'; Write-Host 'Installing npm packages...' -ForegroundColor Cyan; npm install; Write-Host 'Starting frontend server...' -ForegroundColor Cyan; npm start"
)

Write-Host "Starting Backend (Django) server..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-Command",
    "Set-Location '$backendPath'; `$env:PYTHONPATH='$backendPath;$backendPath\portfolio_backend'; Write-Host 'Starting backend server...' -ForegroundColor Cyan; & '$pythonPath' manage.py runserver"
)

Write-Host "Development servers started successfully!" -ForegroundColor Green
Write-Host "Frontend server running at: http://localhost:3000" -ForegroundColor Cyan
Write-Host "Backend server running at: http://localhost:8000" -ForegroundColor Cyan
Write-Host "Press Ctrl+C in the respective windows to stop the servers" -ForegroundColor Yellow
