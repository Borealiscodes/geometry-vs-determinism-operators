-- Spectral.Bundle
-- Spectral bundle: dependent type over the manifold.

structure SpectralBundle (M : Manifold) :=
  (Fiber : M.Point → Type)
