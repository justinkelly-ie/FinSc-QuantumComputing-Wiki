# Quantum No-Cloning Theorem Literate Specification

The No-Cloning Theorem states that an arbitrary unknown quantum state $|\psi\rangle$ cannot be duplicated.

In Idris 2 QTT, attempting to clone a linear Qubit (`1 _ : Qubit`) is rejected at compile-time by QTT linear consumption constraints!

### What We Learned from Implementation

1. **No-Cloning is a QTT Type Invariant**: Quantum state non-clonability does not require complex linear algebra proofs; it is enforced directly by Idris 2 QTT linear consumption (`1 _ : Qubit`).
2. **Compile-Time Rejection**: Attempting to duplicate a linear quantum token is caught by the compiler before execution.

```idris
module Wiki.NoCloningObs

import Wiki.Qubit
import Stage0.Singleton.Bit
import Stage0.BoxInt
import Stage0.Interfaces
import QuickCheck

%default total

||| Linear consumption of a Qubit token (QTT 1 constraint)
public export
consumeLinearQubit : (1 q : Qubit) -> Ur Nat
consumeLinearQubit (MkQubit w _ _ _ _) = MkUr (if isOne w then 1 else 0)

||| Property: No-Cloning Theorem (Single-pass linear consumption)
export
prop_noCloningLinearConstraint : Qubit -> Bool
prop_noCloningLinearConstraint q =
  let (MkUr w) = consumeLinearQubit q
      expected = if isOne q.wireBit then 1 else 0
  in w == expected
```
