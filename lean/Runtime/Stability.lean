import Runtime.RuntimeOperator

-- Stability predicate for runtime operators.
def Stable
  {M : Manifold}
  {B : SpectralBundle M}
  (R : RuntimeOperator M B)
  : Prop :=
  R.protects
