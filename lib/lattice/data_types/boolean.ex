defmodule Lattice.DataTypes.Boolean do
  @moduledoc """
  This is a boolean lattice.

  This is a wrapper around Boolean that can be equipped with a semi-lattice. It will
  monotonically flip from false to true.

  Short name: lbool
  Least element (⊥): false
  Merge: a ∨ b

  See: https://dsf.berkeley.edu/papers/socc12-blooml.pdf
  """

  import Algea

  defdata do
    value :: boolean() \\\\ false
  end
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
definst Lattice.Semilattice, for: Lattice.DataTypes.Boolean do
  def append(a, b), do: a.value || b.value
end

