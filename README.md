<p align="center">
  <img src="assets/github_banner.png" alt="Dual-Engine 5G Energy Optimisation Banner" width="100%">
</p>

<br>

## By Mubanga Nsofu, University of East London

## Title: Towards Sustainable 5G Networks: A Dual Engine Framework Using Offline Reinforcement Learning and Surrogate-Based Optimisation

This repository contains the source code used for my MSc Data Science dissertation submitted as part of the DS7010 project.

The project investigates how offline reinforcement learning and surrogate-based optimisation can be applied to historical 5G network data to support energy-saving decisions in radio access networks. The framework combines a supervised learning surrogate model with offline reinforcement learning algorithms to evaluate potential energy-saving actions without requiring live interaction with the operational network.

---

## Project Overview

5G networks are becoming increasingly energy intensive due to network densification, massive MIMO deployments, and the use of higher frequency spectrum bands. Traditional energy saving approaches based on static rules or manual optimisation may not adapt well to changing traffic and network conditions.

This project proposes a dual engine framework:

- **Engine 1:** A supervised machine learning surrogate model used to estimate energy consumption.
- **Engine 2:** Offline reinforcement learning models trained on historical network data to optimise 5G energy saving in a safe manner.
- **Oracle Validation:** An independent validation model used to assess whether the proposed actions remain consistent with expected energy behaviour.

The framework is evaluated using historical 5G data from the ITU/Huawei AI/ML in 5G energy consumption modelling challenge hosted on Zindi.

---

## Repository Structure

```text
DS7010/
│
├── README.md
│
├── notebooks/
│   ├── 01_hyperparameter_tuning/
│   │   ├── README.md
│   │   └── hyperparameter_tuning.ipynb
│   │
│   └── 02_dual_engine_framework/
│   │   ├── README.md
│   │   └── dual_engine_framework.ipynb
│   └── 03_R_scripts/
│
├── data/
│   ├── README.md
│   └── datasets
│
├── outputs/
│   ├── figures/
│   ├── tables/
│   └── models/
│
├── requirements.txt
└── .gitignore
