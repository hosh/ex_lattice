import TypeClass


defclass Lattice.Semilattice do
  @moduledoc ~S"""

  A semi-lattice is a semigroup that is also commutative and idempotent. An example
  is the maximum:

  lmax(1) <> lmax(2) <> lmax(5) <> lmax(3) == 5

  Semi-lattices are the basis for CDRTs and distributed data structures that are
  eventually-consistent.

  References:
  * https://en.wikipedia.org/wiki/Semilattice#Algebraic_definition
  * https://dsf.berkeley.edu/papers/socc12-blooml.pdf

  ## Type Class
  An instance of `Lattice.Semilattice` must define `Lettice.Semilattice.append/2`.
  Semilattice  [append/2]
  """

  alias __MODULE__

  where do
    # Design Notes: I am not sure if I should have this define a merge() instead
    # Semantically, "merge" describes semi-lattices better, and we don't have to
    # override append
    def append(a, b)
  end

  properties do
    def commutative(data) do
      a = generate(data)
      b = generate(data)

      left = a |> Semilattice.append(b)
      right = b |> Semilattice.append(a)

      equal?(left, right)
    end

    def idempotent(data) do
      a = generate(data)

      left = a
      right = a |> Semilattice.append(a)

      equal?(left, right)
    end
  end
end
