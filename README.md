# Automated Planning Engine: Heuristic Search & State-Space Optimization

A PDDL-based automated planning engine designed to solve complex, multi-agent logistical and scheduling problems. The models are solved using the Fast Downward planning system, focusing heavily on mitigating combinatorial explosions through heuristic search and strict state-space reduction techniques.

### Tech Stack
PDDL (Planning Domain Definition Language), Fast Downward, $A^*$ Search, LM-cut Heuristics, LAMA-2011.

### Algorithmic & Engineering Highlights
* **Symmetry Breaking & State-Space Reduction:** Tackled exponential branching factors in multi-agent environments by enforcing strict lexicographical ordering constraints between interchangeable agents. 
* **Dimensionality Reduction:** Re-architected multi-agent traversal actions by grouping individuals into a single macro-entity, reducing action parameters from 7 down to 2. This optimization slashed the $A^*$ search time from nearly 12 minutes (698 seconds) to under 1 minute for complex states.
* **Axiom & Quantifier Optimization:** Redesigned domain logic to avoid existential quantifiers (`exists`) in goal states, triggering direct boolean predicates instead. This prevented the generation of derived axioms, maintaining strict compatibility with optimal heuristic algorithms like `seq-opt-lmcut`.
* **Anytime Cost Optimization:** Implemented custom metric functions for non-uniform traversal weights, utilizing the `seq-sat-lama-2011` algorithm to rapidly find initial valid plans and iteratively minimize the total cumulative cost.
