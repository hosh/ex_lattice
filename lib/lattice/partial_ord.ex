import TypeClass

defclass Lattice.PartialOrd do
  @moduledoc ~S"""

  This implements the partial order of the less-than-equal (<=) relation. It implements a
  subset of the Haskell Data.PartialOrd typeclass.

  References:
  * https://hackage.haskell.org/package/partial-order-0.2.0.0/docs/Data-PartialOrd.html
  * https://github.com/mtesseract/haskell-partial-order#readme
  * https://en.wikipedia.org/wiki/Partially_ordered_set

  ## Type Class
  An instance of `Lattice.PartialOrd` must define `Lettice.PartialOrd.lte/2`.
  Semilattice  [append/2]
  """

  alias __MODULE__

  where do
    def lte?(a, b)
  end

  properties do
  end

  @doc """
  In partial orders, eq? (`==`) is defined in terms of lte? (`<=`)
  """
  def eq?(a, b), do: lte?(a, b) && lte?(b, a)

  def gte?(a, b), do: lte?(b, a)

  def ne?(a, b), do: not eq?(a, b)

  def lt?(a, b), do: lte?(a, b) && ne?(a, b)

  def gt?(a, b), do: lte?(b, a) && ne?(a, b)
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
