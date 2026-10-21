import Geometry.Transport
import Spectral.LocalOperator
import Hybrid.HybridTransport
import Runtime.RuntimeOperator

-- Invariant preservation theorem scaffold.
theorem invariant_preservation
  {M : Manifold}
  {B : SpectralBundle M}
  (R : RuntimeOperator M B)
  : True :=
by
  admit
