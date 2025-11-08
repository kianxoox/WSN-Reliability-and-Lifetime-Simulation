# ⚙️ Algorithm 1: Energy-Aware Multipath Adaptive Routing (EAMAR)

The **EAMAR** protocol enhances network reliability and lifetime by dynamically selecting multiple next hops based on node energy and distance to the sink.

---

## 🧠 Algorithm Steps

1. **Initialize**:
   - Deploy all sensor nodes randomly in the defined area.
   - Assign initial energy and node status (alive).
   - Define sink and source node positions.

2. **For each transmission round:**

   a. Identify all **neighbor nodes** within the communication range.  
   
   b. Compute each neighbor’s parameters:
   - `distance_score` = 1 − (distance_neighbor_to_sink / distance_current_to_sink)
   - `energy_score` = (residual_energy / initial_energy)
   
c. Compute the **final weighted score** for each neighbor:

   `final_score` = α × distance_score + (1 − α) × energy_score

d. Select the **top 2 nodes** with the highest `final_score` values as next hops.  

e. Transmit packets and update the **transmitter/receiver** energy levels.


3. **Update node states**:
   - Mark nodes as *dead* when their energy ≤ 0.
   - Record alive nodes and energy levels per round.

4. **Repeat** until:
   - All nodes are dead, or
   - The maximum number of simulation rounds is reached.

---

## 🧩 Output
- Packet Delivery Ratio (PDR)
- Average Residual Energy
- Network Lifetime (alive nodes per round)
