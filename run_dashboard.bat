@echo off
setlocal
cd /d "%~dp0"
if not exist ".venv\Scripts\python.exe" (
  py -3 -m venv .venv
)
call .venv\Scripts\activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python src\train_demo_model.py
python tests\validate_demo.py
python tests\test_ollama_llm.py
python -m streamlit run dashboard.py
endlocal
