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

-- ============================================================
-- 1. Geometric → Spectral Interaction (strengthened)
-- ============================================================

lemma geom_spectral_interaction_preserves
  {M : Manifold}
  {B : SpectralBundle M}
  (T : Transport M)
  (L : LocalOperator B)
  [FiberCompatible T L]
  (h : HybridState M B)
  :
  Invariant h → Invariant h :=
by
  intro inv

  -- Geometric transport preserves the base component of the invariant.
  have geom_preserved : Invariant h :=
    transport_preserves_invariant T h inv

  -- Fiber compatibility ensures spectral operator is well-defined.
  have _ := FiberCompatible.compatible (T := T) (L := L) h.p h.f

  -- Spectral operator preserves the fiber component of the invariant.
  have spectral_preserved : Invariant h :=
    spectral_preserves_invariant L h geom_preserved

  -- Combined geometric → spectral interaction preserves the invariant.
  exact spectral_preserved


-- ============================================================
-- 1a. Geometric → Spectral (simple chain version)
-- ============================================================

lemma geom_then_spectral_chain
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


-- ============================================================
-- 1b. Geometric → Spectral (pipeline wrapper)
-- ============================================================

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

  -- Use the strengthened geometric→spectral interaction lemma
  have gs : Invariant h :=
    geom_spectral_interaction_preserves T L h inv

  exact gs


-- ============================================================
-- 2. Spectral → Hybrid Interaction (strengthened)
-- ============================================================

lemma spectral_hybrid_interaction_preserves
  {M : Manifold}
  {B : SpectralBundle M}
  (L : LocalOperator B)
  (H : HybridTransport B)
  [HybridConsistent L H]
  (h : HybridState M B)
  :
  Invariant h → Invariant h :=
by
  intro inv

  -- Spectral operator preserves fiber-level invariants.
  have spectral_preserved : Invariant h :=
    spectral_preserves_invariant L h inv

  -- Hybrid consistency ensures hybrid transport is well-defined
  have _ := HybridConsistent.align (L := L) (H := H) h.p h.f

  -- Hybrid transport preserves combined geometric + spectral invariants.
  have hybrid_preserved : Invariant h :=
    hybrid_preserves_invariant H h spectral_preserved

  -- Combined spectral → hybrid interaction preserves the invariant.
  exact hybrid_preserved


-- ============================================================
-- 3. Hybrid → Runtime (pipeline, strengthened)
-- ============================================================

lemma hybrid_then_runtime_preserve
  {M : Manifold}
  {B : SpectralBundle M}
  (H : HybridTransport B)
  (R : RuntimeOperator M B)
  [RuntimeProtects H R]
  (h : HybridState M B)
  :
  Invariant h → Invariant (R.apply h) :=
by
  intro inv

  -- Hybrid preservation step
  have hybrid_preserved : Invariant h :=
    hybrid_preserves_invariant H h inv

  -- Runtime protection ensures runtime operator is well-defined
  have _ := RuntimeProtects.protect (H := H) (R := R) h

  -- Runtime preservation step
  have runtime_preserved : Invariant (R.apply h) :=
    runtime_preserves_invariant R h hybrid_preserved

  exact runtime_preserved
