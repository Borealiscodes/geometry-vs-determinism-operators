-- Hybrid.HybridState
-- Hybrid state combining geometric and spectral components.

structure HybridState (M : Manifold) (B : SpectralBundle M) :=
  (p : M.Point)
  (v : B.Fiber p)
