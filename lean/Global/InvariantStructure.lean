import Geometry.Manifold
import Spectral.Bundle
import Hybrid.HybridTransport
import Runtime.RuntimeOperator

/-
  Invariant Structure

  This file defines the internal structure of the invariant tracked
  across geometric, spectral, hybrid, and runtime operators.

  The invariant is decomposed into four components:

    • geom_stable       — geometric stability of the base point
    • spectral_stable   — spectral stability of the fiber
    • hybrid_consistent — consistency of the hybrid state
    • runtime_safe      — safety under runtime iteration

  These are intentionally abstract placeholders. Later, they will be
  refined into actual geometric, spectral, hybrid, and runtime math.
-/

structure InvariantStructure {M : Manifold} (B : SpectralBundle M) :=
  (geom_stable       : M.Point → Prop)
  (spectral_stable   : ∀ p : M.Point, B.Fiber p → Prop)
  (hybrid_consistent : HybridState M B → Prop)
  (runtime_safe      : HybridState M B → Prop)


/-
  The invariant predicate combines all four structural components.

  This definition is the first place where the invariant gains
  internal structure. Operators will preserve each component
  individually, eventually yielding global preservation.
-/
def Invariant
  {M : Manifold}
  {B : SpectralBundle M}
  (S : InvariantStructure B)
  (h : HybridState M B)
  : Prop :=
  S.geom_stable h.p ∧
  S.spectral_stable h.p h.f ∧
  S.hybrid_consistent h ∧
  S.runtime_safe h


/-
  Convenience lemma: unpacking the invariant.
-/
lemma invariant_components
  {M : Manifold}
  {B : SpectralBundle M}
  {S : InvariantStructure B}
  {h : HybridState M B}
  :
  Invariant S h →
  S.geom_stable h.p ∧
  S.spectral_stable h.p h.f ∧
  S.hybrid_consistent h ∧
  S.runtime_safe h :=
by intro inv; exact inv
