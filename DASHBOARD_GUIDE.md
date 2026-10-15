# Dashboard Setup and Usage

## What the dashboard runs

The dashboard executes the required sequence:

```text
Application Ingestion Agent
→ Risk Scoring Agent
→ Policy Engine
→ Decision Agent
→ Explainability Agent
→ Llama 3 Explanation Generator
→ Audit Logger
```

The risk model, sample applicant schema, and policies remain synthetic demonstration assumptions because the original requirement did not specify production data, model artefacts, thresholds, or policy definitions.

## Llama 3

The dashboard is configured to use `llama3:8b` through local Ollama by default. Llama 3 receives only the completed decision context and generates the readable explanation. It cannot override the Risk Scoring Agent, Policy Engine, or Decision Agent.

Complete model setup instructions are in `LLAMA3_SETUP.md`.

## Windows quick start

1. Extract the project ZIP.
2. Install Ollama.
3. Double-click `setup_llama3.bat` to download `llama3:8b`.
4. Double-click `run_dashboard.bat`.
5. Open `http://localhost:8501` if the browser does not open automatically.
6. Click **Test Llama 3 connection** in the sidebar.

## Windows manual commands

```powershell
ollama pull llama3:8b
py -3 -m venv .venv
.venv\Scripts\activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python src\train_demo_model.py
python tests\validate_demo.py
python tests\test_ollama_llm.py
python -m streamlit run dashboard.py
```

## Linux or macOS

```bash
chmod +x setup_llama3.sh run_dashboard.sh
./setup_llama3.sh
./run_dashboard.sh
```

## Dashboard tabs

### Single application

Enter one applicant record and click **Run all agents**. The result includes the decision, risk probability, policy checks, SHAP factors, Llama 3 explanation, selected LLM model, and complete audit record.

### Batch processing

Upload a CSV or use `demo/sample_applications.csv`. Each valid row runs through the complete workflow. Llama 3 generation is sequential, so large batches will take longer.

### Audit history

Every successful decision is appended to `outputs/audit_log.jsonl`. Records include `llm_provider` and `llm_model` fields.

### System details

Shows the selected LLM runtime, synthetic model metadata, agent sequence, and limitations.

## Required CSV columns

```text
application_id
age
annual_income
loan_amount
loan_term_months
credit_score
existing_monthly_debt
employment_years
missed_payments_12m
```

## Offline test mode

The sidebar retains an **Offline deterministic adapter** for tests and demonstrations when Ollama is unavailable. This mode is not an LLM and is labelled as such in the audit record.

## Files added for Llama 3

```text
LLAMA3_SETUP.md
setup_llama3.bat
setup_llama3.sh
src/ollama_llm.py
tests/test_ollama_llm.py
```

## Important limitation

This is an educational prototype. The model, fields, and policy thresholds are not validated for real credit decisions. Llama 3 improves explanation generation only; it does not correct the absence of real lending data, governance, fairness validation, privacy controls, regulatory review, or production security.
