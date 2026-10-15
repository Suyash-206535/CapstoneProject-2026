# Requirements Traceability Matrix

This matrix maps the requirements documented in `CAPSTONE_DOCUMENTATION.md` to the runnable demo implementation and validation evidence. Demo-only assumptions remain explicitly labelled because the original requirement did not provide production data, policy thresholds, model specifications, or infrastructure details.

| ID | Requirement | Implementation / Evidence | Validation | Status |
|---|---|---|---|---|
| FR-5.1 | Ingest loan applications from file or API | `src/application_ingestion_agent.py`; CSV loading in `src/main.py`; dashboard single/CSV entry | `tests/validate_demo.py` exercises included CSV samples | Complete for local demo; API adapter remains injectable because endpoint was not specified |
| FR-5.2 | Preprocess applicant features | `preprocess_application()` in `src/demo_runtime.py` validates fields and derives debt-to-income and loan-to-income | End-to-end validation checks successful processing | Complete for documented demo schema |
| FR-5.3 | Use a trained ML model to generate risk score | `src/train_demo_model.py` trains Logistic Regression; persisted `model_artifacts/demo_credit_risk_model.joblib`; `score_application()` loads it and calls `predict_proba` | Model-use assertions in `tests/validate_demo.py`; model metadata exposed in dashboard/audit | Complete for demo |
| FR-5.4 | Apply eligibility/compliance rules | `PolicyEngine` + `demo/policy_rules.yaml` + `evaluate_policy()` | Validation requires policy checks for every result | Complete for demo rules |
| FR-5.5 | Produce APPROVED/REJECTED | `DecisionAgent` + `make_decision()` | Validation requires both decision types across sample data | Complete |
| FR-5.6 | Generate SHAP + LLM explanation | `ExplainabilityAgent`, SHAP `LinearExplainer`, `ExplanationGenerator`; Llama 3/Ollama option | Validation requires SHAP factors and explanation; Ollama tests are separate | Complete for local demo |
| FR-5.7 | Store decisions/explanations for audit | `AuditLogger` + append-only `outputs/audit_log.jsonl` | Validation reads stored records back | Complete for local demo |
| NFR-6.1 | Python 3.x | Python source project | Runtime execution | Complete |
| NFR-6.2 | Deterministic and traceable outputs | Per-application `trace_id`; `execution_trace` records every stage input, output, status, duration; final record includes model/LLM metadata | `tests/validate_demo.py` asserts stage trace and persistence | Complete for local demo |
| NFR-6.3 | Explainability/transparency | Risk score, policy checks, SHAP factors, LLM explanation shown in Streamlit | End-to-end validation | Complete |
| NFR-6.4 | Modular agent-based design | Separate ingestion, risk, policy, decision, explainability, explanation, audit components | Architecture and imports | Complete |
| NFR-6.5 | Local/prototype execution | Streamlit + local model artifact + Ollama/local fallback | `tests/validate_demo.py` | Complete |

## Mentor improvement evidence

1. **Log all intermediate inputs/outputs:** `run_workflow()` now records a structured `execution_trace` for ingestion, risk scoring, policy evaluation, decision, SHAP explainability, and explanation generation. The complete trace is persisted with the final audit record and is visible in Streamlit.
2. **Complete all requirement-document points:** the matrix above maps every functional and non-functional requirement to code and validation evidence. Items whose production details were absent from the requirement remain explicitly demo-scoped rather than fabricated.
3. **Use the trained model:** `score_application()` loads the persisted `demo_credit_risk_model.joblib`, applies the persisted scaler, and invokes the trained Logistic Regression model's `predict_proba()` method. Model identity and inference method are recorded in each audit result.
