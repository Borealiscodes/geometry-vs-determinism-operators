-- Runtime.RuntimeOperator
-- Runtime operator with collapse protection.

structure RuntimeOperator
  (M : Manifold)
  (B : SpectralBundle M)
  :=
  (apply : HybridState M B → HybridState M B)
