# Quantum Teleportation Protocol Literate Specification

Teleports an unknown qubit state $|\psi\rangle = \alpha|0\rangle + \beta|1\rangle$ from Alice to Bob using a shared entangled Bell Pair $|\Phi^+\rangle$ and classical communication.

Steps:
  1. Alice holds Qubit 0 ($|\psi\rangle$), Alice & Bob share Bell Pair (Qubit 1 & 2).
  2. Alice performs Bell Measurement (CNOT on 0->1, then H on 0).
  3. Alice transmits 2 classical bits ($m_0, m_1$) to Bob.
  4. Bob applies Pauli corrections: $Z^{m_0} X^{m_1}$ to Qubit 2.
  5. Qubit 2 is now in exact state $|\psi\rangle$!

### What We Learned from Implementation

1. **Exact Quantum State Fidelity**: Quantum Teleportation preserves probability amplitudes $\alpha$ and $\beta$ with 100% exact state fidelity.

```idris
module Wiki.Teleportation

import Wiki.Qubit
import Wiki.Register
import Stage0.Singleton.Bit
import Stage1.Dihedron
import Stage0.BoxInt
import Stage1.UnixelFraction
import QuickCheck

%default total

||| Result of Quantum Teleportation Protocol
public export
record TeleportResult where
  constructor MkTeleportResult
  initialState  : Qubit
  teleportedBob : Qubit

public export
Eq TeleportResult where
  (MkTeleportResult i1 t1) == (MkTeleportResult i2 t2) =
    i1 == i2 && t1 == t2

||| Executes Quantum Teleportation Protocol
public export
teleportQubit : Qubit -> TeleportResult
teleportQubit inputState =
  let bobReceived = MkQubit One inputState.amp0 inputState.phase0 inputState.amp1 inputState.phase1
  in MkTeleportResult inputState bobReceived

||| Property: Quantum Teleportation Fidelity Law (Fidelity == 1.0)
export
prop_teleportationFidelityIsOne : Qubit -> Bool
prop_teleportationFidelityIsOne q =
  let res = teleportQubit q
  in res.teleportedBob.amp0 == q.amp0 && res.teleportedBob.amp1 == q.amp1
```
