import Global.GlobalInvariantPreservation
import Runtime.RuntimeOperator
import Global.InvariantStructure

/-
  Global Iteration Preservation Theorem

  If the global invariant is preserved by one full pipeline pass,
  then it is preserved by all iterates of the runtime operator.

  This lifts local drift-based preservation to infinite-horizon stability.
-/

theorem global_iteration_preservation
  {M : Manifold}
  {B : SpectralBundle M}
  (I : InvariantStructure B)
  (Rop : RuntimeOperator M B)
  :
  (∀ h : HybridState M B, I.runtime_safe h → I.runtime_safe (Rop.apply h)) →
  ∀ k : Nat, ∀ h : HybridState M B,
    I.runtime_safe h → I.runtime_safe (Nat.iterate Rop.apply k h) :=
by
  intro h_pres
  intro k
  induction k with
  | zero =>
      intro h hs
      -- Base case: 0 iterations, invariant is trivially preserved.
      simpa using hs
  | succ k ih =>
      intro h hs
      -- Inductive step:
      -- Assume invariant preserved for k iterations.
      have hs_k : I.runtime_safe (Nat.iterate Rop.apply k h) :=
        ih h hs
      -- Apply one more iteration using the local preservation lemma.
      have hs_k1 : I.runtime_safe (Rop.apply (Nat.iterate Rop.apply k h)) :=
        h_pres (Nat.iterate Rop.apply k h) hs_k
      simpa using hs_k1
