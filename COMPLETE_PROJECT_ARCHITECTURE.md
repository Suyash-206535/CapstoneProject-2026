# Automated Loan Approval Agent — Complete Project Architecture

**Version:** Improved capstone project (14 October 2026)  
**Architecture:** Custom modular Python agents; **no LangChain, LangGraph, or CrewAI**.  
**Scope:** Local demonstration using synthetic data and illustrative policies; not a production lending decision system.

## 1. End-to-end architecture

```text
                       MODEL TRAINING (offline)
 Synthetic applicant records and synthetic risk labels
                         |
              src/train_demo_model.py
                         |
                75% train / 25% test
                         |
       Train Logistic Regression + fitted scaler
                         |
        Evaluate accuracy, precision, recall,
                   F1 and ROC-AUC
                         |
   model_artifacts/demo_credit_risk_model.joblib
                         |
                         v
                     INFERENCE
 Streamlit dashboard.py / batch sample applications
                         |
                         v
                Application Ingestion
            validate + preprocess features
                         |
                         v
                  Risk Scoring
       load saved model bundle and saved scaler
          trained_model.predict_proba(...)
                         |
                         v
                    Policy Engine
           demo/policy_rules.yaml checks
                         |
                         v
                   Decision Agent
                 APPROVED / REJECTED
                         |
                         v
                 SHAP Explainability
                feature contributions
                         |
                         v
               Explanation Generator
         local fallback or Llama 3 via Ollama
                         |
                         v
               Final structured response
                         |
                         v
            Streamlit results + audit history

 EVERY STAGE --> execution_trace (input, output, status,
                  duration, trace_id)
                         |
                         v
          outputs/audit_log.jsonl (append-only)
```

## 2. Components and responsibilities

| Layer | Project file | Responsibility |
|---|---|---|
| UI | `dashboard.py` | Enter applicant parameters or CSV, run workflow, display risk, decision, explanation, model information, execution trace and audit history. |
| Workflow orchestration | `src/main.py` | Coordinate modular agents and collect intermediate inputs/outputs. |
| Runnable demo backend | `src/demo_runtime.py` | Validate and transform sample features, load model, calculate score, evaluate demo policy, compute SHAP, generate local explanation, write/read audit records. |
| Ingestion | `src/application_ingestion_agent.py` | Validate and preprocess applicant input. |
| Risk scoring | `src/risk_scoring_agent.py` | Invoke trained-model risk scoring through an injected scoring implementation. |
| Policy | `src/policy_engine.py` | Apply configured eligibility checks. |
| Decision | `src/decision_agent.py` | Combine model risk and policy results into a decision. |
| Explainability | `src/explainability_agent.py` | Produce feature-level SHAP evidence. |
| Natural-language explanation | `src/explanation_generator.py`, `src/ollama_llm.py` | Turn structured decision evidence into understandable text; Ollama can serve Llama 3. LLM does not approve loans. |
| Audit | `src/audit_logger.py`, `src/demo_runtime.py` | Persist final outcome and intermediate execution trace to JSONL. |
| Training | `src/train_demo_model.py` | Generate synthetic data, train model, evaluate on held-out synthetic data, save artifact. |

## 3. Detailed runtime data flow

1. **Input:** Streamlit gathers an applicant record or reads sample applicants from `demo/sample_applications.csv`.
2. **Preprocessing:** `preprocess_application()` checks required fields and derives debt-to-income and loan-to-income values.
3. **Risk scoring:** `score_application()` loads `model_artifacts/demo_credit_risk_model.joblib`, applies the stored scaler and calls `bundle['model'].predict_proba(scaled)[0, 1]` to obtain the demo high-risk probability.
4. **Policy:** `evaluate_policy()` reads demo eligibility rules and records pass/fail checks.
5. **Decision:** `make_decision()` combines risk probability with policy outcomes; final result is `APPROVED` or `REJECTED`.
6. **SHAP:** `compute_shap_evidence()` generates feature contribution evidence for the specific applicant.
7. **Explanation:** Llama 3 via Ollama (when selected/available) or a local fallback produces a human-readable explanation based on the structured evidence.
8. **Trace and audit:** An application-specific `trace_id` associates stage inputs, outputs, status and duration with the final outcome in append-only `outputs/audit_log.jsonl`.
9. **Display:** Streamlit shows the final decision, risk score, explanation and expandable agent execution trace.

## 4. Model training and inference separation

- **Training:** synthetic feature rows + synthetic risk labels -> fit scaler and Logistic Regression -> evaluate on 25% held-out synthetic data -> save fitted bundle.
- **Inference:** new Streamlit applicant -> same feature transformation and saved scaler -> saved Logistic Regression `predict_proba()` -> risk probability.
- The trained model, **not an LLM or a random score**, generates the risk probability.
- Synthetic evaluation results are not evidence of real-world credit risk performance.

## 5. Logging and observability

Each stage is associated with a trace identifier and captures input, output, status and duration. The final audit record stores the full execution trace and model information. In production, applicant personally identifying information would need access controls, masking/encryption, retention limits and audit integrity safeguards.

## 6. Mentor's three improvements

| Mentor requirement | Implemented evidence |
|---|---|
| Log intermediate inputs/outputs and final output | `execution_trace` in orchestration; persisted JSONL audit; expandable trace in Streamlit. |
| Check all requirements | `REQUIREMENTS_TRACEABILITY.md` maps each documented FR/NFR to code and tests. Scope is explicitly **demo-only** where production specifications are missing. |
| Use trained model | Saved `.joblib` bundle is loaded by `score_application()`; persisted scaler and `predict_proba()` are used for inference. |

## 7. Key files and folders

```text
project/
├── dashboard.py
├── src/
│   ├── main.py
│   ├── demo_runtime.py
│   ├── train_demo_model.py
│   ├── application_ingestion_agent.py
│   ├── risk_scoring_agent.py
│   ├── policy_engine.py
│   ├── decision_agent.py
│   ├── explainability_agent.py
│   ├── explanation_generator.py
│   ├── ollama_llm.py
│   └── audit_logger.py
├── demo/
│   ├── sample_applications.csv
│   └── policy_rules.yaml
├── model_artifacts/
│   └── demo_credit_risk_model.joblib
├── prompts/
│   └── explanation_prompt.txt
├── outputs/
│   └── audit_log.jsonl   (generated at runtime)
├── tests/
│   ├── validate_demo.py
│   └── test_ollama_llm.py
├── CAPSTONE_DOCUMENTATION.md
├── REQUIREMENTS_TRACEABILITY.md
├── SPECIFICATION_GAPS.md
├── README.md
└── requirements.txt
```

## 8. Testing and execution

From the project directory, after installing dependencies:

```powershell
python tests\validate_demo.py
python -m streamlit run dashboard.py
```

For local Llama 3 explanations, ensure Ollama is running and `llama3:8b` is installed. See `LLAMA3_SETUP.md` for setup details.

## 9. Architecture limitations

- The original requirements did not specify production banking data, final policy thresholds, an API contract or audit infrastructure. These remain demo-scoped or configurable, not production-complete.
- The agent design is **modular and sequential**, not an autonomous planning/multi-agent framework.
- Llama 3 generates explanations; the deterministic policy and trained ML score drive decisions.
- Production adoption would require real validated data, fairness and calibration assessments, security, authentication, versioning, monitoring and regulatory review.

**Source:** Architecture and traceability verified against the uploaded `Automated_Loan_Approval_Agent_Improved.zip`.
