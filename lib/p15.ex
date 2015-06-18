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

  def solve(n) when n < 2, 
    do: raise(ArgumentError, message: "invalid argument n - has to be greater than 1")
  def solve(n) do
    [1,1] |> expand(1, n) |> shrink |> print(n)
  end

  defp expand(row, max, max), do: row
  defp expand(prev = state, level, max) do
    new_row = [1 | (prev |> Enum.chunk(2, 1) 
                         |> Enum.map(fn([l,r]) -> l + r end) 
                         |> Enum.concat([1]))]
    expand(new_row, level + 1, max)
  end

  defp shrink([_] = result), do: result
  defp shrink(prev) do
    new_row = prev |> Enum.chunk(2,1)
                   |> Enum.map(fn([l,r]) -> l + r end)
    shrink(new_row)
  end

  defp print(result, max) do
    result = hd(result)
    IO.puts  "Number of routes for #{max} by #{max} lattice: #{result}"
  end
 
end