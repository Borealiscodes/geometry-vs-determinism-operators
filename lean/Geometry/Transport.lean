-- Geometry.Transport
-- Geometric transport operator with curvature-controlled drift.

structure Transport (M : Manifold) :=
  (drift : M.Point → M.Point → Prop)
