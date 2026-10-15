# Automated Loan Approval Agent

## Complete Capstone Project Documentation

---

## 1. Executive Summary

The Automated Loan Approval Agent is an Agentic AI system intended to evaluate loan applications through a coordinated set of specialized components. The required system ingests application data, preprocesses applicant features, generates a machine-learning risk score, applies eligibility and compliance rules, produces an approval or rejection decision, creates SHAP-based decision evidence, uses an LLM to produce a clear explanation, and stores the result for audit purposes.

The project demonstrates how predictive models, policy-driven controls, explainable AI, and generative AI can be combined in a modular workflow. Its purpose is to support fair, transparent, deterministic, and traceable financial decision-making at local or prototype scale.

The intended developer is an individual with basic knowledge of Python, Generative AI, and Agentic AI. The planned implementation time is 20 hours across planning, development, explainability, testing, documentation, and final review.

The requirement document supplies the architecture and high-level behavior but does not supply the loan-application schema, ML model specification, policy rules, decision thresholds, LLM provider, audit-storage format, or expected output schema. These items are therefore marked as not specified and are not invented in this submission.

---

## 2. Problem Statement

Loan evaluation requires the combination of applicant information, predictive risk assessment, business rules, regulatory or compliance rules, a final decision, and an understandable explanation. A process that relies only on a predictive score may not enforce required policies. A process that relies only on fixed rules may not use predictive risk information. A process that produces a decision without an explanation may not provide sufficient transparency or auditability.

The project addresses this problem by defining an agent-based workflow in which each responsibility is assigned to a separate component:

- application ingestion and preprocessing;
- ML-based risk scoring;
- policy evaluation;
- final decision generation;
- SHAP-based explainability;
- LLM-based explanation generation;
- audit logging.

The resulting system is intended to produce consistent approval or rejection decisions together with evidence and explanations that can be traced across the complete workflow.

---

## 3. Project Objectives

The project objectives are:

1. Design an Agentic AI workflow for automated loan evaluation.
2. Apply ML models for credit risk scoring.
3. Enforce business and regulatory rules using a policy engine.
4. Generate explainable decisions using SHAP and LLMs.

No additional objectives are introduced.

---

## 4. Learning Outcomes

On completion of the project, the developer is expected to gain:

1. Understanding of AI-driven risk assessment systems.
2. Practical experience with explainable AI.
3. Exposure to policy-driven autonomous decision-making.

---

## 5. Functional Requirements

### 5.1 Ingest Loan Application Data

The system must ingest loan application data from files or APIs.

The specified file input is `loan_applications.csv`. API details are not specified.

### 5.2 Preprocess Applicant Features

The system must preprocess applicant features before model inference.

The feature names, preprocessing operations, missing-value rules, encodings, transformations, and validation rules are not specified.

### 5.3 Generate Risk Scores

The system must use a trained ML model to generate a risk score for each application.

The model algorithm, artifact type, inference interface, feature order, score range, and training procedure are not specified.

### 5.4 Apply Eligibility and Compliance Rules

The system must apply eligibility and compliance rules through a policy engine.

The required policy file is `policy_rules.yaml`. The rule schema and rule content are not specified.

### 5.5 Produce Approval or Rejection Decisions

The system must generate a final loan decision of either approval or rejection.

The decision threshold, conflict-resolution logic, and failure behavior are not specified.

### 5.6 Generate Explanation Reports

The system must use SHAP and an LLM to generate explanation reports.

SHAP is used to produce model-level contribution evidence. The LLM uses the decision context and evidence to create a clear explanation. The SHAP configuration, LLM provider, model, generation settings, and exact report format are not specified.

### 5.7 Store Decisions and Explanations

The system must store decisions and explanations for audit purposes.

The storage technology, path, schema, retention, and access controls are not specified.

---

## 6. Non-Functional Requirements

### 6.1 Python 3.x

The implementation must use Python 3.x. No exact minor version is specified.

### 6.2 Deterministic and Traceable Outputs

The system must make it possible to trace each result through ingestion, preprocessing, risk scoring, policy evaluation, decision generation, explainability, explanation generation, and audit logging.

Determinism depends on deterministic behavior in the selected model, policy logic, LLM configuration, and storage implementation. Their exact settings are not specified.

### 6.3 Explainability and Transparency

Every decision must have an explanation. The required explainability mechanism combines SHAP evidence with an LLM-generated explanation.

### 6.4 Modular Agent-Based Design

Each major responsibility must be implemented as a separate component so that the complete workflow remains readable, maintainable, and extensible.

### 6.5 Local or Prototype-Scale Execution

The implementation must be suitable for local or prototype-scale execution. Production infrastructure is outside the stated scope.

---

## 7. System Architecture Description

The architecture is a sequential agent-based workflow with seven required core components:

1. Application Ingestion Agent
2. Risk Scoring Agent
3. Policy Engine
4. Decision Agent
5. Explainability Agent
6. Explanation Generator using an LLM
7. Audit Logger

The Application Ingestion Agent receives the raw application. After preprocessing, the Risk Scoring Agent generates a risk score. The Policy Engine evaluates the same application against eligibility and compliance rules. The Decision Agent combines the required model and policy results according to project-specific decision logic. The Explainability Agent uses SHAP to generate contribution evidence. The Explanation Generator creates a human-readable explanation from the decision context. The Audit Logger stores the complete result.

### Logical Data Flow

```text
Loan Application
       |
       v
Application Ingestion Agent
       |
       v
Preprocessed Applicant Features
       |
       +----------------------+
       |                      |
       v                      v
Risk Scoring Agent       Policy Engine
       |                      |
       v                      v
Risk Score             Policy Results
       |                      |
       +----------+-----------+
                  |
                  v
             Decision Agent
                  |
                  v
        Approval or Rejection
                  |
          +-------+-------+
          |               |
          v               v
Explainability Agent   Explanation Generator
      (SHAP)                (LLM)
          |               |
          +-------+-------+
                  |
                  v
             Audit Logger
```

This diagram represents only the components and interactions stated in the requirement document.

---

## 8. Explanation of Every Architecture Component

### 8.1 Application Ingestion Agent

**Purpose:** Receive loan applications from a file or API and prepare them for processing.

**Responsibilities:**

- read records from `loan_applications.csv`;
- accept application data from an API when API details are supplied;
- validate that an application record is present;
- preprocess applicant features for model inference;
- pass the processed record to later components.

**Inputs:**

- loan application file or API data;
- preprocessing logic.

**Outputs:**

- processed applicant features.

**Not specified:**

- file columns;
- data types;
- API details;
- validation criteria;
- preprocessing steps.

### 8.2 Risk Scoring Agent

**Purpose:** Generate a credit-risk score using a trained ML model.

**Responsibilities:**

- receive preprocessed applicant features;
- send those features to the trained model;
- return the model-generated risk score;
- preserve the score for decision and explanation processing.

**Inputs:**

- preprocessed applicant features;
- trained ML model artifact.

**Outputs:**

- risk score.

**Not specified:**

- algorithm;
- model format;
- score range;
- inference method;
- feature order;
- training procedure.

### 8.3 Policy Engine

**Purpose:** Enforce eligibility and compliance rules independently from the predictive score.

**Responsibilities:**

- read the required `policy_rules.yaml` file;
- evaluate the application against configured rules;
- return policy outcomes and reasons;
- provide results to the Decision Agent.

**Inputs:**

- application information;
- `policy_rules.yaml`.

**Outputs:**

- eligibility and compliance results.

**Not specified:**

- YAML schema;
- actual rules;
- thresholds;
- rule priorities;
- conflict behavior.

### 8.4 Decision Agent

**Purpose:** Produce the final approval or rejection result.

**Responsibilities:**

- receive the risk score;
- receive policy results;
- apply the defined decision logic;
- return either `APPROVED` or `REJECTED`;
- retain decision context for explainability and audit.

**Inputs:**

- risk score;
- policy results;
- decision criteria.

**Outputs:**

- approval or rejection decision.

**Not specified:**

- approval threshold;
- model-policy precedence;
- borderline handling;
- failure handling;
- reason-code format.

### 8.5 Explainability Agent

**Purpose:** Generate model-contribution evidence using SHAP.

**Responsibilities:**

- receive the model and relevant application features through the supplied implementation;
- calculate SHAP evidence;
- return feature-level contribution information;
- make that evidence available to the LLM explanation stage.

**Inputs:**

- preprocessed features;
- trained ML model or explainer;
- `explainability_config.yaml`.

**Outputs:**

- SHAP-based evidence.

**Not specified:**

- SHAP explainer type;
- background dataset;
- feature mappings;
- output format;
- explainability configuration schema.

### 8.6 Explanation Generator

**Purpose:** Use an LLM to produce a clear explanation for the final decision.

**Responsibilities:**

- receive the final decision;
- receive risk-score information;
- receive policy results;
- receive SHAP evidence;
- combine the evidence with the configured prompt;
- return a clear explanation.

**Inputs:**

- decision context;
- SHAP evidence;
- prompt from `prompts/`;
- LLM generation function.

**Outputs:**

- explanation text.

**Not specified:**

- provider;
- model;
- authentication;
- parameters;
- response schema;
- deterministic generation settings.

### 8.7 Audit Logger

**Purpose:** Store decisions and explanations for audit purposes.

**Responsibilities:**

- receive the complete decision record;
- store the application context, score, policy results, final decision, SHAP evidence, and explanation;
- preserve traceability for later review.

**Inputs:**

- complete decision record;
- audit writer or storage implementation.

**Outputs:**

- stored audit record or storage confirmation.

**Not specified:**

- storage technology;
- file or database format;
- location;
- retention;
- access control;
- audit identifier format.

---

## 9. Complete Workflow Explanation

### Step 1: Receive Application Data

The Application Ingestion Agent receives an application from `loan_applications.csv` or an API. File ingestion is represented in the scaffold. API ingestion remains an injected function because no API is defined.

### Step 2: Preprocess Features

The application is passed to a supplied preprocessing function. This stage must produce the feature representation required by the trained model. No transformation is hard-coded because the required transformations are not specified.

### Step 3: Generate the Risk Score

The Risk Scoring Agent passes the processed application to the supplied trained-model scoring function. The returned score is validated as numeric. The code does not interpret the numeric direction or threshold because the score definition is not specified.

### Step 4: Evaluate Policies

The Policy Engine loads the raw contents of `policy_rules.yaml` and passes the application and policy text to the supplied policy evaluator. The evaluator must return policy results in dictionary form. No rule schema is invented.

### Step 5: Produce the Decision

The Decision Agent sends the risk score and policy results to the supplied decision function. The result is validated so that only `APPROVED` or `REJECTED` is accepted.

### Step 6: Generate SHAP Evidence

The Explainability Agent calls the supplied SHAP computation function with the processed application. The exact SHAP object, explainer, and output structure are left to the missing project specification.

### Step 7: Generate the Explanation

The Explanation Generator combines the decision, score, policy results, SHAP evidence, and prompt content. It passes that context to the supplied LLM generation function. The result must be non-empty text.

### Step 8: Create the Audit Record

The workflow creates one complete record containing:

- application data;
- processed application data;
- risk score;
- policy results;
- final decision;
- SHAP evidence;
- explanation.

### Step 9: Store the Audit Record

The Audit Logger passes the record to the supplied audit writer. The storage mechanism is intentionally not selected because the requirement document does not specify one.

### Step 10: Return the Result

The in-memory decision record is returned to the caller. The exact external output file format is not specified.

---

## 10. Activity Plan

The total planned duration is 20 hours.

### Phase 1: Planning and Data Preparation — 3 Hours

- define decision criteria and policies;
- prepare a sample loan application dataset.

The specific criteria, policies, and dataset fields must be supplied because they are not present in the requirement document.

### Phase 2: Core Agent Development — 7 Hours

- implement application ingestion and preprocessing;
- integrate the ML risk-scoring agent.

### Phase 3: Policy and Explainability Logic — 5 Hours

- implement the policy engine;
- integrate SHAP;
- implement explanation generation using an LLM.

### Phase 4: Testing and Refinement — 3 Hours

- validate decisions across scenarios;
- tune thresholds;
- refine explanations.

The scenarios, expected outcomes, thresholds, and explanation acceptance criteria are not specified.

### Phase 5: Documentation and Final Review — 2 Hours

- prepare the README;
- prepare the architecture summary;
- review the complete workflow.

---

## 11. Deliverables

### 11.1 Python Source Code

The source-code scaffold contains one module for each required architecture component and one workflow entry point.

### 11.2 Sample Datasets and Policies

The required input locations are provided. Actual sample data and policy values cannot be supplied without inventing applicant fields and decision rules.

### 11.3 Decision and Explanation Outputs

The workflow defines the required result structure in memory. Actual outputs require a configured model, policies, decision logic, SHAP implementation, LLM, and audit writer.

### 11.4 Documentation and Usage Guide

This document, the README, the architecture summary, source-code docstrings, and specification-gap document provide the required documentation.

---

## 12. Success Criteria

The project is successful when all of the following are demonstrated:

1. Loan decisions are accurate and consistent.
2. Explanations are clear and compliant.
3. The complete agentic workflow runs end to end.
4. The implementation is completed within 20 hours.
5. The design is extensible for future enhancements.

Measurement targets for accuracy, consistency, clarity, compliance, and extensibility are not specified.

---

## 13. Folder Structure

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

---

## 14. Module Descriptions

### `src/application_ingestion_agent.py`

Implements file ingestion through CSV reading. It provides injectable API and preprocessing interfaces for unspecified behavior.

### `src/risk_scoring_agent.py`

Implements the model-scoring contract without assuming a model framework or artifact format.

### `src/policy_engine.py`

Loads raw YAML policy text and delegates evaluation to supplied policy logic.

### `src/decision_agent.py`

Delegates decision logic and validates that the result is approval or rejection.

### `src/explainability_agent.py`

Delegates SHAP computation to the supplied SHAP implementation.

### `src/explanation_generator.py`

Builds explanation context and delegates text generation to the supplied LLM implementation.

### `src/audit_logger.py`

Delegates audit persistence to the supplied audit-storage implementation.

### `src/main.py`

Coordinates all required components in the correct order and returns the complete decision record.

---

## 15. File Descriptions

### `loan_applications.csv`

Required application input file. It is empty because the applicant schema is not specified.

### `model_artifacts/`

Required directory for trained-model artifacts. The included README lists unresolved model requirements.

### `policy_rules.yaml`

Required policy file. It contains comments documenting that the rule schema and values are not specified.

### `explainability_config.yaml`

Required SHAP/explainability configuration file. It contains comments documenting the missing configuration schema.

### `prompts/explanation_prompt.txt`

Requirement-aligned explanation prompt template. It instructs the LLM to explain the decision from supplied evidence without adding unsupported reasons.

### `outputs/`

Reserved location for decision and explanation outputs. The output format is not specified.

### `README.md`

Primary usage guide and repository overview.

### `CAPSTONE_DOCUMENTATION.md`

Complete project submission document.

### `SPECIFICATION_GAPS.md`

Consolidated record of missing implementation details.

### `docs/ARCHITECTURE_SUMMARY.md`

Concise architecture description.

---

## 16. Input and Output Explanation

### Inputs

The project identifies the following inputs:

- `loan_applications.csv`;
- application data from an API;
- trained model artifacts in `model_artifacts/`;
- policies in `policy_rules.yaml`;
- explainability settings in `explainability_config.yaml`;
- explanation prompts in `prompts/`.

The content schema of these inputs is not specified.

### Internal Processing Results

The workflow produces:

- processed application data;
- numeric risk score;
- policy-evaluation result;
- approval or rejection decision;
- SHAP evidence;
- LLM explanation.

### Outputs

The final logical output is a decision record containing all internal results and the original application context. The same record is sent to the audit logger.

The physical output format is not specified.

---

## 17. README Documentation

The repository README includes:

- project purpose;
- scope status;
- missing specifications;
- folder structure;
- input descriptions;
- component descriptions;
- execution behavior;
- output behavior;
- traceability explanation;
- scope-control statement.

---

## 18. Architecture Summary

The Automated Loan Approval Agent is a modular sequential workflow. Application data enters through the Application Ingestion Agent and is preprocessed. The Risk Scoring Agent produces an ML-based score, while the Policy Engine evaluates eligibility and compliance. The Decision Agent produces approval or rejection. The Explainability Agent produces SHAP evidence. The Explanation Generator uses an LLM to create a clear explanation. The Audit Logger stores the complete record.

The separation of responsibilities supports traceability, transparency, and future extensibility while remaining suitable for local or prototype-scale execution.

---

## 19. End-to-End Workflow Explanation

1. Load one application from file or API.
2. Validate and preprocess the application through supplied logic.
3. Generate a numeric risk score through the trained model.
4. Apply configured eligibility and compliance policies.
5. Combine score and policy results through supplied decision logic.
6. Validate that the result is `APPROVED` or `REJECTED`.
7. Generate SHAP evidence for the model result.
8. Build the explanation context.
9. Generate a clear explanation through the supplied LLM.
10. Assemble the complete decision record.
11. Pass the record to the audit logger.
12. Return the result to the caller.

This workflow contains no additional services or features beyond those named in the requirement document.

---

## 20. Professional Submission Statement

This capstone package provides a requirement-aligned architecture, modular Python source-code scaffold, input-file structure, explanation prompt, architecture documentation, workflow documentation, activity plan, deliverable mapping, and success-criteria mapping.

A fully operational implementation cannot be completed without adding assumptions because the requirement document does not define the applicant schema, model interface, policy rules, decision thresholds, SHAP configuration, LLM integration, audit-storage mechanism, or validation targets. The package therefore makes these dependencies explicit and prevents fabricated decisions or undocumented behavior.
