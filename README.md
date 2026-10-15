# Automated Loan Approval Agent

## Project Status

This repository is a capstone-project implementation scaffold and submission document based strictly on the supplied Project Requirement Document.

The requirement document defines the required architecture, workflow stages, input-file names, deliverables, and technologies at a high level. It does **not** specify the following implementation-critical details:

- loan-application column names and data types;
- application API details;
- preprocessing rules;
- ML model type, training method, feature order, artifact format, or scoring interface;
- risk-score range and approval thresholds;
- policy-rule structure and actual business or regulatory rules;
- conflict-resolution behavior between model output and policy results;
- SHAP explainer configuration and feature-name mapping;
- LLM provider, model, access method, or response format;
- audit-storage technology, schema, retention, or security controls;
- final decision-output schema.

To avoid inventing requirements, the source code uses dependency-injected callables for these unspecified decisions. The package therefore demonstrates the required modular agent-based design and validates component contracts, but a fully executable loan decision requires the missing project-specific configuration.

## Purpose

The system is designed to:

1. ingest loan application data from a file or API;
2. preprocess applicant features;
3. generate an ML-based risk score;
4. apply eligibility and compliance rules;
5. produce an approval or rejection decision;
6. generate SHAP-based decision evidence;
7. generate a clear explanation through an LLM;
8. store the decision and explanation for audit purposes.

## Required Core Components

- Application Ingestion Agent
- Risk Scoring Agent
- Policy Engine
- Decision Agent
- Explainability Agent
- Explanation Generator (LLM)
- Audit Logger

## Repository Structure

```text
Automated_Loan_Approval_Agent/
├── README.md
├── CAPSTONE_DOCUMENTATION.md
├── SPECIFICATION_GAPS.md
├── loan_applications.csv
├── policy_rules.yaml
├── explainability_config.yaml
├── model_artifacts/
│   └── README.md
├── prompts/
│   └── explanation_prompt.txt
├── outputs/
│   └── README.md
├── docs/
│   └── ARCHITECTURE_SUMMARY.md
└── src/
    ├── application_ingestion_agent.py
    ├── risk_scoring_agent.py
    ├── policy_engine.py
    ├── decision_agent.py
    ├── explainability_agent.py
    ├── explanation_generator.py
    ├── audit_logger.py
    └── main.py
```

## Python Version

Python 3.x, as specified in the requirement document.

No exact minor version is specified.

## Input Files

### `loan_applications.csv`

Required loan-application input file. The application schema is not specified, so the included file is intentionally empty.

### `model_artifacts/`

Required location for trained ML model artifacts. The model type, serialization format, and file name are not specified.

### `policy_rules.yaml`

Required policy configuration file. The YAML schema and policy content are not specified, so the file contains documentation comments only.

### `explainability_config.yaml`

Required explainability configuration file. The expected configuration keys and values are not specified.

### `prompts/`

Required prompt directory for LLM explanation generation. The prompt file contains only requirement-aligned instructions and placeholders for supplied decision evidence.

## Source Module Summary

### `application_ingestion_agent.py`

Reads CSV applications using the Python standard library. API ingestion and feature preprocessing require injected implementations because their details are not specified.

### `risk_scoring_agent.py`

Calls an injected trained-model scoring function and validates that a score is returned. It does not assume a particular model framework or artifact format.

### `policy_engine.py`

Reads the raw policy YAML text and calls an injected policy evaluator. It does not invent a YAML schema or business rules.

### `decision_agent.py`

Calls an injected decision function and restricts the final result to `APPROVED` or `REJECTED`.

### `explainability_agent.py`

Calls an injected SHAP computation function. The project requires SHAP, but its explainer type and configuration are not specified.

### `explanation_generator.py`

Builds the prompt context and calls an injected LLM generation function. No LLM provider or model is assumed.

### `audit_logger.py`

Calls an injected audit writer. The requirement mandates audit storage but does not define a storage format or technology.

### `main.py`

Coordinates the required components in the documented sequence and provides a reusable workflow function. Its demonstration entry point reports the unresolved configuration rather than producing fabricated decisions.

## Running the Project

The package cannot make a valid end-to-end loan decision until the missing project-specific items are supplied.

After supplying them, the workflow can be invoked through `run_workflow(...)` in `src/main.py` by providing:

- a preprocessing function;
- a trained-model scoring function;
- a policy evaluation function;
- a decision function;
- a SHAP computation function;
- an LLM generation function;
- an audit writer function.

The callable interfaces are documented in the source-code docstrings.

A direct check of the current scaffold can be run from the repository root:

```bash
python src/main.py
```

Expected behavior: it prints the configuration items that remain unspecified. It does not create a loan decision.

## Output

The required output consists of:

- an approval or rejection decision;
- a risk score;
- policy-evaluation results;
- SHAP-based evidence;
- an LLM-generated explanation;
- an audit record.

The exact output file format and field schema are not specified in the requirement document. The workflow therefore returns an in-memory Python dictionary and passes the same audit record to the injected audit writer.

## Determinism and Traceability

The architecture supports deterministic and traceable outputs by:

- preserving the application record passed between components;
- keeping model, policy, decision, explainability, explanation, and audit responsibilities separate;
- validating component return types;
- passing a complete decision record to the audit layer;
- avoiding hidden fallback rules.

Actual determinism also depends on the supplied model, policy logic, LLM settings, and storage implementation. Their deterministic settings are not specified.

## Documentation

See:

- `CAPSTONE_DOCUMENTATION.md` for the complete submission document;
- `docs/ARCHITECTURE_SUMMARY.md` for the architecture summary;
- `SPECIFICATION_GAPS.md` for the list of missing implementation details.

## Scope Control

This repository does not add user interfaces, databases, web frameworks, authentication, deployment infrastructure, model-training pipelines, monitoring, fairness metrics, or external services because they are not present in the requirement document.

---

## Runnable Dashboard Extension

A separate **demo runtime** has been added in response to the later requirement to execute the agents through a UI dashboard. It does not alter the original strict scaffold. Instead, it supplies clearly labelled synthetic assumptions for the implementation details absent from the original requirement.

### Dashboard capabilities

- single application evaluation;
- CSV batch evaluation;
- execution of the seven required workflow components;
- synthetic ML risk probability;
- deterministic policy checks;
- approval or rejection decision;
- SHAP feature contributions;
- Llama 3 explanation through local Ollama;
- explicitly labelled offline deterministic test mode;
- append-only JSONL audit logging;
- downloadable JSON and CSV results.

### Start on Windows

```powershell
run_dashboard.bat
```

Or manually:

```powershell
py -3 -m venv .venv
.venv\Scripts\activate
python -m pip install -r requirements.txt
python src\train_demo_model.py
python tests\validate_demo.py
python -m streamlit run dashboard.py
```

### Start on Linux or macOS

```bash
./run_dashboard.sh
```

See `DASHBOARD_GUIDE.md` for complete usage instructions.

### Critical limitation

The demo model is trained on synthetic data and the policies are illustrative. Llama 3 is used only for explanation generation and does not make or override the loan decision. The offline deterministic adapter remains available as a non-LLM test mode. The included demo must not be used for actual lending decisions.


## Llama 3 Explanation Integration

The runnable dashboard now uses a real local LLM through Ollama. The default model is `llama3:8b`. Install Ollama, run `setup_llama3.bat` on Windows or `setup_llama3.sh` on Linux/macOS, and then start the dashboard. Full instructions are in `LLAMA3_SETUP.md`.

Llama 3 is restricted to the Explanation Generator. Risk scoring, policy evaluation, and the authoritative approval/rejection decision remain deterministic components outside the LLM. Audit records identify the configured LLM provider and model. The offline deterministic adapter remains available as an explicitly labelled test mode.

## Mentor-requested improvements (October 2026)

The runnable demo now includes three explicit hardening changes:

1. **Full intermediate trace logging** — every workflow stage records its input, output, status, and duration under a per-application `trace_id`; this trace is persisted with the final JSONL audit record and shown in Streamlit.
2. **Requirements traceability** — `REQUIREMENTS_TRACEABILITY.md` maps each documented functional/non-functional requirement to its implementation and validation evidence.
3. **Verified trained-model inference** — risk scoring loads `model_artifacts/demo_credit_risk_model.joblib`, uses the persisted scaler, and calls the trained Logistic Regression model via `predict_proba()`. The audit record exposes the model algorithm, artifact, and inference method.

The synthetic held-out model evaluation now reports Accuracy, Precision, Recall, F1, and ROC-AUC. These metrics demonstrate the training/evaluation pipeline only; they are not evidence of real-world credit performance.
