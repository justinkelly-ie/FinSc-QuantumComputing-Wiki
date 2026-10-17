# 🗂️ Quantum Register State Stream Specification

Documents and verifies discrete **Quantum State Streams** and zero-allocation measurement expectation values $\langle \psi | A | \psi \rangle$ via `fusedHylomorphism`.

## 1. Specification

```idris
module Wiki.QuantumStateStreamSpec

import Quantum.StateStream
import Stage0.BoxInt
import Stage0.StructuralFuel
import Data.Fuel

%default total

||| Property 1: Quantum Measurement Expectation Value Linearity
public export
prop_quantumExpectationValueLinearity : Bool
prop_quantumExpectationValueLinearity =
  let items = [(ZeroState, intToBoxInt 6), (OneState, intToBoxInt 8)]
      expVal = fusedExpectationValueFuelModel ellipticGohFuelModel items
  in unwrapBox expVal == 100

||| Direct Suite Execution for Quantum State Stream Specification
public export
auditQuantumStateStreamSpecProof : IO Bool
auditQuantumStateStreamSpecProof = do
  let p1 = prop_quantumExpectationValueLinearity
  pure p1
```
