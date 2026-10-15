@echo off
setlocal
where ollama >nul 2>nul
if errorlevel 1 (
  echo Ollama is not installed or is not on PATH.
  echo Install Ollama, reopen this terminal, then run this file again.
  exit /b 1
)
echo Pulling Llama 3 8B. This downloads several GB once.
ollama pull llama3:8b
if errorlevel 1 exit /b 1
echo.
echo Llama 3 is ready. Start the dashboard with run_dashboard.bat
endlocal
