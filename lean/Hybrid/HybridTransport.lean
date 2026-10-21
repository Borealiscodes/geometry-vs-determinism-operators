import Geometry.Manifold
import Spectral.Bundle
import Hybrid.HybridState

-- Hybrid transport operator combining geometric and spectral effects.
structure HybridTransport
  (M : Manifold)
  (B : SpectralBundle M)
  :=
  (step : HybridState M B → HybridState M B)
  (consistent : Prop)   -- hybrid consistency condition

axiom hybrid_consistency_respects_components
  {M : Manifold} {B : SpectralBundle M}
  (H : HybridTransport M B) :
  H.consistent → True
