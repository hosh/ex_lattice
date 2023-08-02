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
    # Transitivity
    #   if x <= y && y <= z = True, then x <= z = True
    def transitivity(data) do
      a = generate(data)
      b = generate(data)
      c = generate(data)

      left = PartialOrd.lte?(a, b) && PartialOrd.lte?(b, c)
      right = PartialOrd.lte?(a, c)

      equal?(left, right)
    end


    # Reflexivity
    #   x <= x = True
    def reflexivity(data) do
      a = generate(data)

      equal?(PartialOrd.lte?(a, a), true)
    end

    # Antisymmetry
    #   if x <= y && y <= x = True, then x == y = True
    # Design Notes: Not sure we need to define this because
    # eq?() is defined as lte?(a, b) && lte?(b, a)
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


definst Lattice.PartialOrd, for: Integer do
  def lte?(a, %Lattice.DataTypes.Infinity{}), do: true
  def lte?(a, b), do: a <= b
end

definst Lattice.PartialOrd, for: Float do
  def lte?(a, %Lattice.DataTypes.Infinity{}), do: true
  def lte?(a, b), do: a <= b
end

definst Lattice.PartialOrd, for: Lattice.DataTypes.Infinity do
  alias Lattice.DataTypes.Infinity

  def lte?(%Infinity{}, %Infinity{}), do: true
  def lte?(_, %Infinity{}), do: true
  def lte?(%Infinity{}, _), do: false
end

definst Lattice.PartialOrd, for: Lattice.Datatypes.NegativeInfinity do
  alias Lattice.DataTypes.NegativeInfinity

  def lte?(NegativeInfinity{}, %NegativeInfinity{}), do: true
  def lte?(_, %NegativeInfinity{}), do: false
  def lte?(%NegativeInfinity{}, _), do: true
end

