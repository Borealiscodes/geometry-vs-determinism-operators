-- Geometry.Manifold
-- Basic manifold structure used throughout the spine.

structure Manifold :=
  (Point : Type)
  (Chart : Point → Type)
