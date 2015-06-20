#!/usr/bin/env elixir

Code.require_file "lib/eux.ex"
Code.require_file "lib/fib_stream.ex"

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

FibStream.new 
  |> Stream.take_while(&(&1 <= max))
  |> Stream.filter(&(rem(&1,2) == 0)) 
  |> Enum.sum 
  |> P2.print(max)

# here is the short version
# Stream.resource(fn -> 0 end, 
#                 fn(0)       -> {[1], {0,1}}
#                   ({n0,n1}) -> {[n1], {n1, n0+n1}}
#                 end,
#                 fn(_) -> [] end)   |> 
#   Stream.take_while(&(&1 <= max))  |> 
#   Stream.filter(&(rem(&1,2) == 0)) |> 
#   Enum.sum 