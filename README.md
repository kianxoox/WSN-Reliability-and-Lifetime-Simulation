# 🛰️ WSN Reliability and Lifetime Simulation

[![Made with MATLAB](https://img.shields.io/badge/Made%20with-MATLAB-orange?style=for-the-badge&logo=mathworks)](https://www.mathworks.com)
[![Project Type](https://img.shields.io/badge/Type-Research-blue?style=for-the-badge)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)]()

---

## 🧭 Overview
This project simulates the performance of **Wireless Sensor Networks (WSN)** under both baseline and custom routing protocols to analyze their impact on **network reliability**, **energy efficiency**, and **lifetime**.

It implements a **Minimum Energy Routing (MER)** protocol as the realistic baseline and a **proposed Energy-Aware Multipath Adaptive Routing (EAMAR)** protocol that enhances reliability and network lifetime through energy-balanced multipath transmission.

---

## ⚙️ Features
- Realistic random node deployment within a configurable 2D network area  
- Energy model-based transmission and reception using standard radio parameters  
- Two routing protocols:
  - **Baseline (MER)** – Minimum Energy Routing for realistic energy optimization  
  - **Custom (EAMAR)** – Energy-Aware Multipath Adaptive Routing for improved reliability  
- Multipath redundancy for higher packet delivery ratio (PDR)  
- Visualization of key metrics:
  - Network Lifetime (Alive Nodes per Round)
  - Packet Delivery Ratio (PDR)
  - Average Residual Energy per Round

---

## 🧠 Implementation Details
Developed in **MATLAB** using the standard radio energy model equations:

\[
E_{tx} = E_{elec} \times k + E_{amp} \times k \times d^2
\]  
\[
E_{rx} = E_{elec} \times k
\]

The simulation randomly deploys sensor nodes across a defined area, assigns a source and sink, and runs for multiple rounds while updating node energies, packet deliveries, and statuses.  
The proposed **EAMAR** protocol dynamically selects up to two optimal next hops based on a weighted score combining **distance improvement** and **residual energy**, resulting in higher reliability and extended network lifetime compared to MER.

---

## ⚡ Key Parameters
| Parameter | Description | Default |
|------------|-------------|----------|
| `numNodes` | Number of sensor nodes | 50 |
| `networkArea` | WSN area in meters | [100, 100] |
| `initialEnergy` | Initial node energy (Joules) | 0.2 |
| `commRange` | Communication range (meters) | 25 |
| `alpha_weight` | Weight for distance vs energy scoring | 0.8 |
| `numRounds` | Number of simulation rounds | 2000 |

---

## 📈 Expected Results
- Higher **Packet Delivery Ratio (PDR)** under EAMAR than MER  
- Slower decrease in number of alive nodes per round  
- More balanced energy consumption across the network  
- Slightly higher total energy use offset by improved reliability  

---

## 🧪 How to Run
1. Open **MATLAB R2021b or later**  
2. Place all files in the same working directory  
3. Run the main simulation script:
   ```matlab
   >> main
   
---

## 📊 Results Visualization
The simulation automatically generates three key performance plots:

- **Network Lifetime** — Alive nodes vs simulation rounds  
- **Protocol Reliability** — Packet Delivery Ratio (PDR) comparison between MER and EAMAR  
- **Average Residual Energy** — Remaining energy trend across all nodes per round  

These visualizations help assess:
- Energy consumption behavior  
- Reliability over time  
- Network stability before total energy depletion  

---

## 🧰 Technologies Used
- **Language:** MATLAB (R2021b or later)  
- **Energy Model:** Standard Radio Energy Model  
  - \(E_{tx} = E_{elec} \times k + E_{amp} \times k \times d^2\)
  - \(E_{rx} = E_{elec} \times k\)  
- **Deployment:** Monte Carlo random node placement  
- **Visualization:** MATLAB plotting & figure comparison  

---

## 🧩 Future Work
- Add **clustering-based routing** (LEACH or PEGASIS) as new baselines  
- Integrate **link quality metrics (RSSI/SNR)** for link-aware reliability  
- Introduce **adaptive α-weighting** for dynamic energy–distance balancing  
- Extend simulation to **hardware-in-the-loop (IoT) experiments**  
- Implement **probabilistic multipath selection** to optimize energy use  

---

## 🪪 License
This project is released under the **MIT License** for research and educational purposes.

---

## 👨‍💻 Author
**Ilakkian B**  
Amrita Vishwa Vidyapeetham, Bangalore  
📧 [ilakkian.bv@gmail.com](mailto:ilakkian.bv@gmail.com)  
🔗 [LinkedIn](https://www.linkedin.com/in/ilakkian-b-795501345/)

---

## 🏷️ Tags
`#MATLAB` `#Wireless-Sensor-Network` `#Energy-Efficient-Routing`  
`#Reliability` `#Multipath-Routing` `#Simulation` `#Research`

