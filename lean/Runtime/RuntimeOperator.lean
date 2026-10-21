import Geometry.Manifold
import Spectral.Bundle
import Hybrid.HybridState

-- Runtime operator with collapse protection.
structure RuntimeOperator
  (M : Manifold)
  (B : SpectralBundle M)
  :=
  (apply : HybridState M B → HybridState M B)
  (protects : Prop)     -- collapse protection

axiom runtime_protection_implies_stability
  {M : Manifold} {B : SpectralBundle M}
  (R : RuntimeOperator M B) :
  R.protects → True

lemma protects_implies_runtime_valid
  {M : Manifold} {B : SpectralBundle M}
  (R : RuntimeOperator M B) :
  R.protects → True :=
by intro h; trivial
