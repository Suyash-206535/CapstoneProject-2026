# Llama 3 Setup for the Loan Approval Dashboard

## Integration choice

The dashboard uses **Llama 3 8B through a local Ollama server**. Llama 3 is used only by the Explanation Generator after the risk model, policy engine, SHAP component, and Decision Agent have already produced the authoritative result.

Llama 3 does not calculate the risk probability, apply policy rules, or approve/reject an application.

## 1. Install Ollama

Install Ollama on the same machine that will run the dashboard. After installation, open a new terminal so the `ollama` command is available.

## 2. Download Llama 3

### Windows

Double-click:

```text
setup_llama3.bat
```

Or run manually:

```powershell
ollama pull llama3:8b
```

### Linux or macOS

```bash
chmod +x setup_llama3.sh
./setup_llama3.sh
```

Or run manually:

```bash
ollama pull llama3:8b
```

## 3. Confirm the model

```bash
ollama list
```

The output should contain `llama3:8b` or a compatible `llama3` tag.

You can test the model directly:

```bash
ollama run llama3:8b
```

Type a message, confirm that it responds, and then exit with `/bye`.

## 4. Start the dashboard

### Windows

```text
run_dashboard.bat
```

### Linux or macOS

```bash
./run_dashboard.sh
```

Manual command:

```bash
python -m streamlit run dashboard.py
```

Open:

```text
http://localhost:8501
```

## 5. Select Llama 3

In the dashboard sidebar:

1. Set **Provider** to `Llama 3 via Ollama`.
2. Keep **Ollama base URL** as `http://localhost:11434` when Ollama runs locally.
3. Keep **Model** as `llama3:8b`.
4. Click **Test Llama 3 connection**.
5. Run a single application or batch.

## Generation settings

The default integration uses:

```text
temperature = 0.0
seed = 42
maximum output tokens = 450
request timeout = 180 seconds
```

These settings reduce variation and keep explanations concise. They do not make an LLM mathematically deterministic.

## Environment variables

The defaults can be changed before launching Streamlit:

### Windows PowerShell

```powershell
$env:OLLAMA_BASE_URL = "http://localhost:11434"
$env:OLLAMA_MODEL = "llama3:8b"
python -m streamlit run dashboard.py
```

### Linux or macOS

```bash
export OLLAMA_BASE_URL="http://localhost:11434"
export OLLAMA_MODEL="llama3:8b"
python -m streamlit run dashboard.py
```

## Troubleshooting

### `ollama` is not recognised

Ollama is not installed or the terminal was opened before installation. Install it and open a new terminal.

### Cannot connect to `localhost:11434`

Start Ollama. On systems where the service is not already running:

```bash
ollama serve
```

Keep that terminal open, then launch the dashboard from another terminal.

### Model is not installed

```bash
ollama pull llama3:8b
```

### Request times out

The first request loads the model and can be slower. Increase the timeout in the dashboard sidebar. Close other GPU-heavy applications if memory is constrained.

### Dashboard is running in WSL but Ollama is on Windows

First try `http://localhost:11434`. If that fails, use the Windows host address accessible from WSL as the Ollama base URL.

## Audit behaviour

Every successful audit record stores:

```text
llm_provider: ollama
llm_model: llama3:8b
```

The explanation prompt instructs Llama 3 to use only the supplied decision evidence. The adapter also checks that the generated text does not replace the authoritative Decision Agent result.

## Scope warning

The risk model and policies in this package are synthetic demonstrations. Adding a real LLM does not make the project suitable for real lending decisions.
