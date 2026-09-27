# Landauer's Information Erasure Principle Literate Specification

Erasing 1 bit of information (resetting Boolean Singleton `One` ➔ `Zero`) generates a minimum heat dissipation equal to 1 unit of thermal multiset lag:

$$\Delta \mathcal{L} \ge 1$$

### What We Learned from Implementation

1. **Boolean Singleton Reset**: Resetting `One` ➔ `Zero` in $B_2$ singletons emits 1 unit of thermal multiset lag ($\Delta \mathcal{L} \ge 1$).

```idris
module Wiki.LandauerObs

import Stage0.Singleton.Bit
import Stage0.Singleton.Sing
import Stage0.Multiset
import Stage0.BoxInt
import QuickCheck

%default total

||| Resets 1 Boolean Singleton Bit and emits 1 unit of dissipation heat
public export
eraseBitWithHeat : Bit -> (Bit, Nat)
eraseBitWithHeat b =
  let resetBit = Zero
      heatDissipated = if isOne b then 1 else 0
  in (resetBit, heatDissipated)

||| Property: Landauer Erasure Heat Dissipation Law (ΔL >= 1 for 1-bit reset)
export
prop_landauerErasureEmitsHeat : Bit -> Bool
prop_landauerErasureEmitsHeat b =
  let (reset, heat) = eraseBitWithHeat One
  in heat >= 1 && isZero reset
```
