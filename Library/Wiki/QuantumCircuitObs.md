# Quantum Circuit Synthesis Literate Observation

Documents quantum logic wire geometry (`Bit` Boolean Singletons), 4D Dihedral phase superpositions, and toric surface code topology (`ToroidalBackend`).

### What We Learned from Implementation

1. **Boolean Singletons**: Replacing custom wire records with `Bit` (`Zero` and `One`) integrates quantum logic directly into von Neumann bification singletons.

```idris
module Wiki.QuantumCircuitObs

import Stage0.Singleton.Bit
import Stage0.Singleton.Sing
import Stage1.Dihedron
import Stage0.BoxInt
import Stage1.UnixelFraction
import QuickCheck

%default total

public export
record WaveToken where
  constructor MkWaveToken
  pixelPosition : Bit
  amplitude     : Stage0.BoxInt.BoxInt
  phase         : Dihedron

public export
interfereWaves : WaveToken -> WaveToken -> WaveToken
interfereWaves (MkWaveToken p1 a1 ph1) (MkWaveToken p2 a2 ph2) =
  let combinedPhase = addDihedron ph1 ph2
      effAmp = if ph1 == negDihedron ph2 then MkBoxInt (abs (a1.value - a2.value)) else a1 + a2
  in MkWaveToken p1 effAmp combinedPhase

||| Property 1: Quantum Hadamard Phase Superposition
||| Applying a 90-degree Dihedral phase rotation to a Zero qubit creates a superposition state.
export
prop_hadamardPhaseSuperposition : Bit -> Bool
prop_hadamardPhaseSuperposition wireBit =
  let zeroStatePhase = MkDihedron 1 0 0 0
      hadamardPhase  = MkDihedron 0 1 0 0 -- i phase rotation
      q0 = MkWaveToken wireBit 1 zeroStatePhase
      qH = MkWaveToken wireBit 1 hadamardPhase
      interfered = interfereWaves q0 qH
  in interfered.amplitude == 2
```
