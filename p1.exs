#!/usr/bin/env elixir

Code.require_file "lib/eux.ex"
Code.require_file "lib/numbers.ex"

usage = fn(_argv,errors) ->
    IO.puts """
p1.exs: invalid option(s) -- #{Keyword.keys(errors)}
usage: p1.exs [-m <max>]

       -m, --max  max number (default 1_000)
    """
  System.halt
end

print = fn(r,max) ->
  IO.puts "Sum of all the numbers disible by 3 or 5 below #{max}: #{r}"
end

{params, _args} = Eux.params System.argv,  strict: [max: :integer],
                                          aliases: [m:   :max],
                                            usage: {:function, usage}

max = params |> Keyword.get(:max, 1_000)

Numbers.by_3_and_5_stream
  |> Stream.take_while(&(&1 < max))
  |> Enum.sum
  |> print.(max)
