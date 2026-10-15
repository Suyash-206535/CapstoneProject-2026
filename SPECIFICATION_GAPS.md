# Specification Gaps

The following details are required for a fully executable project but are not specified in the supplied Project Requirement Document.

## Data

- Applicant feature names
- Data types
- Required and optional fields
- Missing-value treatment
- Outlier handling
- Categorical encoding
- Numeric scaling or transformation
- File delimiter and encoding
- API endpoint, protocol, authentication, request structure, and response structure

## Machine-Learning Model

- Model algorithm
- Training dataset
- Target definition
- Training and validation method
- Model evaluation metric
- Risk-score range
- Feature order
- Model artifact file name
- Artifact serialization format
- Model-loading method
- Inference method
- Probability calibration

## Policy Engine

- YAML schema
- Eligibility rules
- Compliance rules
- Threshold values
- Rule priorities
- Mandatory rejection conditions
- Rule conflict resolution
- Missing-field behavior

## Decision Logic

- Risk threshold for approval
- Interaction between model score and policy result
- Handling of borderline applications
- Handling of model or policy failures
- Decision reason codes

## Explainability

- SHAP explainer type
- SHAP background or reference data
- Feature-name mapping
- Number of factors to include
- Positive and negative contribution presentation
- Explainability configuration schema

## LLM Explanation

- LLM provider
- LLM model
- Access method
- Authentication method
- Generation parameters
- Prompt variables
- Required response format
- Deterministic generation settings

## Audit Storage

- Storage technology
- Output path or connection details
- Record schema
- Unique application identifier
- Timestamp requirements
- Retention requirements
- Access controls
- Error handling

## Testing

- Test dataset
- Expected decisions
- Accuracy target
- Consistency checks
- Compliance scenarios
- Explanation acceptance criteria

No values or implementations for these items are invented in this project package.
