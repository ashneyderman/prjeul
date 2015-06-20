#!/usr/bin/env elixir

Code.require_file "lib/eux.ex"

defmodule Fib do
  def stream(max) do
    Stream.resource(fn -> 0 end,
      fn(0) -> {[0], {0,1}}
        ({n0, n1}) -> 
          if n0+n1 < max do
            {[n0+n1], {n1,n0+n1}}
          else
            {:halt, n1}
          end
      end,
      fn(_) -> [] end)
  end
end 

defmodule P2 do

  def print(r,max) do
    IO.puts "Sum of even fibonachi numbers not exceeding #{max}: #{r}"
  end

  def usage(_argv,errors) do
    IO.puts """
p2.exs: invalid option(s) -- #{Keyword.keys(errors)}
usage: p2.exs [-m <max>]

       -m, --max  fibonachi numbers below this max (default 4_000_000)
    """
    System.halt
  end

end

{params, _args} = Eux.params System.argv,  strict: [max: :integer],
                                          aliases: [m:   :max],
                                            usage: {P2, :usage}

max = params |> Keyword.get(:max, 4_000_000)

Fib.stream(max) |> Stream.filter(&(rem(&1,2) == 0)) |> Enum.sum |> P2.print(max)
