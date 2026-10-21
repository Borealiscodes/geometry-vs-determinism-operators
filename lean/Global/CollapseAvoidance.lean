import Geometry.Transport
import Spectral.LocalOperator
import Hybrid.HybridTransport
import Runtime.RuntimeOperator

-- Collapse avoidance theorem scaffold.
theorem collapse_avoidance
  {M : Manifold}
  {B : SpectralBundle M}
  (R : RuntimeOperator M B)
  : True :=
by
  admit
