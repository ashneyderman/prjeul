#!/usr/bin/env elixir

Code.require_file "lib/eux.ex"
Code.require_file "lib/p15.ex"

usage = fn(_argv,errors) ->
  IO.puts """
p15.exs: invalid option(s) -- #{Keyword.keys(errors)}
usage: p15.exs [-d <dimension>]

       -d, --dimension  size of the lattice (default 20)     
  """
  System.halt
end

print = fn(result, max) ->
  result = hd(result)
  IO.puts  "Number of routes for #{max} by #{max} lattice: #{result}"
end

{params, _args} = Eux.params System.argv,  strict: [dimension: :integer],
                                          aliases: [d: :dimension],
                                            usage: {:function,usage}

n = params |> Keyword.get(:dimension, 20)
[1,1] |> P15.expand(1, n) |> P15.shrink |> print.(n)
