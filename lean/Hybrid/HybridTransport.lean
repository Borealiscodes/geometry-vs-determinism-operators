-- Hybrid.HybridTransport
-- Hybrid transport operator combining geometric and spectral effects.

structure HybridTransport
  (M : Manifold)
  (B : SpectralBundle M)
  :=
  (step : HybridState M B → HybridState M B)
