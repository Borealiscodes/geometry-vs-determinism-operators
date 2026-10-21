import Geometry.Transport
import Spectral.LocalOperator
import Hybrid.HybridTransport
import Runtime.RuntimeOperator
import Global.Invariant
import Global.InvariantAssembly

/-
  Proof Strategy (Invariant Preservation):

  Goal:
    Show that the runtime operator R preserves the invariant encoded in HybridState.

  Structure:

    1. Identify the invariant:
       - The invariant is encoded jointly in the geometric component (M.Point)
         and the spectral fiber (B.Fiber p).
       - We treat it abstractly as a property of HybridState M B.

    2. Geometric Preservation:
       - Use Transport.step to show that the geometric component of the invariant
         is preserved under geometric transport.
       - R.apply uses geometric transport implicitly through HybridTransport.

    3. Spectral Preservation:
       - Use LocalOperator.op to show that the spectral component of the invariant
         is preserved under spectral action.
       - Boundedness ensures no collapse or distortion of the fiber invariant.

    4. Hybrid Consistency:
       - HybridTransport.step combines geometric and spectral effects.
       - Use H.consistent to show that the combined action preserves the invariant.

    5. Runtime Preservation:
       - R.apply uses HybridTransport internally.
       - Use R.protects to ensure invariant-preserving behavior is maintained
         under iteration.

    6. Conclusion:
       - The invariant is preserved globally under R.apply.
-/

theorem invariant_preservation
  {M : Manifold}
  {B : SpectralBundle M}
  (R : RuntimeOperator M B)
  : PreservesInvariant R :=
by
  intro h inv

  -- Step 1: geometric → spectral interaction
  have gs : Invariant h :=
    geom_spectral_interaction_preserves
      R.geom
      R.spec
      h
      inv

  -- Step 2: spectral → hybrid interaction
  have sh : Invariant h :=
    spectral_hybrid_interaction_preserves
      R.spec
      R.hyb
      h
      gs

  -- Step 3: hybrid → runtime preservation
  have hr : Invariant (R.apply h) :=
    hybrid_then_runtime_preserve
      R.hyb
      R
      h
      sh

  -- Final result: invariant preserved under R.apply
  exact hr
