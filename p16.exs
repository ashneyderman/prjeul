#!/usr/bin/env elixir

Code.require_file "lib/eux.ex"
Code.require_file "lib/p16.ex"

usage = fn(_argv,errors) ->
  IO.puts """
p16.exs: invalid option(s) -- #{Keyword.keys(errors)}
usage: p16.exs [-p <power>]

       -p, --power  power of 2 (default 1000)
  """
  System.halt
end

print = fn(r,p) ->
  IO.puts "Sum of digits for 2 of power #{p}: #{r}"
end

{params, _args} = Eux.params System.argv,  strict: [power: :integer],
                                          aliases: [p: :power],
                                            usage: {:function,usage}

p = params |> Keyword.get(:power, 1000)
P16.pow(2,p) |> P16.sdigs(0) |> print.(p)