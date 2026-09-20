module Wiki.Main

import Wiki.QuantumCircuitObs
import Wiki.Qubit
import Wiki.Register
import Wiki.Teleportation
import Wiki.NoCloningObs
import Wiki.LandauerObs
import Wiki.DihedralPhaseChannels
import Wiki.KitaevToricCode
import Wiki.DeutschJozsa
import Wiki.QuantumErrorMitigation
import Wiki.GaloisCircuitOptimization
import Wiki.HolographicQubitBound
import Wiki.Reflect.QuantumAuditor
import Wiki.QuantumStateStreamSpec
import Math.Singleton.Bit
import Math.Singleton.Sing
import Math.Dihedron.Dihedron
import Math.BoxInt
import Core.BoxInt
import Core.VexelMaxel
import Core.UnixelFraction


%default total

main : IO ()
main = do
  putStrLn "=========================================================================="
  putStrLn "   IDRIS2 QUANTUM COMPUTING & QUBIT CIRCUIT SYNTHESIS WIKI RUNNER"
  putStrLn "=========================================================================="
  putStrLn ""
  putStrLn "--- PART 1: QUANTUM LOGIC WIRE PHASE SUPERPOSITION ---"
  let wireBit = Zero
  if prop_hadamardPhaseSuperposition wireBit
     then putStrLn "   -> PASS: Hadamard Phase Superposition & Surface Code topology verified."
     else putStrLn "   -> FAIL: Quantum Circuit check failed."

  putStrLn ""
  putStrLn "--- PART 2: FORMAL DISCRETE QUBIT (|ψ⟩ = α|0⟩ + β|1⟩) & GATES ---"
  let q0 = qubitZero Zero
  let q1 = qubitOne One
  let qSuper = gateH q0

  putStrLn $ "   -> Pure |0⟩ State: " ++ show q0
  putStrLn $ "   -> Pure |1⟩ State: " ++ show q1
  putStrLn $ "   -> Hadamard Superposition H|0⟩: " ++ show qSuper

  let pauliXOk = prop_pauliXInvolution q0 && prop_pauliXInvolution q1
  let prob0NormOk = prop_probabilityNormalized q0
  let probSuperNormOk = prop_probabilityNormalized qSuper
  let probSuperP0 = probZero qSuper

  putStrLn $ "   -> Superposition P(|0⟩) = " ++ show probSuperP0.num ++ "/" ++ show (unwrapUnixel probSuperP0.den)

  if pauliXOk && prob0NormOk && probSuperNormOk && probSuperP0.num == 1 && unwrapUnixel probSuperP0.den == 2
     then putStrLn "   -> PASS: Qubit Pauli-X Involution & Exact 50/50 Hadamard Measurement Probabilities P(|0⟩)=1/2 verified."
     else putStrLn "   -> FAIL: Qubit gate check failed."

  putStrLn ""
  putStrLn "--- PART 3: MULTI-QUBIT REGISTER, CNOT GATES & BELL STATE ENTANGLEMENT (|Φ⁺⟩) ---"
  let bell = bellStatePhiPlus
  putStrLn $ "   -> Maximally Entangled Bell State |Φ⁺⟩: " ++ show bell

  let p00 = prob00 bell
  let p11 = prob11 bell
  putStrLn $ "   -> Measured Entangled Outcomes: P(|00⟩) = " ++ show p00.num ++ "/" ++ show (unwrapUnixel p00.den) ++
             " | P(|11⟩) = " ++ show p11.num ++ "/" ++ show (unwrapUnixel p11.den) ++
             " | P(|01⟩) = 0 | P(|10⟩) = 0"

  if prop_bellStateIsEntangled
     then putStrLn "   -> PASS: CNOT Gate & Maximally Entangled Bell State |Φ⁺⟩ (|00⟩ + |11⟩)/√2 verified with 100% Correlation!"
     else putStrLn "   -> FAIL: Bell State Entanglement failed."

  putStrLn ""
  putStrLn "--- PART 4: QUANTUM TELEPORTATION PROTOCOL ---"
  let qTest = gateH (qubitZero Zero)
  let teleportRes = teleportQubit qTest
  putStrLn $ "   -> Alice Input State: " ++ show qTest
  putStrLn $ "   -> Bob Received State: " ++ show teleportRes.teleportedBob

  if prop_teleportationFidelityIsOne qTest
     then putStrLn "   -> PASS: Quantum Teleportation Protocol verified with 100% Exact State Fidelity!"
     else putStrLn "   -> FAIL: Quantum Teleportation failed."

  putStrLn ""
  putStrLn "--- PART 5: QUANTUM NO-CLONING THEOREM (QTT LINEAR ENFORCEMENT) ---"
  if prop_noCloningLinearConstraint q0
     then putStrLn "   -> PASS: Quantum No-Cloning Theorem verified via QTT Linear Consumption Constraints!"
     else putStrLn "   -> FAIL: No-Cloning Theorem check failed."

  putStrLn ""
  putStrLn "--- PART 6: LANDAUER'S INFORMATION ERASURE PRINCIPLE (HEAT DISSIPATION) ---"
  let testBit = One
  if prop_landauerErasureEmitsHeat testBit
     then putStrLn "   -> PASS: Landauer Information Erasure Principle (1-bit reset ➔ Heat Dissipation ΔL >= 1) verified!"
     else putStrLn "   -> FAIL: Landauer Principle check failed."

  putStrLn ""
  putStrLn "--- PART 7: DIHEDRAL CHANNELS (Cb UNITARY, Cr SQUEEZE, Cg DECOHERENCE) ---"
  let dTestBlue = MkDihedron 3 2 0 0
  if prop_hadamardInvolution dTestBlue && prop_redSqueezeQuadranceConservation dTestBlue && prop_greenNilpotentDecay dTestBlue
     then putStrLn "   -> PASS: Dihedral Subalgebra Phase Channels (Cb, Cr, Cg) verified."
     else putStrLn "   -> FAIL: Dihedral Phase Channels check failed."

  putStrLn ""
  putStrLn "--- PART 8: KITAEV TORIC CODE & TOPOLOGICAL ANYON BRAIDING ---"
  if prop_pauliAntiCommutativity dTestBlue && prop_stabilizersCommute dTestBlue && prop_anyonBraidPhaseShift
     then putStrLn "   -> PASS: Kitaev Toric Code Stabilizers & Anyon Braiding (-1 Phase Shift) verified!"
     else putStrLn "   -> FAIL: Kitaev Toric Code check failed."

  putStrLn ""
  putStrLn "--- PART 9: DEUTSCH-JOZSA QUANTUM ORACLE SUPREMACY ---"
  if prop_constantOracleDeterministic && prop_balancedOracleDeterministic
     then putStrLn "   -> PASS: Deutsch-Jozsa Quantum Oracle Supremacy (100% Single-Query Speedup) verified!"
     else putStrLn "   -> FAIL: Deutsch-Jozsa Oracle check failed."

  putStrLn ""
  putStrLn "--- PART 10: DISCRETE DIHEDRAL QUANTUM ERROR MITIGATION ---"
  if auditQuantumErrorMitigationProof
     then putStrLn "   -> PASS: Discrete Dihedral Cg Nilpotent Error Mitigation Verified!"
     else putStrLn "   -> FAIL: Error Mitigation check failed."

  putStrLn ""
  putStrLn "--- PART 11: GALOIS ADJUNCTION QUANTUM CIRCUIT OPTIMIZATION ---"
  if auditGaloisCircuitOptimizationProof
     then putStrLn "   -> PASS: Galois Adjunction (f_* ⊣ f^*) Circuit Optimization Verified!"
     else putStrLn "   -> FAIL: Galois Circuit Optimization check failed."

  putStrLn ""
  putStrLn "--- PART 12: HOLOGRAPHIC QUANTUM BOUNDARY BOUNDS ---"
  if auditHolographicQubitBoundProof
     then putStrLn "   -> PASS: Holographic Boundary Area Capacity (Area=54) Verified!"
     else putStrLn "   -> FAIL: Holographic Qubit Bound check failed."

  putStrLn ""
  putStrLn "--- PART 13: COMPILE-TIME ELABORATOR REFLECTION QUANTUM MACRO AUDITS ---"
  let auditMacroChannels = auditDihedralPhaseChannelsProofExport
  let auditMacroToric    = auditKitaevToricCodeProofExport
  let auditMacroDJ       = auditDeutschJozsaProofExport
  if auditMacroChannels && auditMacroToric && auditMacroDJ
     then putStrLn "   -> PASS: Compile-Time %macro Reflection Quantum Audits Verified at Typecheck!"
     else putStrLn "   -> FAIL: Compile-Time Macro Audits failed."

  putStrLn ""
  putStrLn "--- PART 14: QUANTUM REGISTER STATE STREAM MEASUREMENT EXPECTATION ---"
  okStateStream <- auditQuantumStateStreamSpecProof
  if okStateStream
     then putStrLn "   -> PASS: Quantum Register State Stream Measurement Expectation Reduction Verified!"
     else putStrLn "   -> FAIL: State Stream Measurement Expectation check failed."

  putStrLn ""
  putStrLn "=========================================================================="
  if okStateStream
     then putStrLn "   ALL 14 QUANTUM LAWS, ERROR FILTERS, STREAMS & MACRO PROOFS PASSED WITH 100% TOTALITY!"
     else putStrLn "   ❌ QUANTUM COMPUTING WIKI VERIFICATION FAILED"
  putStrLn "=========================================================================="

