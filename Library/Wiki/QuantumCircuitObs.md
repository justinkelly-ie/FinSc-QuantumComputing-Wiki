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
import Stage0.Quantum.Circuit
import Stage1.Carrier.Vexel
import Stage1.Carrier.Maxel
import Stage1.Basis.Coordinate
import QuickCheck

%default total

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

||| Property 2: 2LTT Staged Single-Qubit MaxelN Gate Involutions
||| Verifies that Pauli-X, Pauli-Z, and Hadamard gates satisfy exact algebraic identities under staged unrolling.
export
prop_stagedMaxelGateInvolution : Bool
prop_stagedMaxelGateInvolution =
  auditPauliXInvolution && auditPauliZInvolution && auditHadamardSquare

||| Property 3: 2LTT Staged Two-Qubit Entanglement & Bell State Synthesizer
||| Verifies CNOT/SWAP self-inversion and pure |00> to entangled Bell state synthesis.
export
prop_stagedBellCircuitEntanglement : Bool
prop_stagedBellCircuitEntanglement =
  auditCNOTInvolution && auditSWAPInvolution && auditBellStateCircuit

||| Property 4: VexelN and MaxelN Multiset Conversion Round-Trip & Basis Consistency
export
prop_vexelMaxelBridge : Bool
prop_vexelMaxelBridge =
  let v2 = mkVexel2 (intToBoxInt 1) (intToBoxInt 0)
      vM = vexelNToVexel0 v2
      m2 = pauliXMaxel
      mM = maxelNToMaxel0 m2
  in (totalVexelMass vM == intToBoxInt 1) &&
     (lookupPixel (MkPixel 0 1) mM == intToBoxInt 1) &&
     (lookupPixel (MkPixel 1 0) mM == intToBoxInt 1)

||| Property 5: 2LTT Staged 3-Qubit Toffoli & Fredkin Multi-Qubit Gates
export
prop_stagedMultiQubitGates : Bool
prop_stagedMultiQubitGates =
  auditToffoliGateInvolution && auditFredkinGateInvolution
```


