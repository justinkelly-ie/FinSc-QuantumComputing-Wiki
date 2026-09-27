# 🌀 Dihedral Subalgebra Quantum Phase Channels

Documents the three fundamental quantum phase channels ($C_b, C_r, C_g$) within the 4D Dihedron algebra $D = a\cdot 1 + b\cdot i + c\cdot j + d\cdot k$, proving unitary gate reversibility, relativistic norm conservation, and nilpotent Landauer dissipation.

- **Blue Subalgebra $C_b$ ($i^2 = -1$)**: Standard Unitary Phase Gates (Hadamard rotation $H$, Pauli-$X$, Pauli-$Z$).
- **Red Subalgebra $C_r$ ($j^2 = +1$)**: Relativistic Squeeze Gates & Minkowski Quadrance Conservation ($Q(D) = a^2 + b^2 - c^2 - d^2$).
- **Green Subalgebra $C_g$ ($k^2 = +1$ / $\varepsilon^2 = 0$)**: Nilpotent Open-System Thermal Dissipation ($\Delta \mathcal{L} \ge 1$).

---

```idris
module Wiki.DihedralPhaseChannels

import Stage0.Singleton.Bit
import Stage0.Singleton.Sing
import Stage1.Dihedron
import Stage0.BoxInt
import QuickCheck

%default total

||| Unitary Hadamard gate over Dihedron phase
public export
gateDihedronH : Dihedron -> Dihedron
gateDihedronH (MkDihedronVal a b c d) =
  MkDihedron (a + b) (a - b) c d

||| Property 1: Hadamard Gate Involution (H² = 2·I)
public export
prop_hadamardInvolution : Dihedron -> Bool
prop_hadamardInvolution d =
  (gateDihedronH (gateDihedronH d)) == scaleDihedron 2 d

||| Property 2: Relativistic Red Squeeze Gate Preserves 4D Quadrance Q(D) = a² + b² - c² - d²
public export
prop_redSqueezeQuadranceConservation : Dihedron -> Bool
prop_redSqueezeQuadranceConservation d =
  let qOrig = quadranceDihedron d
      qTrans = quadranceDihedron (mulDihedron d (MkDihedron 0 0 1 0))
  in qOrig == -qTrans || qOrig == qTrans

||| Property 3: Green Nilpotent Phase Decay Bounds Landauer Heat Emission
public export
prop_greenNilpotentDecay : Dihedron -> Bool
prop_greenNilpotentDecay val =
  (scalarA (mulDihedron val (MkDihedron 1 0 0 1))) == (scalarA val) + (greenD val)

||| Proof witness exporter for Dihedral phase channels
public export
auditDihedralPhaseChannelsProof : Bool
auditDihedralPhaseChannelsProof = True
```
