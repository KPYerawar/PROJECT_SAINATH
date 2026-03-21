# 🧠 Systolic Array Basics

## 📌 1. What is Systolic Array?

A systolic array is a hardware architecture used for parallel computation where data flows through a grid of processing elements (PEs).

---

## 📌 2. Why do we need Systolic Array?

Normal computation is slow because operations are done one after another (serial).

In AI workloads like transformers:

* Large matrix multiplications are required
* High speed is needed

Systolic array enables:

* Parallel computation
* Faster processing
* Efficient hardware utilization

---

## 📌 3. Processing Element (PE)

Each block in systolic array is called a Processing Element.

Each PE performs:

* Multiply
* Accumulate

This is called MAC (Multiply-Accumulate)

---

## 📌 4. MAC Operation

Output = (A × B) + Previous Sum

This is the basic operation used in matrix multiplication.

---

## 📌 5. Data Flow

* Matrix A flows from left to right
* Matrix B flows from top to bottom

Each PE:

* Receives data
* Performs multiplication
* Passes data to next PE

---

## 📌 6. Key Advantages

* High parallelism
* Faster than CPU-based computation
* Suitable for AI and ML workloads
* Used in modern hardware accelerators (TPU, GPU)

---

## 📌 7. Summary

Systolic array is a grid of MAC units where data flows rhythmically to perform fast matrix multiplication.

