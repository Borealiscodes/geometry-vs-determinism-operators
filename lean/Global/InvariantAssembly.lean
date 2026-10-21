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

  -- Geometric preservation step
  have geom_preserved : Invariant h :=
    transport_preserves_invariant T h inv

  -- Spectral preservation step
  have spectral_preserved : Invariant h :=
    spectral_preserves_invariant L h geom_preserved

  exact spectral_preserved

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

  -- Spectral preservation step
  have spectral_preserved : Invariant h :=
    spectral_preserves_invariant L h inv

  -- Hybrid preservation step
  have hybrid_preserved : Invariant h :=
    hybrid_preserves_invariant H h spectral_preserved

  exact hybrid_preserved

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

  -- Hybrid preservation step
  have hybrid_preserved : Invariant h :=
    hybrid_preserves_invariant H h inv

  -- Runtime preservation step
  have runtime_preserved : Invariant (R.apply h) :=
    runtime_preserves_invariant R h hybrid_preserved

  exact runtime_preserved
