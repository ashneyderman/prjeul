defmodule P15 do
  @moduledoc """
          0
        1   1
      1   2   1      
    1   3   3   1
      4   6   4
       10  10
         20
  """

  def expand(row, max, max), do: row
  def expand(prev, level, max) do
    new_row = [1 | (prev |> Enum.chunk(2, 1) 
                         |> Enum.map(fn([l,r]) -> l + r end) 
                         |> Enum.concat([1]))]
    expand(new_row, level + 1, max)
  end

  def shrink([_] = result), do: result
  def shrink(prev) do
    new_row = prev |> Enum.chunk(2,1)
                   |> Enum.map(fn([l,r]) -> l + r end)
    shrink(new_row)
  end
 
end