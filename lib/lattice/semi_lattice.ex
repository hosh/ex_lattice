import TypeClass

defclass Lattice.Semilattice do
  @moduledoc ~S"""

  A semi-lattice is a semigroup that is also commutative and idempotent. An example
  is the maximum:

  lmax(1) <> lmax(2) <> lmax(5) <> lmax(3) == lmax(5)

  Semi-lattices are the basis for CDRTs and distributed data structures that are
  eventually-consistent.

  This is implemented as a join semi-lattice.

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

    # This is the least value or bottom of the set
    def least()
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

  @doc """
  Alias for `append/2`, meant to emphasize idempotency

  Examples:
     merge(lmax(4), lmax(5))
     lmax(5)

  TODO: Use examples from iex
  """
  defalias merge(a, b), as: :append
end

# Design Notes:
# Not sure if I should be wrapping Boolean. This can be done
# with bare Boolean, but does it make sense where <> (append)
# is logical or?
#
# Also, this is similar to empty/1 in Monoid. I am not sure of
# the purpose of a sample
#
# In the Bloom^L paper, the least element is defined as bottom
# value, so it is unwrapped.
definst Lattice.Semilattice, for: Lattice.ADT.Boolean do
  def least(), do: Lattice.ADT.Boolean.new(false)
  def append(a, b), do: a.value || b.value
end

definst Lattice.Semilattice, for: Boolean do
  def least(), do: false
  def append(a, b), do: a || b
end

