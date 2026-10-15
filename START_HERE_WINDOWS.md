# Run the complete project locally (Windows)

## Prerequisites
- Python 3.11 or 3.12 recommended
- Ollama installed (optional for the Llama 3 explanation mode)

## Setup (PowerShell)
Open PowerShell in this extracted folder and run:

```powershell
py -3.12 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python tests\validate_demo.py
python -m streamlit run dashboard.py
```

If Python 3.12 is not installed, replace `py -3.12` with `py -3.11` or `python`.

## Llama 3 explanations (optional)
In a separate terminal:
```powershell
ollama pull llama3:8b
ollama serve
```
Select the Ollama/Llama 3 provider in the dashboard. The Ollama service must be available for this mode.

## What's included
- Streamlit dashboard
- Modular custom Python agents (no LangChain)
- Trained Logistic Regression model artifact and training script
- SHAP explainability, policy engine, decision agent
- Ollama Llama 3 explanation integration
- Intermediate input/output trace logging and final audit
- Validation scripts, requirements traceability, architecture and setup docs

## Important
This is a synthetic-data demonstration, not a production loan underwriting system.
Check `SPECIFICATION_GAPS.md` and `REQUIREMENTS_TRACEABILITY.md` for unprovided requirements.
