import Geometry.Manifold
import Spectral.Bundle
import Hybrid.HybridState

/-- Abstract invariant predicate on HybridState. --/
def Invariant
  {M : Manifold}
  {B : SpectralBundle M}
  (h : HybridState M B)
  : Prop :=
  True

/-- Runtime operator preserves the invariant. --/
def PreservesInvariant
  {M : Manifold}
  {B : SpectralBundle M}
  (R : RuntimeOperator M B)
  : Prop :=
  ∀ h : HybridState M B, Invariant h → Invariant (R.apply h)
