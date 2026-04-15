# 🚀 Project SAINATH
**Systolic Attention Intelligence Network Accelerator for Transformer Hardware**

*A custom RTL-level AI hardware accelerator designed by a VLSI enthusiast to execute the core mechanism of Large Language Models (Transformers).*

---

## 📌 Overview
Project SAINATH bridges the gap between deep learning algorithms and physical VLSI hardware. Instead of relying on general-purpose CPUs, this project implements a domain-specific architecture (DSA) featuring a custom Systolic Array to compute the $Q \times K^T$ attention mechanism in massive parallel, targeting high-throughput and low-latency edge AI inference.

## ⚡ Current Progress: Phase 1 Completed
**Status:** Functional 2x2 Systolic Array Core designed, pipelined, and verified.

### Core Modules Implemented:
* **Processing Element (`mac`):** A custom Multiply-Accumulate (MAC) unit with single-cycle accumulation and synchronized data forwarding.
* **Systolic Array Engine (`systolic_2x2`):** A rhythmic, parallel grid of PE units wired to execute concurrent matrix multiplication without data collision.
* **Dataflow Controller (`valid_fsm`):** A finite state machine that handles memory fetching (`$readmemh`), skewing, and precise cycle-by-cycle data feeding into the array.
* **Verification Environment:** Complete cycle-accurate testbench verifying the accumulation results.

## 🧠 Hardware Architecture Mapping
* **Target Operation:** Self-Attention Core Math ($Q \times K^T$).
* **Hardware Paradigm:** 2D Systolic Array (TPU-style architecture).
* **Data Propagation:** Matrix A flows horizontally (Left $\rightarrow$ Right), Matrix B flows vertically (Top $\rightarrow$ Bottom), while intermediate sums accumulate in-place.

## 🛠️ Tech Stack & Tools
* **Design Language:** Verilog (RTL)
* **Simulation & Verification:** Icarus Verilog (`iverilog`)
* **Waveform Analysis:** GTKWave

## 📂 Repository Structure
```text
Project-SAinath/
│
├── docs/                # Architecture notes and LLM-to-Hardware theory
├── rtl/                 # Verilog source codes (PE, Array, FSM)
├── sim/                 # Testbenches and simulation data
├── results/             # VCD waveforms and output logs
└── README.md
