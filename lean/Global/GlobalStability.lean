import Geometry.Transport
import Spectral.LocalOperator
import Hybrid.HybridTransport
import Runtime.RuntimeOperator
import Runtime.Stability

-- Global stability theorem scaffold.
theorem global_stability
  {M : Manifold}
  {B : SpectralBundle M}
  (R : RuntimeOperator M B)
  : Stable R :=
by
  admit
