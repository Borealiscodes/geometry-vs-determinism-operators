import Global.Invariant
import Geometry.Transport
import Spectral.LocalOperator
import Hybrid.HybridTransport
import Runtime.RuntimeOperator

/-
  Assembly Lemmas for Invariant Preservation:

  These lemmas combine the local preservation results into
  a structured pipeline that the global invariant-preservation
  theorem will eventually use.
-/

lemma geom_then_spectral_preserve
  {M : Manifold}
  {B : SpectralBundle M}
  (T : Transport M)
  (L : LocalOperator B)
  (h : HybridState M B)
  :
  Invariant h → Invariant h :=
by
  intro inv
  -- geometric preservation
  have geom := transport_preserves_invariant T h inv
  -- spectral preservation
  have spec := spectral_preserves_invariant L h geom
  exact spec

lemma spectral_then_hybrid_preserve
  {M : Manifold}
  {B : SpectralBundle M}
  (L : LocalOperator B)
  (H : HybridTransport M B)
  (h : HybridState M B)
  :
  Invariant h → Invariant h :=
by
  intro inv
  -- spectral preservation
  have spec := spectral_preserves_invariant L h inv
  -- hybrid preservation
  have hyb := hybrid_preserves_invariant H h spec
  exact hyb

lemma hybrid_then_runtime_preserve
  {M : Manifold}
  {B : SpectralBundle M}
  (H : HybridTransport M B)
  (R : RuntimeOperator M B)
  (h : HybridState M B)
  :
  Invariant h → Invariant (R.apply h) :=
by
  intro inv
  -- hybrid preservation
  have hyb := hybrid_preserves_invariant H h inv
  -- runtime preservation
  have run := runtime_preserves_invariant R h hyb
  exact run
