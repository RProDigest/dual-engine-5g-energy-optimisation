# Dual-Engine Framework for Sustainable 5G Energy Optimisation

This repository contains the implementation of a dual-engine framework for optimising 5G network energy consumption using surrogate-based optimisation and offline reinforcement learning. The project was developed as part of the dissertation:

**Towards Sustainable 5G Networks: A Dual-Engine Framework Using Offline Reinforcement Learning and Surrogate-Based Optimization**

Author: **Mubanga Nsofu**

---

## Project Overview

5G radio access networks consume a large share of mobile network energy, especially as network densification, massive MIMO, and higher-frequency deployments increase operational complexity. Traditional rule-based energy-saving methods are often static and may not adapt well to changing traffic patterns.

This project evaluates whether historical 5G network data can be used to learn more energy-efficient policies without unsafe live-network exploration. The framework combines:

1. **Engine 1: XGBoost surrogate model**  
   A supervised learning model that estimates energy consumption from network state and configuration features.

2. **Engine 2: Offline reinforcement learning agents**  
   Offline RL algorithms trained on historical network data to recommend energy-saving control actions.

3. **Independent Oracle Judge**  
   A Random Forest model used as a separate evaluator to assess whether recommended policies reduce predicted energy consumption.

---

## Repository Contents

```text
.
├── DualEngineFramework.ipynb        # Main notebook for the dual-engine framework
├── BSinfo.csv                       # Base station information dataset
├── CLdata.csv                       # Cell-level hourly counters dataset
├── ECdata.csv                       # Energy consumption dataset
├── best_td3_plus_bc_params.json     # Optional tuned TD3+BC hyperparameters
├── best_iql_params.json             # Optional tuned IQL hyperparameters
├── best_cql_params.json             # Optional tuned CQL hyperparameters
├── d3rlpy_logs/                     # RL training logs and saved model checkpoints
├── fqe_logs/                        # Fitted Q-Evaluation logs
├── dissertation_plots/              # Exported dissertation figures
└── README.md
```

> Some folders and output files are generated when the notebook is executed.

---

## Data Source

The project uses the AI/ML for 5G energy consumption modelling dataset released through Zindi.

Reference:

> Zindi. (2023). *AI/ML for 5G energy consumption modelling: Data*.  
> https://zindi.africa/competitions/aiml-for-5g-energy-consumption-modelling/data

The notebook expects the following files to be available in the project root directory:

```text
BSinfo.csv
CLdata.csv
ECdata.csv
```

### Dataset Roles

| File | Purpose |
|---|---|
| `BSinfo.csv` | Contains base station configuration information. |
| `CLdata.csv` | Contains hourly cell-level counters, traffic load, and energy-saving mode indicators. |
| `ECdata.csv` | Contains hourly energy consumption values for base stations. |

---

## Methodology

The notebook follows a full machine learning and offline RL workflow.

### 1. Data Loading and Integration

The data module loads the three CSV files and merges them using common network identifiers and timestamps. The merged dataset is then sorted by time to preserve temporal order.

The main input files are:

```python
BSinfo.csv
CLdata.csv
ECdata.csv
```

### 2. Feature Engineering

The state and action spaces are defined as follows:

| Component | Variables |
|---|---|
| State features | `load`, `Hour`, `Frequency`, `Bandwidth` |
| Action features | `TXpower`, `Antennas`, `ESMode1`, `ESMode2`, `ESMode3`, `ESMode4`, `ESMode5`, `ESMode6` |
| Target | `Energy` |

The notebook applies:

- `StandardScaler` to state variables
- `MinMaxScaler` to action variables
- Normalised negative energy as the RL reward signal

The reward is designed so that lower energy consumption produces a better reward.

### 3. Temporal Holdout Strategy

The notebook uses a time-based validation strategy. The final 24 unique hourly periods are held out for evaluation, while earlier records are used for training.

This avoids random leakage across time and better reflects real deployment conditions.

### 4. Engine 1: XGBoost Surrogate Model

Engine 1 trains an XGBoost regression model to estimate energy consumption from state and action features. This model acts as a fast surrogate for testing candidate control actions.

The notebook generates several surrogate diagnostics, including:

- Calibration plot
- Residual diagnostics
- Residual distribution
- Actual-versus-predicted parity analysis

### 5. Engine 2: Offline Reinforcement Learning

The notebook trains and evaluates three offline RL algorithms using `d3rlpy`:

| Algorithm | Role |
|---|---|
| TD3+BC | Primary continuous-control offline RL policy |
| IQL | Implicit Q-Learning baseline |
| CQL | Conservative Q-Learning baseline |

The agents are trained using historical network observations, actions, and rewards without requiring live exploration on a production network.

### 6. Independent Oracle Evaluation

A Random Forest model is trained as an independent judge to evaluate recommended policy actions. This provides a separate check on the energy impact of each learned policy.

The oracle is used to compare:

- Historical baseline
- XGBoost surrogate policy
- TD3+BC policy
- IQL policy
- CQL policy

### 7. Statistical and Diagnostic Analysis

The notebook includes:

- Multi-seed evaluation
- Bootstrap uncertainty analysis
- Pairwise policy superiority matrix
- Performance profile curves
- Seed variance analysis
- Load sensitivity analysis
- Convergence speed analysis
- Explainable AI policy-tree distillation

---

## Main Results

The notebook produces dissertation-ready summary tables and plots. A representative holdout evaluation table from the notebook is shown below.

| Method | Mean Energy (kWh) | Site-Level Savings (%) | Total OPEX Savings (%) | Statistics |
|---|---:|---:|---:|---|
| Baseline (Historical) | 28.512 | 0.00 | 0.00 | — |
| Engine 1 — XGBoost Surrogate | 24.633 | 10.75 | 13.60 | — |
| Engine 2 — TD3+BC (Primary) | 17.701 | 32.23 | 37.92 | p = 0.00e+00, d = 1.18 |
| Engine 2 — IQL | 25.691 | 5.69 | 9.90 | p = 0.00e+00, d = 0.30 |
| Engine 2 — CQL | 25.897 | 3.25 | 9.17 | p = 0.00e+00, d = 0.37 |

In this run, **TD3+BC achieved the strongest energy reduction**, outperforming the XGBoost surrogate and the other offline RL baselines.

---

## Key Output Files

The notebook exports several figures and result tables, including:

```text
xgboost_calibration_actual_vs_pred.png
xgboost_residual_diagnostics.png
xgboost_residual_distribution.png
oracle_calibration_actual_vs_pred.png
oracle_residual_diagnostics.png
oracle_residual_distribution.png
learning_curve_multi_algo.png
boxplot_all_methods_improved.png
hourly_energy_pattern_with_cql.png
fig_5_03_td3bc_bootstrap.png
fig_5_04_iql_bootstrap.png
fig_5_03_cql_bootstrap.png
fig_5_05_performance_profile_ccdf_improved.png
fig_5_06_pairwise_superiority_matrix.png
fig_5_07_td3bc_convergence_speed.png
fig_5_08_iql_convergence_speed.png
fig_5_09_cql_convergence_speed.png
fig_5_10_td3bc_seed_variance.png
fig_5_11_iql_seed_variance.png
fig_5_10_cql_seed_variance.png
fig_5_12_xgboost_seed_variance.png
fig_5_13_td3bc_load_vs_savings.png
fig_5_14_iql_load_vs_savings.png
fig_5_133_cql_load_vs_savings.png
dissertation_results_table.csv
dissertation_results_table_v2.csv
rl_performance_report.csv
energy_savings_summary.csv
```

The notebook also exports explainability artefacts such as SVG decision-tree visualisations for policy interpretation.

---

## Installation

Create a Python environment and install the required packages.

```bash
pip install numpy pandas matplotlib seaborn scipy scikit-learn xgboost torch d3rlpy shap dtreeviz joblib
```

For Apple Silicon or GPU environments, install the appropriate PyTorch version for your machine before running the notebook.

---

## How to Run

1. Clone the repository.

```bash
git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
cd YOUR-REPOSITORY
```

2. Add the required data files to the repository root.

```text
BSinfo.csv
CLdata.csv
ECdata.csv
```

3. Add optional tuned hyperparameter files if available.

```text
best_td3_plus_bc_params.json
best_iql_params.json
best_cql_params.json
```

4. Open the notebook.

```bash
jupyter notebook DualEngineFramework.ipynb
```

5. Run the notebook from top to bottom.

The notebook will automatically create output folders such as:

```text
d3rlpy_logs/
fqe_logs/
dissertation_plots/
```

---

## Reproducibility

The notebook uses the following experimental seeds:

```python
[42, 123, 7, 2026, 99]
```

The configuration also detects the available compute device:

```python
cuda
mps
cpu
```

This allows the notebook to run on CUDA GPUs, Apple Silicon MPS, or CPU-only environments.

---

## Technical Stack

| Area | Libraries |
|---|---|
| Data processing | `pandas`, `numpy` |
| Machine learning | `scikit-learn`, `xgboost` |
| Offline reinforcement learning | `d3rlpy`, `torch` |
| Statistical analysis | `scipy`, `joblib` |
| Visualisation | `matplotlib`, `seaborn` |
| Explainability | `shap`, `dtreeviz` |

---

## Suggested GitHub Folder Structure

For a cleaner GitHub repository, the following structure is recommended:

```text
.
├── README.md
├── notebooks/
│   └── DualEngineFramework.ipynb
├── data/
│   ├── raw/
│   │   ├── BSinfo.csv
│   │   ├── CLdata.csv
│   │   └── ECdata.csv
│   └── processed/
├── configs/
│   ├── best_td3_plus_bc_params.json
│   ├── best_iql_params.json
│   └── best_cql_params.json
├── outputs/
│   ├── figures/
│   ├── tables/
│   └── models/
├── logs/
│   ├── d3rlpy_logs/
│   └── fqe_logs/
└── requirements.txt
```

If this folder structure is used, update the file paths in the notebook accordingly.

---

## Research Contribution

This project demonstrates a practical framework for applying offline reinforcement learning to 5G energy optimisation. The key contribution is the combination of:

- A supervised energy surrogate
- Offline RL policy learning
- Independent oracle validation
- Multi-seed statistical testing
- Explainable policy interpretation

The framework is designed for scenarios where live network exploration is unsafe, expensive, or operationally unacceptable.

---

## Citation

If you use this repository or build on the methodology, please cite the dissertation project and the original data source.

```text
Nsofu, M. (2026). Towards sustainable 5G networks: A twin-engine framework using offline reinforcement learning and surrogate-based optimization. University of East London.

Zindi. (2023). AI/ML for 5G energy consumption modelling: Data. https://zindi.africa/competitions/aiml-for-5g-energy-consumption-modelling/data
```

---

## Disclaimer

This repository is intended for academic research and reproducibility. The results depend on the dataset, preprocessing assumptions, holdout strategy, model configuration, and random seeds used in the notebook. The policies should not be deployed on a live network without further engineering validation, safety checks, and operator approval.
