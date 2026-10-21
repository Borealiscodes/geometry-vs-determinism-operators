import Geometry.Manifold
import Spectral.Bundle
import Hybrid.HybridState

-- Runtime operator with collapse protection.
structure RuntimeOperator
  (M : Manifold)
  (B : SpectralBundle M)
  :=
  (apply : HybridState M B → HybridState M B)
  (protects : Prop)
