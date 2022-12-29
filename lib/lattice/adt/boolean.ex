defmodule Lattice.ADT.Boolean do
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
