#!/usr/bin/env elixir

Code.require_file "lib/eux.ex"

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

  def print(result, max) do
    result = hd(result)
    IO.puts  "Number of routes for #{max} by #{max} lattice: #{result}"
  end

  def usage(_argv,errors) do
    IO.puts """
p15.exs: invalid option(s) -- #{Keyword.keys(errors)}
usage: p15.exs [-d <dimension>]

       -d, --dimension  size of the lattice (default 20)     
    """
    System.halt
  end
 
end

{params, _args} = Eux.params System.argv,  strict: [dimension: :integer],
                                          aliases: [d: :dimension],
                                            usage: {P15,:usage}

n = params |> Keyword.get(:dimension, 20)
[1,1] |> P15.expand(1, n) |> P15.shrink |> P15.print(n)
