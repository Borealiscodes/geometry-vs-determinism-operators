import Geometry.Manifold
import Spectral.Bundle

-- Local linear operator acting on a fiber.
structure LocalOperator {M : Manifold} (B : SpectralBundle M) :=
  (op : Π p : M.Point, B.Fiber p → B.Fiber p)
  (bounded : Prop)
